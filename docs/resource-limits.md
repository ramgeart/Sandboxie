---
layout: default
title: Resource Limits
---

# Resource Limits

Sandboxie can restrict the system resources available to processes inside a sandbox, preventing sandboxed programs from consuming excessive memory, spawning too many processes, or using too much disk space.

---

## Memory Limits

Restrict the amount of physical memory a sandbox can use:

1. Open **Sandbox Options** → **Advanced** tab.
2. Under **Resource Limits**, configure:
   - **Per-process memory limit** — Maximum memory a single sandboxed process can allocate.
   - **Total memory limit** — Maximum memory all processes in the sandbox can use combined.
3. Set the value in megabytes.
4. Click **OK**.

When a process exceeds its memory limit, further memory allocations are denied. The process may terminate or degrade depending on how it handles allocation failures.

## Process Count Limits

Limit the total number of processes that can run simultaneously inside a sandbox:

1. In **Sandbox Options** → **Advanced** → **Resource Limits**.
2. Set **Max process count** to the desired number.
3. Click **OK**.

When the limit is reached, new process creation inside the sandbox is blocked. This prevents fork-bomb attacks or runaway process spawning.

## Disk Usage Monitoring

While there is no hard disk space quota enforced by the driver, you can monitor sandbox size:

1. Right-click a sandbox → **Properties** to view current disk usage.
2. Set up auto-delete to remove sandbox contents when programs close, keeping disk usage low.

For strict disk space control, use [encrypted sandboxes](security-features.md) with a fixed-size container image.

## Use Cases

### Untrusted Software Testing

Set conservative memory and process limits to prevent untrusted software from overwhelming the system:

- Per-process memory: 512 MB
- Total memory: 1024 MB
- Max processes: 10

### Browser Sandboxing

Browsers can spawn many processes (one per tab). Set a process limit to control tab proliferation:

- Max processes: 20–50 (depending on expected tab count)

### Preventing Resource Abuse

Block crypto miners or other resource-intensive malware from consuming all available resources by setting low memory and process limits.
