---
layout: default
title: Sandbox Management
---

# Sandbox Management

This page covers creating, configuring, grouping, and deleting sandboxes.

---

## Creating a Sandbox

1. Open the **Sandbox** menu → **Create New Box**, or right-click in the sandbox list and choose **Create New Box**.
2. Enter a unique name. Names may contain letters, digits, and underscores.
3. Select a **Box Type Preset** that defines the default security level:

| Preset | Description |
| :--- | :--- |
| Standard Sandbox | Default isolation; programs cannot modify the host file system or registry. |
| Hardened Sandbox | Restricts available syscalls and endpoint access for increased security. |
| Privacy Sandbox | Blocks read access to personal user data (Documents, Desktop, Downloads, etc.). |
| Confidential Sandbox | Encrypts all sandbox data with AES and requires a password to access. |
| Compartment Box | Application-level isolation with enhanced process separation. |

4. Click **OK** to create the sandbox.

## Sandbox Properties

Right-click a sandbox and choose **Sandbox Options** to open its settings. The options are organized into tabs:

| Tab | Purpose |
| :--- | :--- |
| General | Appearance (border color, icon), box type, autostart rules |
| Files | Copy rules, file migration size limits |
| Restrictions | Start/run restrictions, internet restrictions, drop rights |
| Network | Firewall rules, proxy, DNS (see [Network Features](network-features.md)) |
| Access | File, registry, IPC, COM, and window access rules (see [Access Control](access-control.md)) |
| Recovery | File recovery folders and exclusions (see [File Recovery](file-recovery.md)) |
| Advanced | Triggers, resource limits, debug options |
| Templates | Enable or disable compatibility templates |

## Box Appearance

Each sandbox can have a customized visual identity:

- **Border Color** — Set the color displayed around sandboxed windows. Click the color swatch in the General tab to pick a color.
- **Border Width** — Adjust the pixel width of the border.
- **Border Transparency** — Control the alpha transparency of the border overlay.
- **Custom Icon** — Assign a custom icon displayed in the sandbox list.
- **Title Prefix** — Optionally show the sandbox name in window title bars.

## Grouping Sandboxes

Organize sandboxes by creating groups in the main window:

1. Right-click in the sandbox tree and select **Create Group**.
2. Name the group and press Enter.
3. Drag sandboxes into the group to organize them.

Groups can be nested and collapsed or expanded via the right-click context menu.

## Moving a Sandbox

To relocate a sandbox data folder:

1. Terminate all programs running in the sandbox.
2. Right-click the sandbox → **Sandbox Options** → **General** tab.
3. Change the **Box Root Folder** to the target path.
4. Sandboxie moves the sandbox data to the new location.

## Deleting Sandbox Contents

1. Right-click the sandbox → **Delete Content**.
2. Confirm the action.

This removes all files and registry data inside the sandbox while preserving the sandbox configuration. The sandbox remains available for future use.

## Removing a Sandbox

1. Right-click the sandbox → **Remove Sandbox**.
2. Confirm removal.

This deletes both the sandbox data and its configuration entry. The action cannot be undone.

## Sandbox Information

Right-click a sandbox and select **Properties** to view:

- Total size of files inside the sandbox
- Number of files and folders
- Creation date
- Last access date

## Auto-Delete on Exit

To automatically wipe sandbox contents when all programs in it close:

1. Open **Sandbox Options** → **General** tab.
2. Enable **Auto-delete content when last process exits**.
3. Click **OK**.

When the last sandboxed process terminates, the sandbox data is wiped automatically after file recovery is offered.

## Multiple Sandboxes

You can create as many sandboxes as needed. Each sandbox is fully independent with its own:

- File system overlay
- Registry overlay
- Configuration and access rules
- Network rules
- Snapshots

Run programs in different sandboxes simultaneously to keep them isolated from each other.
