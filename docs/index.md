---
layout: default
title: Sandboxie User Guide
---

# Sandboxie User Guide

Sandboxie is a sandbox-based isolation software for Windows that creates secure, isolated environments where applications can run without permanently modifying the host system. It intercepts system calls at the kernel level to redirect file system, registry, and OS resource modifications into an isolated container.

---

## Table of Contents

1. [Getting Started](getting-started.md)
   Installation, first launch, and creating your first sandbox.

2. [Sandbox Management](sandbox-management.md)
   Creating, configuring, grouping, and deleting sandboxes.

3. [Running Programs](running-programs.md)
   Launching applications inside a sandbox, forced programs, and context menu integration.

4. [File Recovery](file-recovery.md)
   Recovering files created or modified inside a sandbox back to the host.

5. [Snapshots](snapshots.md)
   Saving and restoring sandbox states.

6. [Security Features](security-features.md)
   Privacy mode, security-hardened sandboxes, and encrypted sandboxes.

7. [Network Features](network-features.md)
   Per-sandbox firewall, SOCKS5 proxy, and DNS control.

8. [Resource Limits](resource-limits.md)
   Restricting memory, process count, and disk usage per sandbox.

9. [Access Control](access-control.md)
   Fine-grained rules for file, registry, IPC, COM, and window access.

10. [Triggers and Automation](triggers-automation.md)
    Executing commands on sandbox lifecycle events.

11. [Import and Export](import-export.md)
    Exporting sandboxes as archives and importing them on another system.

12. [Templates](templates.md)
    Applying and creating compatibility templates for applications.

13. [Settings](settings.md)
    Global settings, per-sandbox options, and the INI editor.

14. [Troubleshooting](troubleshooting.md)
    Common issues, the troubleshooting wizard, and trace logging.

---

## System Requirements

- Windows 7 or higher (64-bit)

## User Interface

Sandboxie provides a modern Qt-based graphical interface (SandMan) with full support for all features including snapshot management, privacy mode, encrypted sandboxes, network firewall, and more.
