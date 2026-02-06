---
layout: default
title: Snapshots
---

# Snapshots

Snapshots save a complete copy of a sandbox's state so you can restore it later. This is useful for creating a known-good baseline or reverting unwanted changes.

---

## Opening the Snapshot Manager

1. Right-click a sandbox in the main window.
2. Select **Snapshots** → **Manage Snapshots**.
3. The Snapshot Manager window opens, showing all existing snapshots as a tree.

## Creating a Snapshot

1. In the Snapshot Manager, click **Take Snapshot**.
2. Enter a name or description for the snapshot.
3. Click **OK**.

Sandboxie copies the current state of the sandbox — all files, registry changes, and metadata — into the snapshot. The sandbox remains operational during and after the snapshot.

## Restoring a Snapshot

1. In the Snapshot Manager, select the snapshot you want to restore.
2. Click **Restore Snapshot**.
3. Confirm the action.

All programs in the sandbox are terminated, the current sandbox data is replaced with the snapshot contents, and the sandbox is ready for use in its restored state.

> **Note:** Restoring a snapshot discards all changes made since the snapshot was taken. Recover any important files before restoring.

## Snapshot Tree

Snapshots are organized in a tree structure. Each snapshot records its parent, allowing you to see the history of changes:

```
DefaultBox
├── Clean Install          (base snapshot)
│   ├── After Updates      (taken after installing updates)
│   └── With Extensions    (taken after installing extensions)
```

You can restore any snapshot in the tree regardless of which branch was most recently active.

## Deleting a Snapshot

1. In the Snapshot Manager, select the snapshot.
2. Click **Delete Snapshot**.
3. Confirm the action.

Deleting a snapshot removes its stored data. Child snapshots that depend on the deleted snapshot are re-linked to preserve the tree structure.

## Use Cases

### Clean Browser Environment

1. Set up a browser sandbox with your preferred settings and extensions.
2. Take a snapshot called "Clean".
3. Browse the web freely.
4. Restore the "Clean" snapshot to revert the sandbox to its original state, removing all browsing data.

### Testing Software

1. Create a sandbox and take a baseline snapshot.
2. Install untrusted software inside the sandbox.
3. Test the software.
4. Restore the baseline snapshot to undo all changes made by the installer.

### Incremental Configurations

1. Take a snapshot after each configuration step.
2. If a later change causes problems, restore the last known-good snapshot and try again.
