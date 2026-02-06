---
layout: default
title: Troubleshooting
---

# Troubleshooting

This page covers common issues, the built-in troubleshooting tools, and trace logging for diagnosing problems.

---

## Troubleshooting Wizard

Sandboxie Plus includes an interactive troubleshooting assistant:

1. Open **Help** → **Troubleshooting Wizard** (or right-click a sandbox → **Troubleshoot**).
2. Describe the problem or select from common scenarios.
3. The wizard suggests potential fixes such as:
   - Applying a compatibility template
   - Adjusting access rules
   - Updating driver or service components

## Common Issues

### Program Fails to Start in Sandbox

**Symptoms:** The program crashes, hangs, or shows an error immediately after launching.

**Solutions:**

1. **Apply a template** — Check if a compatibility template exists for the program in **Sandbox Options → Templates**.
2. **Check access rules** — The program may need access to specific files, registry keys, or IPC endpoints. Enable [trace logging](#trace-logging) and look for denied access entries.
3. **Disable security hardening** — If using a hardened sandbox, try a standard sandbox to see if the restrictions cause the failure.
4. **Update Sandboxie** — Newer versions include compatibility fixes for recent software updates.

### Browser Does Not Work Correctly

**Symptoms:** Pages fail to load, extensions are missing, or the browser crashes.

**Solutions:**

1. **Run the Browser Compatibility Wizard** — Go to **Tools → Browser Compatibility Wizard** and select the browser.
2. **Apply the browser template** — Enable the corresponding template (Firefox, Chrome, Edge, etc.) in sandbox options.
3. **Allow GPU access** — Some browsers require GPU process access. Check the template for GPU-related rules.

### Files Disappear After Closing Sandbox

**Symptoms:** Downloaded or created files are gone after the sandbox is closed.

**Solutions:**

1. **Recover files before closing** — Use the [File Recovery](file-recovery.md) feature to move files to the host.
2. **Enable auto-recovery** — Set up auto-recovery folders so Sandboxie prompts to recover files before deletion.
3. **Disable auto-delete** — If auto-delete is enabled, turn it off in **Sandbox Options → General** until you are sure all files are recovered.

### Network Access Blocked

**Symptoms:** Sandboxed programs cannot connect to the internet.

**Solutions:**

1. **Check firewall rules** — Review the sandbox firewall rules in **Sandbox Options → Network** (see [Network Features](network-features.md)).
2. **Check internet restrictions** — Verify the program is listed in the allowed internet access list under **Sandbox Options → Restrictions**.
3. **Check proxy settings** — If a proxy is configured, verify it is reachable.

### Sandboxie Service Not Running

**Symptoms:** Error message about the Sandboxie service not being available.

**Solutions:**

1. Open **Maintenance** → **Start Service**.
2. If the service fails to start, try **Maintenance** → **Install Service** first.
3. Check Windows Event Viewer for service error details.
4. Ensure no antivirus is blocking the Sandboxie service.

### Driver Issues

**Symptoms:** Sandboxie reports the driver is not loaded or out of date.

**Solutions:**

1. Open **Maintenance** → **Install Driver**, then **Start Driver**.
2. Reboot the system if the driver fails to load.
3. Ensure Secure Boot is not blocking unsigned drivers (Sandboxie's driver is signed).
4. Check that no other sandbox or virtualization software conflicts with the Sandboxie driver.

## Trace Logging

Trace logging records detailed information about all system calls made by sandboxed processes. Use it to diagnose access problems:

### Enabling Trace Logging

1. Open **Settings** → **Global Settings** → **Trace Logging**.
2. Enable the trace categories you need:
   - **File access** — Log file open, read, write operations.
   - **Registry access** — Log registry key access.
   - **IPC access** — Log named pipe, shared memory, and RPC access.
   - **Network access** — Log network connection attempts.
   - **Process events** — Log process creation and termination.
3. Click **OK**.

### Viewing the Trace Log

1. Expand a sandbox in the main window.
2. Select the **Trace Log** panel.
3. Each entry shows:
   - Timestamp
   - Process name and PID
   - Operation type (open, read, write, denied)
   - Resource path
   - Result (allowed, blocked, redirected)

### Filtering the Trace Log

- Use the search bar to filter by process name, path, or operation.
- Right-click a trace entry to add its path as an access rule directly.

### Exporting the Trace Log

1. Right-click the trace log panel.
2. Select **Export Log**.
3. Save the log as a text file for sharing or offline analysis.

## Window Finder

Identify whether a window belongs to a sandboxed process:

1. Open **Tools** → **Is Window Sandboxed?**
2. Click any window on screen.
3. A tooltip shows the sandbox name if the window is sandboxed, or "Not Sandboxed" otherwise.

## Message Log

Sandboxie logs system messages and errors in the **Messages** panel:

1. Open the **Messages** panel in the main window.
2. Review warnings and errors related to driver loading, configuration issues, or access denials.

Messages include error codes that can be searched in the [online documentation](https://sandboxie-plus.github.io/sandboxie-docs) for detailed explanations.

## Support Information

To gather system information for support requests:

1. Open **Help** → **Support Page**.
2. The page displays:
   - Sandboxie version
   - Windows version
   - Driver status
   - Hardware ID
3. Copy the information and include it in your support request.
