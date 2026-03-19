# Arquitectura de Intercepción de Llamadas al Sistema a Nivel Kernel en Sandboxie

## Resumen Ejecutivo

Sandboxie implementa un sofisticado sistema de intercepción de llamadas al sistema (syscalls) a nivel de kernel para proporcionar aislamiento y seguridad. Este documento describe la arquitectura completa del flujo de intercepción, desde la inicialización del driver hasta la redirección runtime de syscalls en procesos sandboxeados.

## Arquitectura General

El sistema de intercepción de syscalls de Sandboxie opera en múltiples capas:

1. **Kernel Mode Driver (SbieDrv)** - Componente principal que ejecuta la intercepción
2. **User Mode Injection (SbieLow)** - Código inyectado en procesos sandboxeados
3. **Service Layer (SbieSvc)** - Gestiona la comunicación yinyección
4. **NTDLL Patching** - Modificación de stubs de syscalls en tiempo de ejecución

## Flujo de Inicialización del Driver

### 1. Driver Entry y Descubrimiento SSDT

```c
// driver.c:237
DriverEntry() 
└── Syscall_Init() // syscall.c:140
    ├── Syscall_Init_List() // syscall.c:142
    └── Syscall_Init_Table() // syscall.c:145
```

El proceso comienza durante la inicialización del driver donde se establece la infraestructura de intercepción de syscalls.

### 2. Descubrimiento de la System Service Descriptor Table (SSDT)

```c
// syscall_64.c:110
Syscall_GetMasterServiceTable()
├── MmGetSystemRoutineAddress() // syscall_64.c:145
│   └── get KeAddSystemServiceTable
├── Pattern match LEA/MOV // syscall_64.c:299
│   └── scan for SSDT reference
└── SSDT found // syscall_64.c:306
```

El driver localiza la SSDT en memoria kernel mediante pattern matching de instrucciones assembly que hacen referencia a la tabla.

## Construcción de la Tabla de Syscalls

### 1. Enumeración de Exportaciones NTDLL

```c
// syscall.c:227
Syscall_Init_List()
├── Dll_Load(Dll_NTDLL)
├── Scan ZwXxx exports // syscall.c:231
└── For each ZwXxx function:
    ├── Syscall_GetIndexFromNtdll() // syscall.c:309
    │   └── Parse MOV EAX opcode // syscall_64.c:647
    └── Syscall_GetKernelAddr() // syscall.c:319
        └── Lookup in SSDT // syscall_64.c:667
```

El driver escanea todas las exportaciones ZwXxx de NTDLL para construir una tabla completa de syscalls disponibles.

### 2. Mapeo de Índices a Direcciones Kernel

```c
// syscall_64.c:677
LONG_PTR EntryValue = (LONG_PTR)ShadowTable->Addrs[index];
*pKernelAddr = (UCHAR *)ShadowTable->Addrs + (EntryValue >> 4);
```

Cada syscall se mapea a su dirección kernel correspondiente utilizando la SSDT.

## Registro de Handlers Personalizados

### 1. Handlers de Syscalls Específicos

```c
// syscall.c:162
Syscall_Set1("DuplicateObject", Syscall_DuplicateHandle)
// syscall.c:531
entry->handler1_func = handler_func;
```

El driver registra handlers específicos para syscalls que requieren validación especial.

### 2. Handlers de Acceso a Objetos

```c
// syscall_open.c:55
Syscall_Set2(name, handler_func)
├── Syscall_GetByName(name) // syscall_open.c:57
├── entry->handler1_func = Syscall_OpenHandle // syscall_open.c:60
└── entry->handler2_func = handler_func // syscall_open.c:61
```

Para operaciones de manejo de objetos, se registra un handler genérico y uno específico del tipo de objeto.

## Inyección de Bajo Nivel en Procesos Sandboxed

### 1. Detección de Creación de Procesos

```c
// process.c:198
Process_CreateUserProcess intercepts
└── Process_Low_Inject called // process_low.c:158
    └── Api_SendServiceMessage(SVC_INJECT) // process_low.c:158
```

Cuando se crea un nuevo proceso sandboxed, el driver intercepta la creación y solicita la inyección.

