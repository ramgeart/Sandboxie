---
layout: default
title: Running Programs
---

# Running Programs

This page covers all the ways to launch and control programs inside a sandbox.

---

## Launching Programs

### From the Sandboxie Plus Window

1. Right-click a sandbox in the list.
2. Select **Run** and choose one of the quick-launch options:
   - **Run Web Browser** — Launches the default browser.
   - **Run Email Client** — Launches the default mail application.
   - **Run Explorer** — Opens Windows Explorer inside the sandbox.
   - **Run Command Prompt** — Opens `cmd.exe` inside the sandbox.
   - **Run Program…** — Browse to any executable.
   - **Run From Start Menu** — Opens a sandboxed Start menu.

### From the Context Menu

Right-click any executable, shortcut, or document in Windows Explorer and select **Run Sandboxed**. A dialog appears to let you pick the target sandbox.

This option is enabled by default during installation. You can toggle it in **Settings → Shell Integration**.

### From the Command Line

Use the Sandboxie Start command:

```
Start.exe /box:SandboxName ProgramPath [arguments]
```

Examples:

```
Start.exe /box:DefaultBox C:\Windows\notepad.exe
Start.exe /box:BrowserBox "C:\Program Files\Firefox\firefox.exe" https://example.com
```

### Double-Click Integration

Configure specific file types to always open inside a sandbox by setting up forced programs or using the **Run Sandboxed** shell integration.

## Forced Programs

Force specific executables to always run inside a designated sandbox, regardless of how they are started:

1. Open **Sandbox Options** for the target sandbox.
2. Go to the **Advanced** tab → **Forced Programs** section.
3. Click **Add Program** and browse to the executable.
4. Click **OK**.

From now on, whenever that executable launches — whether from the Start menu, a shortcut, or another program — it will automatically be redirected into the sandbox.

### Forced Directories

Instead of forcing individual executables, you can force an entire directory:

1. In the **Forced Programs** section, click **Add Folder**.
2. Select the directory.
3. Any executable started from within that directory tree will run in the sandbox.

## Identifying Sandboxed Programs

### Window Border

A colored border is drawn around the windows of sandboxed programs. The default color is yellow. You can customize:

- **Color** — Per sandbox in **Sandbox Options → General**.
- **Width** — Border thickness in pixels.
- **Transparency** — Alpha value for the border overlay.

### Title Indicator

Optionally display the sandbox name in the title bar of sandboxed windows. Enable this in **Sandbox Options → General** → **Show sandbox name in title**.

### Window Finder

Use **Tools → Is Window Sandboxed?** and then click any window on screen. A tooltip shows whether it is sandboxed and, if so, which sandbox it belongs to.

## Process Management

### Viewing Running Processes

Expand a sandbox in the main window to see all currently running processes. Each entry shows:

- Process name
- Process ID (PID)
- Status

### Terminating Programs

- **Single process** — Right-click a process and select **Terminate**.
- **All in sandbox** — Right-click the sandbox and select **Terminate All Programs**.
- **Global hotkey** — Press the configured hotkey to terminate all sandboxed processes across all sandboxes. Set the hotkey in **Settings → Global Settings**.

### Suspend and Resume

Right-click a sandbox and select **Suspend** to pause all processes inside it. Select **Resume** to continue execution.

## Start Restrictions

Control which programs are allowed to run inside a sandbox:

1. Open **Sandbox Options** → **Restrictions** tab.
2. Under **Start Restrictions**, add executables to the allow or deny list.
3. When restrictions are active, only explicitly allowed programs can start inside the sandbox.

## Breakout Programs

Allow specific programs started inside a sandbox to "break out" and run on the host:

1. In **Sandbox Options** → **Advanced** → **Breakout Programs**, add the executable.
2. When that program starts inside the sandbox, it runs unsandboxed while its child processes remain sandboxed.

## Leader Processes

Define a program as the "leader" of a sandbox session. When the leader process exits, all remaining processes in the sandbox are terminated automatically.

Configure this in **Sandbox Options** → **Advanced** → **Leader Process**.

## Drop Admin Rights

Run all programs inside a sandbox with reduced privileges:

1. In **Sandbox Options** → **Restrictions**, enable **Drop admin rights**.
2. All programs start with standard user privileges, even if the host user is an administrator.

## Internet Restrictions

Block or allow internet access for sandboxed programs:

1. In **Sandbox Options** → **Restrictions**, configure **Internet Access**.
2. Add programs to the allow list to grant network access, or leave the list empty and enable blocking to deny all network access.

See [Network Features](network-features.md) for firewall and proxy details.
