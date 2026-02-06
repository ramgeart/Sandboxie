---
layout: default
title: Import and Export
---

# Import and Export

Sandboxie supports importing and exporting sandboxes as compressed archives, making it easy to back up configurations or transfer sandboxes between systems.

---

## Exporting a Sandbox

1. Right-click a sandbox in the main window.
2. Select **Export Sandbox**.
3. Choose a destination folder and file name. The archive is saved as a `.7z` file.
4. Click **Save**.

The export includes:

- All files inside the sandbox
- Registry data
- Sandbox configuration (options, access rules, triggers)
- Snapshots (if present)

### Exporting Multiple Sandboxes

To export several sandboxes at once:

1. Select multiple sandboxes by holding **Ctrl** and clicking each one.
2. Right-click and select **Export Sandbox**.
3. Each sandbox is exported to its own `.7z` archive in the chosen folder.

## Importing a Sandbox

1. Open the **Sandbox** menu → **Import Sandbox**.
2. Browse to the `.7z` archive file.
3. Enter a name for the imported sandbox (or keep the original name).
4. Choose the target container folder where the sandbox data will be stored.
5. Click **OK**.

The sandbox appears in the main window with its original configuration, access rules, and data intact.

### Import Conflict Handling

If a sandbox with the same name already exists:

- Sandboxie prompts you to rename the imported sandbox.
- The existing sandbox is not overwritten.

## Backup Strategy

Use export/import for regular backups:

1. **Take a snapshot** of the sandbox to freeze its state.
2. **Export** the sandbox including the snapshot.
3. Store the `.7z` archive in a safe location (external drive, cloud storage).
4. To restore, **import** the archive on the same or a different system.

## Portable Transfer

Transfer a sandbox between computers:

1. Export the sandbox on the source machine.
2. Copy the `.7z` file to the target machine.
3. Import the archive on the target machine.
4. Adjust any system-specific paths in the sandbox options if needed.

## Archive Contents

The exported `.7z` archive is a standard 7-Zip file. You can inspect its contents with any 7-Zip compatible tool. The structure mirrors the sandbox directory layout:

```
SandboxName.7z
├── drive/          (file system data)
├── RegHive         (registry data)
├── Snapshots/      (snapshot data, if any)
└── BoxConfig.ini   (sandbox configuration)
```
