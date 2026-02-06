---
layout: default
title: Triggers and Automation
---

# Triggers and Automation

Sandboxie supports lifecycle triggers that execute commands automatically when a sandbox goes through specific stages.

---

## Trigger Types

Configure triggers in **Sandbox Options** → **Advanced** → **Triggers**.

| Trigger | Fires When |
| :--- | :--- |
| **OnStart** | A program starts inside the sandbox |
| **OnAutoRun** | The sandbox initializes (before any user program) |
| **OnAutoExec** | The sandbox initializes; runs a batch file |
| **OnStop** | All programs in the sandbox have exited |
| **OnDelete** | The sandbox contents are about to be deleted |
| **OnFileRecovery** | A file is about to be recovered from the sandbox |

## Configuring Triggers

1. Open **Sandbox Options** → **Advanced** tab.
2. In the **Triggers** section, select a trigger type.
3. Enter the command or script to execute.
4. Click **Add**, then **OK**.

### Command Format

Triggers accept any executable command:

```
C:\Scripts\backup.bat
cmd.exe /c echo Sandbox started >> C:\log.txt
powershell.exe -File C:\Scripts\cleanup.ps1
```

Arguments and environment variables are supported.

## OnStart

Runs when the first process starts in the sandbox. Use this to launch companion programs or set up the environment.

**Example:** Start a VPN client whenever the browser sandbox activates:

```
OnStart=C:\VPN\vpn-connect.bat
```

## OnAutoRun

Registers a program that starts automatically when the sandbox initializes, before any user-launched program. This is useful for background services required by sandboxed applications.

**Example:** Start a local proxy server:

```
OnAutoRun=C:\Tools\proxy.exe --port 8080
```

## OnAutoExec

Runs a batch file during sandbox initialization. Use this for environment setup such as setting variables or creating directories.

**Example:**

```
OnAutoExec=C:\Scripts\setup-env.bat
```

The batch file runs inside the sandbox and its effects (file changes, environment variables) are isolated.

## OnStop

Runs when the last process in the sandbox exits. Use this for cleanup, logging, or notifications.

**Example:** Log the shutdown time:

```
OnStop=cmd.exe /c echo Sandbox closed at %TIME% >> C:\Logs\sandbox.log
```

## OnDelete

Runs just before sandbox contents are deleted. Use this to back up important files or perform a final scan.

**Example:** Copy logs before deletion:

```
OnDelete=cmd.exe /c copy "%SANDBOX%\logs\*" C:\Backup\
```

## OnFileRecovery

Runs when a file is about to be recovered from the sandbox. The command receives the file path as an argument and can cancel the recovery by returning a non-zero exit code.

**Example:** Scan recovered files with an antivirus:

```
OnFileRecovery=C:\AV\scan.exe "%1"
```

If the scan detects a threat (non-zero exit), the recovery is cancelled.

## Multiple Triggers

Multiple commands can be assigned to the same trigger. They execute in the order they are listed.

## Manual INI Configuration

Triggers can also be configured directly in `Sandboxie.ini`:

```ini
[SandboxName]
AutoExec=C:\Scripts\setup.bat
StartCommand=C:\Tools\companion.exe
StopCommand=C:\Scripts\cleanup.bat
```

See [Settings](settings.md) for INI editor details.
