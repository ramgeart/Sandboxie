# Guía de Eliminación de Sistema de Licencias - Sandboxie Plus

## Resumen

Aunque eliminaste el sistema de licencias de pago, quedan múltiples referencias en el código que deben ser limpiadas para una eliminación completa.

## Archivos Clave a Modificar

### 1. UI Principal - SettingsWindow.cpp

**Archivo**: `/SandboxiePlus/SandMan/Windows/SettingsWindow.cpp`

**Funciones a eliminar/modificar**:
- `OnStartEval()` (línea ~3030)
- `StartEval()` (línea ~3035) 
- `ApplyCert()` (línea ~3077)
- `GetCertType()` (línea ~3119)

**Secciones a eliminar**:
```cpp
// Líneas 3000-3012: Validación de certificados
if (Serial.length() > 5 && Serial.at(4).toUpper() == 'U') {
    Message = tr("You are attempting to use a feature Upgrade-Key...");
    // ... eliminar esta lógica
}

// Líneas 3030-3050: Funciones de evaluación
void CSettingsWindow::OnStartEval() { ... } // eliminar
void CSettingsWindow::StartEval() { ... } // eliminar
```

### 2. Archivos de Traducción

**Archivos**: `sandman_*.ts` (todos los idiomas)

**Textos a eliminar**:
- "evaluation certificate"
- "premium features" 
- "trial period"
- "supporter certificate"
- "Get a free evaluation certificate"

**Ejemplo de búsqueda y reemplazo**:
```xml
<!-- Eliminar estas entradas -->
<message>
    <source>Get a free evaluation certificate</source>
    <translation>...</translation>
</message>
```

### 3. CHANGELOG.md

**Secciones a limpiar**:
- Referencias a "certificate", "evaluation", "supporter"
- Menciones de "business certificate"
- "evaluation period"

### 4. Archivos de Licencia

**Archivos**: `LICENSE.Plus`, `SandboxiePlus/LICENSE`

**Modificar**:
- Eliminar referencias a "evaluation purposes"
- Remover mención de "business certificate"
- Simplificar a solo licenciamiento GPL/LGPL

### 5. Wizards/SetupWizard.cpp

**Funciones a modificar**:
- Diálogos de certificado de soporte
- Páginas de evaluación
- Asistente de configuración

## Proceso de Limpieza Recomendado

### Paso 1: Eliminar Lógica de Certificados

```cpp
// En SettingsWindow.cpp - eliminar o comentar
void CSettingsWindow::OnStartEval() {
    // Eliminar completamente esta función
}

void CSettingsWindow::ApplyCert() {
    // Simplificar para no validar certificados
    // O eliminar si no se necesita validación alguna
}
```

### Paso 2: Limpiar UI de Certificados

```cpp
// En el constructor de SettingsWindow
// Eliminar botones y campos relacionados con certificados
ui.btnGetCert->setVisible(false);
ui.txtCertificate->setVisible(false);
ui.lblCertInfo->setVisible(false);
```

### Paso 3: Actualizar Archivos de Traducción

**Script de limpieza**:
```bash
# Buscar y eliminar entradas de evaluación
grep -l "evaluation certificate" SandMan/translations/*.ts
# Editar cada archivo y eliminar las entradas encontradas
```

### Paso 4: Modificar Validaciones

```cpp
// Eliminar checks de certificado en funciones de características
// Por ejemplo, en OptionsGeneral.cpp
// if (!HasCertificate()) return; // eliminar estos checks
```

### Paso 5: Actualizar Documentación

**Modificar**:
- `README.md`: Eliminar referencias a certificados
- `LICENSE.Plus`: Simplificar términos de licenciamiento
- `CHANGELOG.md`: Limpiar historial de certificados

## Archivos Específicos a Modificar

### Core Settings Window
```
/SandboxiePlus/SandMan/Windows/SettingsWindow.cpp
/SandboxiePlus/SandMan/Windows/SettingsWindow.h
```

### Translation Files
```
/SandboxiePlus/SandMan/translations/sandman_*.ts
```

### Wizard Files
```
/SandboxiePlus/SandMan/Wizards/SetupWizard.cpp
/SandboxiePlus/SandMan/Wizards/SetupWizard.h
```

### License Files
```
/SandboxiePlus/LICENSE
/LICENSE.Plus
```

### Documentation
```
CHANGELOG.md
README.md
```

## Verificación Post-Limpieza

### 1. Compilar y Testear
```bash
# Compilar el proyecto
# Verificar que no queden referencias a certificados
grep -r "certificate\|evaluation\|trial" --include="*.cpp" --include="*.h"
```

### 2. Testear Funcionalidad
- Abrir Settings Window
- Verificar que no aparezcan opciones de certificado
- Probar todas las características sin restricciones

### 3. Verificar Traducciones
- Abrir la aplicación en diferentes idiomas
- Confirmar que no aparezcan textos de licenciamiento

## Advertencias Importantes

1. **Backup**: Hacer backup completo antes de modificar
2. **Testing**: Probar exhaustivamente después de cada cambio
3. **Dependencies**: Algunas características pueden depender de la validación de certificados
4. **User Experience**: Asegurar que la eliminación no rompa el flujo de usuario

## Resultado Esperado

Después de la limpieza completa:
- No debería haber mención de certificados en la UI
- Todas las características deberían estar disponibles sin restricciones
- Los archivos de traducción no deberían contener textos de licenciamiento
- La compilación debería ser limpia sin warnings de certificados

Esta guía proporciona un roadmap completo para eliminar todos los residuos del sistema de licenciamiento de Sandboxie Plus.
