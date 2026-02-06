# Sandboxie

Sandbox-based isolation software for Windows NT-based operating systems. It creates a secure, isolated virtual environment in which applications can be run or installed without permanently modifying local and mapped drives or the Windows registry.

## Overview

Sandboxie intercepts system calls at the kernel level to redirect file system, registry, and other OS resource modifications into an isolated container (sandbox). This allows controlled testing of untrusted programs and web surfing while preserving host system integrity.

- Create virtually unlimited sandboxes, running them alone or simultaneously
- Isolate programs from the host and from each other
- Run multiple programs concurrently within a single sandbox

**System requirements:** Windows 7 or higher (64-bit)

## Architecture

| Component | Description |
| :--- | :--- |
| `Sandboxie/core/drv` | Kernel-mode driver — intercepts and redirects system calls |
| `Sandboxie/core/svc` | Service — manages sandbox operations and policies |
| `Sandboxie/core/dll` | User-mode DLL — injected into sandboxed processes |
| `Sandboxie/core/low` | Low-level hooking module |
| `SandboxiePlus/SandMan` | Qt-based UI (Plus edition) |
| `SandboxieTools/ImBox` | Encrypted sandbox image tool |
| `SandboxieTools/UpdUtil` | Update utility |

## Editions

Sandboxie is available in two editions that share the same core components and provide the same level of security and compatibility.

**Plus** — Modern Qt-based UI with full feature support:

- Snapshot manager for sandbox state backup and restore
- Privacy-mode sandboxes that protect user data from unauthorized access
- Security-enhanced sandboxes with restricted syscalls and endpoints
- Per-sandbox network firewall using Windows Filtering Platform (WFP)
- Encrypted sandbox storage (AES)
- SOCKS5 proxy enforcement and DNS control per sandbox
- Process memory and count limits per sandbox
- Import/export sandboxes as 7z archives
- Trigger system for sandbox lifecycle events
- Portable mode deployment

**Classic** — Legacy MFC-based UI with manual configuration via `Sandboxie.ini`.

## Building

The project uses Visual Studio solution files:

- `Sandboxie/Sandbox.sln` — all core components (driver, service, DLL)
- `Sandboxie/SandboxDrv.sln` — driver only
- `Sandboxie/SandboxDll.sln` — DLL only
- `SandboxiePlus/SandboxiePlus.sln` — Plus UI (Qt)
- `SandboxieTools/SandboxieTools.sln` — tools (ImBox, UpdUtil)

## Documentation

- [User Guide](./docs/index.md) — comprehensive usage documentation
- [Online documentation](https://sandboxie-plus.github.io/sandboxie-docs)
- [Changelog](./CHANGELOG.md)
- [Contributing](./CONTRIBUTING.md)
- [Security policy](./SECURITY.md)
- [Code of conduct](./CODE_OF_CONDUCT.md)

## License

- Plus edition: [LICENSE.Plus](./LICENSE.Plus)
- Classic edition: [LICENSE.Classic](./LICENSE.Classic)
