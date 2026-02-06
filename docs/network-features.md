---
layout: default
title: Network Features
---

# Network Features

Sandboxie provides per-sandbox network controls including a firewall, SOCKS5 proxy enforcement, and DNS filtering.

---

## Per-Sandbox Firewall

Each sandbox can have its own firewall rules using Windows Filtering Platform (WFP):

1. Open **Sandbox Options** → **Network** tab.
2. Under **Firewall Rules**, click **Add Rule**.
3. Configure the rule:

| Field | Description |
| :--- | :--- |
| Action | **Allow** or **Block** |
| Protocol | Any, TCP, UDP, or ICMP |
| Local Port | Port on the sandbox side (optional) |
| Remote Port | Port on the remote side (optional) |
| Remote Address | IP address or range (optional) |
| Program | Apply the rule to a specific executable (optional) |

4. Click **OK** to add the rule.

Rules are evaluated from top to bottom. The first matching rule determines whether traffic is allowed or blocked.

### Common Firewall Configurations

**Block all network access:**

1. Add a single rule: **Block** all protocols, all ports, all addresses.
2. No sandboxed program can access the network.

**Allow only web browsing:**

1. Add rule: **Allow** TCP on remote ports 80 and 443.
2. Add rule: **Block** all protocols (catch-all).

**Block local network access:**

1. Add rule: **Block** all protocols to local/private address ranges (`192.168.0.0/16`, `10.0.0.0/8`, `172.16.0.0/12`).
2. Add rule: **Allow** all protocols (for internet access).

## SOCKS5 Proxy

Force all network traffic from a sandbox through a SOCKS5 proxy:

1. Open **Sandbox Options** → **Network** tab.
2. Under **Proxy**, enter the proxy details:
   - **Address** — Proxy hostname or IP.
   - **Port** — Proxy port.
   - **Username / Password** — Authentication credentials (if required).
3. Enable **Resolve hostnames at proxy** if the proxy should handle DNS resolution.
4. Click **OK**.

All TCP traffic from the sandbox is routed through the configured proxy. This is useful for routing sandbox traffic through a VPN or Tor without affecting host traffic.

### Multiple Proxies

You can configure multiple proxy entries with different priorities. Sandboxie uses the highest-priority proxy that is reachable.

### Network Adapter Binding

Bind sandbox traffic to a specific network adapter (e.g., a VPN interface):

1. In **Sandbox Options** → **Network**, select the adapter from the **Bind to adapter** dropdown.
2. All traffic from the sandbox is routed through the selected adapter.

## DNS Control

Override or filter DNS resolution for sandboxed programs:

1. Open **Sandbox Options** → **Network** tab.
2. Under **DNS**, configure rules:

### Block a Domain

Add a DNS rule to block resolution of specific domains:

- **Domain**: `example.com`
- **Action**: Block

When a sandboxed program tries to resolve `example.com`, the request fails.

### Redirect a Domain

Redirect a domain to a specific IP address:

- **Domain**: `ads.example.com`
- **Action**: Redirect
- **Target IP**: `127.0.0.1`

All DNS queries for `ads.example.com` from the sandbox resolve to `127.0.0.1`.

### Per-Program DNS Rules

Apply DNS rules only to specific programs by selecting an executable in the rule configuration. This allows different programs in the same sandbox to have different DNS behavior.

## Internet Access Restrictions

At a simpler level than the full firewall, you can control internet access per program:

1. Open **Sandbox Options** → **Restrictions** tab.
2. Under **Internet Access**, add programs to the allowed list.
3. Enable **Restrict internet access to listed programs only**.

Only the listed programs can access the network; all others are blocked.

## Monitoring Network Activity

View network activity from sandboxed programs in the **Trace Log**:

1. Enable tracing in **Settings → Global Settings → Trace Logging**.
2. Network access events appear in the log, showing:
   - Source process
   - Destination address and port
   - Protocol
   - Allow/block result
