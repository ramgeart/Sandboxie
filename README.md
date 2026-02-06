# Sandboxie

[![GitHub Release](https://img.shields.io/github/release/sandboxie-plus/Sandboxie.svg)](https://github.com/sandboxie-plus/Sandboxie/releases/latest) [![GitHub Build Status](https://github.com/sandboxie-plus/Sandboxie/actions/workflows/main.yml/badge.svg)](https://github.com/sandboxie-plus/Sandboxie/actions)

[![Roadmap](https://img.shields.io/badge/Roadmap-Link%20-blue?style=for-the-badge)](https://www.wilderssecurity.com/threads/updated-sandboxie-plus-roadmap.456886/) [![Join our Discord Server](https://img.shields.io/badge/Join-Our%20Discord%20Server%20for%20bugs,%20feedback%20and%20more!-blue?style=for-the-badge&logo=discord)](https://discord.gg/S4tFu6Enne)

Sandbox-based isolation software for Windows NT-based operating systems. It creates a secure, isolated virtual environment in which applications can be run or installed without permanently modifying local and mapped drives or the Windows registry.

**Note: This is a community fork that took place after the release of the Sandboxie source code and not the official continuation of the previous development (see the [project history](#project-history) and [#2926](https://github.com/sandboxie-plus/Sandboxie/issues/2926)).**

## Overview

Sandboxie intercepts system calls at the kernel level to redirect file system, registry, and other OS resource modifications into an isolated container (sandbox). This allows controlled testing of untrusted programs and web surfing while preserving host system integrity.

- Create virtually unlimited sandboxes, running them alone or simultaneously
- Isolate programs from the host and from each other
- Run multiple programs concurrently within a single sandbox

**System requirements:** Windows 7 or higher (64-bit)

## Download

[Latest Release](https://github.com/sandboxie-plus/Sandboxie/releases/latest)

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

## Useful Tools

- [LogApiDll](https://github.com/sandboxie-plus/LogApiDll) — verbose trace log output listing Windows API function invocations
- [SbieHide](https://github.com/VeroFess/SbieHide) — hides the presence of SbieDll.dll from sandboxed applications
- [SandboxToys2](https://github.com/blap/SandboxToys2) — monitors file and registry changes in a sandbox
- [Sbiextra](https://github.com/sandboxie-plus/sbiextra) — adds user mode restrictions to sandboxed processes

## Building

The project uses Visual Studio solution files:

- `Sandboxie/Sandbox.sln` — all core components (driver, service, DLL)
- `Sandboxie/SandboxDrv.sln` — driver only
- `Sandboxie/SandboxDll.sln` — DLL only
- `SandboxiePlus/SandboxiePlus.sln` — Plus UI (Qt)
- `SandboxieTools/SandboxieTools.sln` — tools (ImBox, UpdUtil)

<a id="project-history"></a>
## Project History

|      Timeline       |    Maintainer    |
|        :---         |       :---       |
| 2004 – 2013         | Ronen Tzur       |
| 2013 – 2017         | Invincea Inc.    |
| 2017 – 2020         | Sophos Group plc |
| April 2020 — [open-source release](https://community.sophos.com/sandboxie/f/forum/119641/important-sandboxie-open-source-code-is-available-for-download) | Sophos Ltd. |
| April 2020 onwards — community fork | David Xanatos |

## Documentation

- [User Guide](./docs/index.md) — comprehensive usage documentation
- [Online documentation](https://sandboxie-plus.github.io/sandboxie-docs)
- [Changelog](./CHANGELOG.md)
- [Contributing](./CONTRIBUTING.md)
- [Security policy](./SECURITY.md)
- [Code of conduct](./CODE_OF_CONDUCT.md)