### 2. Carga de SbieLow

```c
// lowlevel_inject.c:258
SbieDll_InjectLow_LoadLow loads code
├── Loads SbieLow binary from resources
└── Maps into target process memory
```

El servicio SbieSvc carga el código de inyección SbieLow en el espacio de direcciones del proceso destino.

### 3. Patching de NTDLL

```c
// init.c:369
InitSyscalls patches NTDLL
├── Calculate ZwXxx stub addresses // init.c:398
├── WriteMemorySafe patches stubs // init.c:257
│   └── Embed data pointer in stub // init.c:353
└── Redirect all syscalls to trampoline
```

SbieLow modifica los stubs de syscalls en NTDLL para redirigir todas las llamadas al sistema.

## Flujo de Intercepción Runtime

### 1. Estructura de Datos SbieLow

```c
// lowdata.h:84
typedef struct _SBIELOW_DATA {
    ULONG64     ntdll_base;
    ULONG64     syscall_data;
    ULONG64     api_device_handle; // lowdata.h:87
    ULONG       api_sbiedrv_ctlcode;
    ULONG       api_invoke_syscall;
    // ...
} SBIELOW_DATA;
```

SbieLow mantiene una estructura de datos con información necesaria para la comunicación con el driver.

### 2. Redirección de Syscalls

```c
// init.c:127
SbieApi_Ioctl() wrapper
└── NtDeviceIoControlFile call // init.c:125
```

Los stubs parcheados redirigen las llamadas a través de DeviceIoControl al driver kernel.

### 3. Dispatch en Kernel Mode

```c
// api.c:157
Api_FastIo_DEVICE_CONTROL()
└── routes to API function table
```

El driver maneja las solicitudes mediante Fast I/O dispatch.

## Validación y Ejecución de Syscalls

### 1. Procesamiento en el Driver

```c
// syscall.c:605
Syscall_Api_Invoke()
├── Validate caller is sandboxed // syscall.c:624
├── Extract syscall_index from parms[1] // syscall.c:627
├── Lookup entry = Syscall_Table[index] // syscall.c:678
├── Thread_SetThreadToken(proc) // syscall.c:700
│   └── Impersonate process token
└── Check handler registration // syscall.c:765
```

El driver valida la solicitud, busca la entrada apropiada y establece el contexto de seguridad.

### 2. Ejecución con Handlers

```c
// syscall.c:767
if (entry->handler1_func && !proc->open_all_nt)
    status = entry->handler1_func(proc, entry, user_args);
else
    status = Syscall_Invoke(entry, user_args); // syscall.c:771
        └── Sbie_InvokeSyscall_asm() // syscall.c:588
```

Si existe un handler personalizado, se invoca; de lo contrario, se llama directamente a la syscall del kernel.

### 3. Restauración del Contexto

```c
// syscall.c:939
Thread_ClearThreadToken()
└── Restore restricted token
```

Después de la ejecución, se restaura el token restringido del proceso sandboxed.

## Validación de Acceso a Objetos

### 1. Flujo de Validación de Handles

```c
// syscall_open.c:346
Syscall_OpenHandle entry
├── Syscall_ReplaceTargetHandle() // syscall_open.c:346
│   └── Redirect handle ptr to TLS slot // syscall_open.c:131
├── Syscall_Invoke() // syscall_open.c:360
│   └── Execute kernel syscall (handle→TLS)
├── Syscall_RestoreTargetHandle() // syscall_open.c:364
│   └── Extract handle from TLS // syscall_open.c:151
└── ObReferenceObjectByHandle() // syscall_open.c:389
    └── Get object pointer from handle
```

Para operaciones de handles, se utiliza un mecanismo de TLS (Thread Local Storage) para la validación.

### 2. Validación Específica de Objetos

```c
// syscall_open.c:398
Syscall_CheckObject()
├── Obj_GetNameOrFileName() // syscall_open.c:192
│   └── Retrieve object name/path
├── handler2_func() // syscall_open.c:209
│   └── Object-specific validation
│       (File_CheckFileObject, etc.)
└── Log access denial if needed // syscall_open.c:230
```

