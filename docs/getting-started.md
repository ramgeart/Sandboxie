---
layout: default
title: Getting Started
---

# Getting Started

This guide walks you through installing Sandboxie, launching it for the first time, and running your first sandboxed application.

---

## Downloading Sandboxie

Download the latest installer from the [Releases page](https://github.com/sandboxie-plus/Sandboxie/releases/latest). Two installer types are available:

| File | Description |
| :--- | :--- |
| `Sandboxie-Plus-x64-vX.X.X.exe` | Full installer for 64-bit Windows |
| `Sandboxie-Plus-ARM64-vX.X.X.exe` | Installer for ARM64 Windows |

## Installation

1. Run the downloaded installer.
2. Follow the on-screen prompts to accept the terms and choose an install directory.
3. The installer registers the Sandboxie kernel driver and background service automatically.
4. After installation completes, launch **Sandboxie Plus** from the Start menu or desktop shortcut.

### Portable Mode

If you prefer a portable deployment that does not modify the system registry:

1. Run the installer.
2. Select **Extract to directory** instead of a full install.
3. All files are placed in the chosen folder. Run `SandMan.exe` directly from that location.

Portable mode stores all configuration and sandbox data alongside the executable.

## First Launch — Setup Wizard

On first launch, Sandboxie Plus displays a **Setup Wizard** that walks you through initial configuration:

1. **UI Preset** — Choose between a simple or advanced interface layout.
2. **Shell Integration** — Enable or disable the right-click **Run Sandboxed** context menu entry.
3. **Software Compatibility** — Apply recommended templates for your installed browsers and applications.

You can re-run the wizard later from the **Help** menu.

## Creating Your First Sandbox

Sandboxie creates a default sandbox named `DefaultBox` on first launch. To create an additional sandbox:

1. Open the **Sandbox** menu and select **Create New Box**.
2. Enter a name for the sandbox.
3. Select a sandbox type preset:
   - **Standard Sandbox** — Default isolation suitable for most applications.
   - **Hardened Sandbox** — Increased restrictions on syscalls and endpoints.
   - **Privacy Sandbox** — Blocks access to personal user data (Documents, Downloads, etc.).
   - **Confidential Sandbox** — Encrypts all data inside the sandbox with AES.
4. Click **OK** to create the sandbox.

The new sandbox appears in the main window and is ready to use.

## Running a Program in the Sandbox

There are several ways to launch a program inside a sandbox:

### From the Sandboxie Window

1. Right-click a sandbox in the list.
2. Select **Run** → choose from the quick-launch list or select **Run Program…** and browse to an executable.

### From the Desktop or File Explorer

1. Right-click any `.exe` file or shortcut.
2. Select **Run Sandboxed** from the context menu.
3. Choose the target sandbox from the list and click **OK**.

### Identifying Sandboxed Windows

When a program runs inside a sandbox, its window displays a colored border (yellow by default). This helps distinguish sandboxed windows from normal ones. The border color and transparency can be customized per sandbox.

## Terminating Sandboxed Programs

To stop all programs running in a sandbox:

1. Right-click the sandbox in the main window.
2. Select **Terminate All Programs**.

Alternatively, use the global hotkey (configurable in **Settings → Global Settings**) to terminate all sandboxed processes across all sandboxes at once.

## Deleting Sandbox Contents

After finishing a sandboxed session you can wipe the sandbox:

1. Right-click the sandbox.
2. Select **Delete Content**.
3. Confirm the deletion.

This removes all files created or modified inside the sandbox, restoring it to a clean state. Any files you want to keep should be [recovered](file-recovery.md) first.

## Next Steps

- [Sandbox Management](sandbox-management.md) — Learn how to configure sandbox options.
- [Running Programs](running-programs.md) — Advanced launch options and forced programs.
- [File Recovery](file-recovery.md) — Retrieve files from inside a sandbox.
