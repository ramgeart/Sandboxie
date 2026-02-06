---
layout: default
title: Security Features
---

# Security Features

Sandboxie provides multiple layers of security beyond basic file and registry isolation. This page covers privacy mode, security-hardened sandboxes, and encrypted sandboxes.

---

## Standard Isolation

All sandboxes, regardless of type, provide:

- **File system isolation** — File writes are redirected to the sandbox directory.
- **Registry isolation** — Registry changes stay within the sandbox.
- **Process isolation** — Sandboxed processes cannot interact with host processes by default.
- **Privilege reduction** — The `Drop admin rights` option runs all sandboxed programs as standard users.

## Privacy Mode

Privacy-mode sandboxes block read access to personal user data, preventing sandboxed programs from accessing files they did not create:

1. Create or edit a sandbox.
2. Set the box type to **Privacy Sandbox** or enable **Privacy Mode** in **Sandbox Options → Restrictions**.

### What Privacy Mode Blocks

| Resource | Behavior |
| :--- | :--- |
| Documents, Desktop, Downloads | Read access blocked |
| AppData (Roaming, Local) | Read access blocked |
| User profile root | Read access blocked |
| Mapped drives | Read access blocked |

Sandboxie automatically creates essential default folders inside the sandbox so that applications can still function.

### When to Use Privacy Mode

- Running untrusted programs that should not read your personal files.
- Testing software that may collect user data.
- Browsing the web with maximum data separation from the host.

## Security-Hardened Sandboxes

Hardened sandboxes restrict the attack surface available to sandboxed processes:

1. Set the box type to **Hardened Sandbox** or enable **Security Hardening** in **Sandbox Options → Restrictions**.

### Restrictions Applied

- **Syscall filtering** — Only a whitelisted set of system calls is available.
- **Endpoint restrictions** — Access to system endpoints (devices, drivers) is limited.
- **Token hardening** — The process token is further restricted to reduce privilege.
- **Host protection** — Host processes are blocked from reading sandbox memory.

### Confidential Mode

Enable **Confidential Box** mode to prevent host processes from reading the memory or data of sandboxed processes. This is useful for running sensitive applications where data leakage to the host is a concern.

## Encrypted Sandboxes

Encrypted sandboxes store all data inside an AES-encrypted container:

1. Create a new sandbox and select the **Confidential Sandbox** preset, or enable encryption in **Sandbox Options → General**.
2. Set a password when prompted.
3. All files and registry data written by sandboxed programs are stored in an encrypted image file.

### How It Works

Sandboxie uses the **ImBox** tool to manage encrypted container images. When a sandbox with encryption is started:

1. The encrypted image is mounted using the provided password.
2. Programs run and write data to the mounted image.
3. When all programs exit, the image is unmounted and the data remains encrypted on disk.

### Locking Encrypted Sandboxes

- **Lock on close** — The encrypted image is automatically locked when the last process exits.
- **Lock All** — Use the menu option **Sandbox → Lock All Encrypted Boxes** to lock all open encrypted sandboxes at once.
- **Password prompt** — When starting a program in a locked encrypted sandbox, Sandboxie prompts for the password.

### Best Practices

- Use a strong password. Sandboxie derives the encryption key from the password.
- Back up the sandbox data regularly. If the encrypted image is corrupted, data may be unrecoverable.
- Do not store the password in the sandbox configuration file.

## Custom UAC Handling

Sandboxie can intercept User Account Control (UAC) prompts from sandboxed programs:

1. In **Sandbox Options → Restrictions**, configure the UAC behavior:
   - **Fake administrator rights** — The program believes it has admin access but is actually restricted.
   - **Block elevation** — All elevation attempts are silently denied.
   - **Prompt** — Show a custom Sandboxie UAC dialog where you can allow or deny elevation.

## Screenshot Protection

Prevent sandboxed programs from capturing screenshots of the host desktop:

1. In **Sandbox Options → Restrictions**, enable **Block screenshots**.
2. Sandboxed programs will receive blank or black images when attempting to capture the screen.

## Combining Security Layers

Security features can be combined for maximum protection:

| Configuration | Isolation | Privacy | Hardening | Encryption |
| :--- | :---: | :---: | :---: | :---: |
| Standard | ✓ | | | |
| Privacy | ✓ | ✓ | | |
| Hardened | ✓ | | ✓ | |
| Maximum | ✓ | ✓ | ✓ | ✓ |

Enable each layer independently through the sandbox options or by choosing the appropriate preset during sandbox creation.