Se invoca el handler específico del tipo de objeto para validación detallada.

### 3. Manejo de Denegación

```c
// syscall_open.c:404
if (!NT_SUCCESS(status))
    NtClose(NewHandle);
```

Si la validación falla, se cierra el handle y se registra el evento.

## Componentes Clave del Sistema

### 1. Estructuras de Datos Principales

- **SYSCALL_ENTRY**: Entrada individual en la tabla de syscalls
- **SBIELOW_DATA**: Estructura de comunicación user-kernel
- **SERVICE_DESCRIPTOR**: Descriptor de la SSDT

### 2. Funciones Críticas

- **Syscall_Init()**: Inicialización del subsistema
- **Syscall_GetMasterServiceTable()**: Localización SSDT
- **Process_CreateUserProcess()**: Intercepción de creación de procesos
- **Syscall_Api_Invoke()**: Procesamiento runtime de syscalls
- **Syscall_OpenHandle()**: Validación de acceso a objetos

### 3. Mecanismos de Seguridad

- **Impersonación de tokens**: Elevación temporal de privilegios
- **Validación de handlers**: Verificación de permisos por objeto
- **TLS slot isolation**: Aislamiento de handles por thread
- **Log de denegaciones**: Auditoría de accesos bloqueados

## Flujo Completo de una Syscall Sandboxed

1. **Proceso sandboxed** realiza una syscall (ej. NtCreateFile)
2. **Stub parcheado** en NTDLL redirige a SbieLow
3. **SbieLow** empaqueta la solicitud y envía via DeviceIoControl
4. **SbieDrv** recibe la solicitud vía Fast I/O
5. **Driver** valida que el caller esté sandboxed
6. **Lookup** de la entrada en Syscall_Table
7. **Impersonación** del token del proceso
8. **Handler** específico (si existe) valida la operación
9. **Ejecución** de la syscall original del kernel
10. **Restauración** del token restringido
11. **Retorno** del resultado al proceso sandboxed

## Pipeline Completo de Inicialización del Driver

### 1. Secuencia de Inicialización del Driver

```c
// driver.c:173
DriverEntry() 
├── Driver_CheckOsVersion() // driver.c:191
├── Pool_Create() // driver.c:194
├── Driver_InitPublicSecurity() // driver.c:202
├── Driver_FindSystemRoot() // driver.c:215
├── Driver_FindHomePath() // driver.c:218
├── Initialize Core Modules:
│   ├── Obj_Init() // driver.c:228
│   ├── Conf_Init() // driver.c:231
│   ├── Dll_Init() // driver.c:234
│   ├── Syscall_Init() // driver.c:237
│   ├── Session_Init() // driver.c:240
│   ├── Token_Init() // driver.c:246
│   ├── Process_Init() // driver.c:255
│   │   └── PsSetCreateProcessNotifyRoutineEx() // process.c:151
│   ├── Thread_Init() // driver.c:258
│   ├── File_Init() // driver.c:261
│   │   └── FltRegisterFilter() // file_flt.c:154
│   ├── Key_Init() // driver.c:264
│   │   └── CmRegisterCallbackEx() // key_flt.c:128
│   ├── Ipc_Init() // driver.c:267
│   ├── Gui_Init() // driver.c:270
│   └── Api_Init() // driver.c:277
│       └── IoCreateDevice() // api.c:173
└── WFP_Init() // driver.c:284
```

El driver inicializa todos los subsistemas en secuencia, estableciendo la infraestructura completa de aislamiento.

### 2. Creación del Dispositivo API

```c
// api.c:173
IoCreateDevice()
├── RtlInitUnicodeString(&uni, API_DEVICE_NAME)
├── Create \Device\SandboxieDriverApi
└── Setup Fast I/O dispatch // api.c:157
    ├── Api_FastIoDispatch->FastIoDeviceControl
    └── Register API function handlers // api.c:190
```

Se crea el dispositivo de comunicación para interacción con user-mode.

## Sistema de Forzado de Procesos Sandboxed

### 1. Notificación de Creación de Procesos

