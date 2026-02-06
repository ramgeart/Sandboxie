---
layout: default
title: Settings
---

# Settings

Sandboxie Plus has global settings that apply to the entire application and per-sandbox options. Configuration is stored in INI files that can be edited through the GUI or directly.

---

## Global Settings

Open **Settings** → **Global Settings** to configure application-wide options.

### General

| Option | Description |
| :--- | :--- |
| Start with Windows | Launch Sandboxie Plus at system startup |
| Show tray icon | Display the Sandboxie icon in the system tray |
| Close to tray | Minimize to tray instead of exiting |
| Always on top | Keep the main window above other windows |
| Show notifications | Display system tray notifications for events |

### Appearance

| Option | Description |
| :--- | :--- |
| Dark mode | Enable dark color scheme |
| Font | Select the UI font and size |
| DPI scaling | Adjust font scaling for high-DPI displays |

### Shell Integration

| Option | Description |
| :--- | :--- |
| Context menu | Enable/disable the **Run Sandboxed** context menu entry |
| Start menu integration | Add sandboxed shortcuts to the Windows Start menu |
| Desktop shortcuts | Create sandbox shortcut icons on the desktop |

### Updates

| Option | Description |
| :--- | :--- |
| Check frequency | How often to check for updates (daily, weekly, never) |
| Include preview builds | Receive insider/preview release notifications |

### Hotkeys

| Option | Description |
| :--- | :--- |
| Terminate all | Global hotkey to terminate all sandboxed processes |
| Suspend all | Global hotkey to suspend all sandboxed processes |

## Per-Sandbox Options

Right-click a sandbox → **Sandbox Options** to access per-box settings. These are organized into tabs described in [Sandbox Management](sandbox-management.md).

## Configuration Files

Sandboxie uses three INI configuration files:

| File | Contents |
| :--- | :--- |
| `Sandboxie.ini` | Core settings — sandbox definitions, access rules, triggers, driver configuration |
| `Templates.ini` | Template definitions used by all sandboxes |
| `Sandboxie-Plus.ini` | Plus UI settings — window position, appearance, hotkeys |

### File Locations

- **Installed mode**: Files are in the Sandboxie installation directory (e.g., `C:\Program Files\Sandboxie-Plus\`).
- **Portable mode**: Files are in the same directory as `SandMan.exe`.

## INI Editor

Sandboxie Plus includes a built-in INI editor with enhanced features:

1. Open **Settings** → **Edit Sandboxie.ini** (or Templates.ini or Sandboxie-Plus.ini).
2. The editor opens with the selected file.

### Editor Features

| Feature | Description |
| :--- | :--- |
| Syntax highlighting | INI keys, values, sections, and comments are color-coded |
| Auto-completion | Start typing a key name and press Tab to auto-complete from known settings |
| Tooltips | Hover over a key to see a description of what it does |
| Validation | Invalid or unrecognized keys are highlighted with a visual indicator |
| Search | Use Ctrl+F to search within the file |

### Common INI Settings

```ini
[GlobalSettings]
ForceProcess=firefox.exe

[DefaultBox]
Enabled=y
AutoDelete=y
BoxNameTitle=y
BorderColor=#00FFFF,ttl,6

[MySecureBox]
Enabled=y
UsePrivacyMode=y
UseSecurityMode=y
DropAdminRights=y
ClosedFilePath=%Personal%
```

### External Editor

Configure an external text editor to edit INI files instead of the built-in editor:

1. Open **Settings** → **Global Settings** → **General**.
2. Set the **External editor** path to your preferred editor (e.g., `notepad++.exe`).
3. When editing INI files, the external editor opens instead of the built-in one.

## Reloading Configuration

After editing INI files, reload the configuration without restarting:

1. Open **Settings** → **Reload Configuration**.
2. Sandboxie re-reads all INI files and applies changes.

## Locking Configuration

Prevent changes to the configuration:

1. Open **Settings** → **Lock Configuration**.
2. Set a password.
3. Configuration changes require the password until it is unlocked.

## Resetting Settings

To reset the Plus UI settings to defaults:

1. Open **Settings** → **Reset GUI Options**.
2. Confirm the reset.
3. Window positions, hidden messages, and UI preferences are restored to defaults.

Core sandbox settings in `Sandboxie.ini` are not affected by this reset.

## Driver and Service Management

Manage the Sandboxie kernel components through the **Maintenance** menu:

| Action | Description |
| :--- | :--- |
| Install driver | Register the Sandboxie kernel driver |
| Start driver | Load the driver into the kernel |
| Stop driver | Unload the driver |
| Uninstall driver | Remove the driver registration |
| Install service | Register the Sandboxie background service |
| Start/Stop service | Control the background service |
