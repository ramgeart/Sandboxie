---
layout: default
title: Access Control
---

# Access Control

Sandboxie provides fine-grained rules for controlling how sandboxed programs interact with files, registry keys, IPC objects, COM objects, and windows.

---

## Overview

By default, sandboxed programs can read from the host system but all writes are redirected into the sandbox. Access rules let you tighten or relax this behavior for specific paths and resources.

## Rule Types

Each resource category supports the same four access levels:

| Level | Behavior |
| :--- | :--- |
| **Open** | Full read and write access to the host resource. Changes are made directly on the host — not isolated. |
| **Read** | Read-only access to the host resource. Writes are redirected to the sandbox. |
| **Write** | Write-only access. The resource can be modified on the host but not read. |
| **Closed** | All access is blocked. The resource appears to not exist for the sandboxed program. |

## File Access Rules

Control access to files and directories on the host file system:

1. Open **Sandbox Options** → **Access** tab → **Files**.
2. Click **Add** and choose the access level.
3. Enter the file or directory path. Environment variables and wildcards are supported:
   - `%Desktop%` — User's desktop folder
   - `%Documents%` — User's documents folder
   - `C:\Shared\*` — All files under `C:\Shared`
4. Optionally restrict the rule to a specific program.
5. Click **OK**.

### Examples

| Rule | Effect |
| :--- | :--- |
| Open `%Downloads%` | Downloaded files are saved directly to the host Downloads folder. |
| Closed `%Documents%` | Sandboxed programs cannot see the Documents folder. |
| Read `C:\Data\*` | Programs can read files in `C:\Data` but writes go to the sandbox. |

## Registry Access Rules

Control access to Windows registry keys:

1. Open **Sandbox Options** → **Access** tab → **Registry**.
2. Add rules with registry key paths:
   - `HKLM\Software\MyApp` — A specific application key.
   - `HKCU\Software\*` — All keys under the current user's software hive.
3. Set the access level (Open, Read, Write, or Closed).

### Common Uses

- **Open** a registry key to let an application store its settings on the host.
- **Close** registry keys that contain sensitive data (e.g., browser profiles, credentials).

## IPC Access Rules

Inter-Process Communication rules control access to named pipes, mail slots, shared memory, and other IPC mechanisms:

1. Open **Sandbox Options** → **Access** tab → **IPC**.
2. Add rules with IPC object paths:
   - `\RPC Control\*` — RPC endpoints.
   - `\BaseNamedObjects\*` — Named kernel objects.
3. Set the access level.

### When to Adjust IPC Rules

Some applications require IPC access to function correctly. If a sandboxed application fails to communicate with a host service, try adding an **Open** rule for the specific IPC path shown in the [trace log](troubleshooting.md).

## COM Access Rules

Control access to COM (Component Object Model) objects:

1. Open **Sandbox Options** → **Access** tab → **COM**.
2. Add rules by COM class name or CLSID:
   - `{CLSID-GUID}` — A specific COM class.
   - `*` — All COM classes.
3. Set the access level.

### COM Proxy

By default, some COM objects are accessed through the Sandboxie service (COM proxy). Disable COM proxying in specific cases where direct access is needed:

- In **Sandbox Options** → **Access** → **COM**, uncheck **Use COM proxy through service**.

## Window Access Rules

Control which window classes sandboxed programs can interact with:

1. Open **Sandbox Options** → **Access** tab → **Windows**.
2. Add rules by window class name.
3. Set Open or Closed access.

This is primarily used to allow or block specific cross-process window messaging.

## Per-Program Rules

All access rules can be scoped to a specific program:

1. When adding a rule, select a program from the **Program** dropdown.
2. The rule applies only when that program attempts the access.
3. Programs not matched by any per-program rule fall back to the general rules.

This enables scenarios like allowing a browser to write to the Downloads folder while blocking all other programs from accessing it.

## Viewing Effective Rules

To see which rules apply to a specific program:

1. Open **Sandbox Options** → **Access** tab.
2. Select the program from the filter dropdown at the top.
3. The list shows only rules that affect the selected program.