```c
// process.c:151
PsSetCreateProcessNotifyRoutineEx(Process_NotifyProcessEx)
└── Process_NotifyProcessEx() callback // process.c:66
    └── Process_Create() // process.c:69
        └── Allocate PROCESS structure
```

El driver recibe notificaciones de todas las creaciones de procesos en el sistema.

### 2. Lógica de Decisión de Forzado

```c
// process_force.c:143
Process_GetForcedStartBox()
├── Check if already sandboxed
│   └── Process_CheckBoxPath() // process_force.c:261
│       └── verifies path in sandbox dir
├── Check ForceFolder rules
│   └── Process_CheckForceFolder() // process_force.c:277
│       └── matches path patterns
└── Check ForceProcess rules
    └── Process_CheckForceProcess() // process_force.c:281
        └── matches process name patterns
```

El sistema determina si un proceso debe ser forzado al sandbox basándose en configuración.

## Pipeline de Inyección y Hooking de Bajo Nivel

### 1. Secuencia de Inyección Completa

```c
// Driver Side
Process_Low_Inject() // process_low.c:94
├── Api_SendServiceMessage(SVC_INJECT_PROCESS) // process_low.c:158
└── KeWaitForSingleObject() // process_low.c:195
    └── wait for injection completion

// Service Side
DriverAssist::Thread() // DriverAssist.cpp:264
└── MsgWorkerThread() // DriverAssist.cpp:266
    └── InjectLow() // DriverAssistInject.cpp:53
        ├── InjectLow_OpenProcess() // DriverAssistInject.cpp:221
        ├── SbieDll_InjectLow() // DriverAssistInject.cpp:133
        └── SbieApi_Call(API_INJECT_COMPLETE) // DriverAssistInject.cpp:169

// Process Side
EntrypointC() // init.c:781
├── Init_Lock synchronization // init.c:827
├── PrepSyscalls() // init.c:846
├── InitSyscalls() // init.c:848
└── InitInject() // init.c:850
```

### 2. Hooking de Syscalls en NTDLL

```c
// init.c:848
InitSyscalls()
├── Iterate syscall_data table // init.c:391
├── Calculate ZwXxx address // init.c:398
├── Make memory writable // init.c:441
└── Write hook bytes // init.c:547
    ├── mov r10, syscall_num
    └── jmp SystemService
```

### 3. Preparación de Inyección de DLL

```c
// init.c:850
InitInject()
├── FindDllExport() // inject.c:352
│   └── RtlFindActCtx target
└── Install detour // inject.c:471
    └── jmp DetourFunc
```

## Sistema de Comunicación Driver-Servicio

### 1. Inicialización del Servicio

```c
// main.cpp:157
ServiceMain()
├── RegisterServiceCtrlHandlerEx() // main.cpp:159
├── DriverAssist::Initialize() // main.cpp:186
│   ├── InjectLow_Init() // DriverAssist.cpp:97
│   └── InitializePortAndThreads() // DriverAssist.cpp:100
│       ├── NtCreatePort() // DriverAssist.cpp:151
│       └── CreateThread() workers // DriverAssist.cpp:181
└── InitializePipe() // main.cpp:192
    └── PipeServer::GetPipeServer() // main.cpp:234
        ├── ProcessServer() // main.cpp:238
        ├── SbieIniServer() // main.cpp:239
        ├── ServiceServer() // main.cpp:240
        └── Other IPC servers
```

### 2. Comunicación LPC Bidireccional

```c
// Driver to Service
Api_SendServiceMessage() // process_low.c:158
└── NtRequestPort() to service

// Service to Driver
API_INJECT_COMPLETE handler
└── Process_Low_Api_InjectComplete() // process_low.c:234
    └── KeSetEvent() signals done // process_low.c:294
```

## Arquitectura de Redirección de Sistema de Archivos

### 1. Registro de Minifilter

```c
// file.c:196
File_Init()
└── p_File_Init_2() // file_flt.c:154
    └── FltRegisterFilter()
        └── Register minifilter callbacks
```

### 2. Handlers de Syscalls de Archivos

```c
// syscall.c:209
Syscall_Set1("DuplicateObject", Syscall_DuplicateHandle)
// syscall_open.c:55
Syscall_Set2(name, handler_func)
├── entry->handler1_func = Syscall_OpenHandle // syscall_open.c:60
└── entry->handler2_func = handler_func // syscall_open.c:61
```

