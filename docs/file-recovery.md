---
layout: default
title: File Recovery
---

# File Recovery

Programs running inside a sandbox create and modify files within the sandbox's isolated file system. File recovery lets you move those files back to the host system before the sandbox contents are deleted.

---

## How File Recovery Works

When a sandboxed program saves a file — for example, downloading a document in a browser — the file is stored inside the sandbox directory, not on the real file system. Recovery copies the file from the sandbox to its intended location on the host.

## Recovering Files Manually

1. Right-click a sandbox in the main window.
2. Select **Recover Files**.
3. The Recovery window shows files that can be recovered, organized by their original host path.
4. Select the files you want to keep.
5. Click **Recover to Same Folder** to place them in their original location, or **Recover to Any Folder** to choose a different destination.

## Quick Recovery

Quick Recovery watches specific folders for new or modified files and presents them for recovery:

1. Open **Sandbox Options** → **Recovery** tab.
2. Under **Quick Recovery Folders**, add the paths you want monitored. Common choices:
   - `%Desktop%`
   - `%Downloads%`
   - `%Documents%`
   - `%Favorites%`
3. When a file appears in one of these folders inside the sandbox, it is listed in the Quick Recovery panel.

## Immediate Recovery

When enabled, Sandboxie shows a recovery prompt as soon as a file is saved to a monitored folder, without waiting for sandbox termination:

1. In **Sandbox Options** → **Recovery**, enable **Immediate Recovery**.
2. Add folder paths to monitor.
3. When a sandboxed program saves a file to a monitored folder, a dialog appears immediately, offering to recover the file.

## Auto-Recovery on Sandbox Close

When the last sandboxed process exits, Sandboxie can automatically show the Recovery dialog:

1. In **Sandbox Options** → **Recovery**, enable **Auto-recovery on close**.
2. When all processes terminate, a dialog lists files eligible for recovery.
3. Choose which files to recover before the sandbox contents are deleted (if auto-delete is enabled).

## Recovery Exclusions

Prevent specific files or file types from appearing in recovery prompts:

1. In **Sandbox Options** → **Recovery** → **Exclusions**.
2. Add file paths, folder paths, or wildcard patterns. For example:
   - `*.tmp` — Exclude temporary files.
   - `%Temp%\*` — Exclude the temp directory.
3. Excluded files are not shown in recovery dialogs.

## Browsing Sandbox Contents

View all files inside a sandbox before recovering or deleting:

1. Right-click the sandbox → **Browse Content**.
2. A Windows Explorer window opens rooted at the sandbox directory.
3. You can manually copy files from here to any location.

## File Recovery Triggers

Use the `OnFileRecovery` trigger to run a custom check before files are recovered. This can be used to scan files with an antivirus or verify their integrity. See [Triggers and Automation](triggers-automation.md) for details.

## Recovery Log

Sandboxie maintains a log of recovered files. View it in the sandbox's **Recovery** panel to track what has been recovered and when.