### 3. Flujo de Validación de Archivos

```c
// syscall_open.c:71
Syscall_OpenHandle()
├── Syscall_ReplaceTargetHandle() // syscall_open.c:131
│   └── redirects handle to TLS
├── Syscall_Invoke() // syscall_open.c:360
│   └── NtCreateFile/NtOpenFile
├── Syscall_CheckObject() // syscall_open.c:192
│   └── handler2_func callback
│       └── File_CheckFileObject()
└── Syscall_RestoreTargetHandle() // syscall_open.c:142
```

## Filtrado de Objetos IPC via ObRegisterCallbacks

### 1. Registro de Callbacks del Object Manager

```c
// ipc.c:192
Ipc_Init()
└── Obj_Load_Filter() // obj_flt.c:82
    ├── Setup callback structures // obj_flt.c:135
    └── pObRegisterCallbacks() // obj_flt.c:141
```

### 2. Intercepción de Handles

```c
// obj_flt.c:178
Obj_PreOperationCallback()
├── Check if KernelMode (skip if true) // obj_flt.c:186
├── Extract DesiredAccess pointer // obj_flt.c:193
└── Dispatch by object type // obj_flt.c:221
    ├── PsProcessType branch // obj_flt.c:221
    │   └── Thread_CheckObject_CommonEx() // obj_flt.c:225
    └── PsThreadType branch // obj_flt.c:227
        └── Thread_CheckObject_CommonEx() // obj_flt.c:231
```

## Sistema de Configuración y Creación de Sandboxes

### 1. Lectura de Configuración

```c
// conf.c:214
Conf_Read()
├── Locate Sandboxie.ini path // conf.c:277
├── Stream_Open(Sandboxie.ini) // conf.c:279
└── Conf_Read_Sections() // conf.c:96
    └── Parse [BoxName] sections
```

### 2. Creación de Estructuras BOX

```c
// box.c:140
Box_CreateEx()
├── Box_Alloc() // box.c:82
├── Box_InitKeys() // box.c:213
└── Box_InitPaths() // box.c:275
    ├── Conf_Get("FileRootPath") // box.c:298
    ├── Box_ExpandString(FileRootPath) // box.c:312
    ├── Conf_Get("KeyRootPath") // box.c:344
    ├── Box_ExpandString(KeyRootPath) // box.c:348
    └── Conf_Get("IpcRootPath") // box.c:364
```

## Inicialización de DLL User-Mode y Hooks

### 1. Secuencia de Inyección de SbieDll

```c
// inject.c:76
DetourFunc()
├── Restore original function code // inject.c:109
├── LdrLoadDll("kernel32.dll") // inject.c:136
├── LdrLoadDll("SbieDll.dll") // inject.c:146
├── LdrGetProcedureAddress(ordinal 1) // inject.c:155
└── Call SbieDll ordinal 1 // inject.c:176
    └── Dll_Ordinal1() // dllmain.c:799
        └── Dll_InitInjected() // dllmain.c:839
```

### 2. Instalación de Hooks API

```c
// dllmain.c:839
Dll_InitInjected()
├── Query process info from driver // dllmain.c:284
├── Dll_InitPathList() // dllmain.c:426
├── Handle_Init() // dllmain.c:438
├── Obj_Init() // dllmain.c:441
├── Ipc_Init() // dllmain.c:472
├── Key_Init() // dllmain.c:480
├── File_Init() // dllmain.c:495
├── Secure_Init() // dllmain.c:500
├── Proc_Init() // dllmain.c:509
└── Ldr_Init() - last to initialize // dllmain.c:518
```

## Flujo Completo de Syscall de User-Mode a Kernel

### 1. Invocación de Syscall

```c
// SbieDll initialization
SbieDll_InjectLow_InitSyscalls() // sbiedll.h:229
└── Queries driver for syscall table

// Low-level data structure
SBIELOW_DATA.api_invoke_syscall // lowdata.h:88
└── Stores IOCTL code for syscalls

// Driver API setup
Api_FastIoDispatch setup // api.c:157
└── Registers FastIO handler
Api_SetFunction() // api.c:263
└── Maps IOCTL to Syscall_Api_Invoke
```

### 2. Ejecución de Syscall

```c
// syscall.c:605
Syscall_Api_Invoke()
├── Extract syscall_index // syscall.c:627
├── Get user_args pointer // syscall.c:712
├── Lookup syscall entry in table // syscall.c:678
├── Thread_SetThreadToken() elevation // syscall.c:700
└── Syscall_Invoke() // syscall.c:771
    └── Sbie_InvokeSyscall_asm() // syscall.c:588
```

## Descubrimiento de SSDT via Pattern Matching

### 1. Localización de Base del Kernel

```c
// syscall_64.c:136
Syscall_GetKernelBase()
└── Query SystemModuleInformation
    └── get ntoskrnl.exe base address
```

### 2. Análisis de KeAddSystemServiceTable

```c
// syscall_64.c:145
MmGetSystemRoutineAddress()
└── Get KeAddSystemServiceTable address
```

### 3. Pattern Matching Loop

```c
// syscall_64.c:269
Pattern matching loop
├── Parse LEA offset // syscall_64.c:217
├── Validate MOV match // syscall_64.c:234
└── Return table address // syscall_64.c:307
```

## Consideraciones de Diseño

### 1. Performance

- **Fast I/O**: Utiliza Fast I/O dispatch para minimizar overhead
- **Direct syscall**: Ejecución directa de syscalls kernel sin intermediarios
- **Minimal patching**: Solo se modifican los stubs esenciales en NTDLL

### 2. Seguridad

- **Kernel mode isolation**: Toda la validación ocurre en kernel mode
- **Token impersonation**: Elevación controlada y temporal de privilegios
- **Object-specific validation**: Validación granular por tipo de objeto

### 3. Compatibilidad

- **SSDT discovery**: Localización dinámica de la tabla de servicios
- **Pattern matching**: Adaptación a diferentes versiones de Windows
- **Multi-architecture**: Soporte para x86, x64, y ARM64

### 4. Arquitectura Multi-Capa

- **Kernel Layer**: Driver SbieDrv.sys con intercepción SSDT
- **Service Layer**: SbieSvc.exe con gestión de inyección y comunicación
- **User Layer**: SbieDll.dll con hooks API de alto nivel
- **Low-Level Layer**: SbieLow.dll con patching de NTDLL
- **Filter Layer**: Minifilters y ObCallbacks para redirección

### 5. Mecanismos de Aislamiento

- **Process Isolation**: Forzado y tracking de procesos sandboxed
- **File System Isolation**: Redirección a sandbox paths
- **Registry Isolation**: Hive virtualizado para claves del registro
- **IPC Isolation**: Filtrado de handles entre procesos
- **Network Isolation**: Control de acceso a recursos de red

### 6. Pipeline de Comunicación

- **Driver ↔ Service**: LPC port para mensajería síncrona
- **Service ↔ Process**: Named pipes para comunicación user-mode
- **Process ↔ Driver**: IOCTL via Fast I/O para syscalls
- **UI ↔ Driver**: API calls para gestión de sandboxes

## Conclusión

La arquitectura de intercepción de syscalls de Sandboxie representa un enfoque sofisticado y robusto para el aislamiento de procesos. Al operar a nivel de kernel y utilizar mecanismos de bajo nivel como la SSDT y el patching de NTDLL, Sandboxie logra un control granular sobre todas las operaciones del sistema realizadas por procesos sandboxeados, manteniendo al mismo tiempo la compatibilidad y performance del sistema.

El diseño multi-capa con componentes especializados en cada nivel (kernel driver, servicio, DLL injection, y hooks) permite un sandboxing efectivo sin comprometer la funcionalidad de las aplicaciones, proporcionando una capa de seguridad transparente pero poderosa para el aislamiento de código potencialmente malicioso.

Este arquitectura ha demostrado ser altamente efectiva en la práctica, soportando una amplia gama de aplicaciones y escenarios de uso mientras mantiene la compatibilidad con el ecosistema Windows existente.
