---
layout: default
title: Templates
---

# Templates

Templates are pre-configured sets of access rules and settings that make specific applications compatible with Sandboxie. They simplify sandbox setup by bundling the necessary exceptions and permissions for common software.

---

## How Templates Work

When a template is applied to a sandbox, its rules are merged with the sandbox's own configuration. Templates can add:

- File and registry access rules
- IPC access rules
- Start restrictions or exceptions
- Program group definitions

Templates do not override existing sandbox rules — they supplement them.

## Applying Templates

1. Open **Sandbox Options** → **Templates** tab.
2. Browse the available templates organized by category.
3. Check the box next to each template you want to enable.
4. Click **OK**.

The template rules take effect immediately for new processes started in the sandbox.

## Template Categories

| Category | Examples |
| :--- | :--- |
| Web Browsers | Firefox, Chrome, Edge, Opera, Brave, Vivaldi |
| Email Clients | Thunderbird, Outlook |
| Media Players | VLC, media codecs |
| Development | Visual Studio, Node.js, Python |
| System Tools | Print spooler, clipboard access |
| Security | VPN clients, antivirus exceptions |
| Input Methods | IME support for various languages |

## Browser Compatibility Wizard

For browsers not covered by built-in templates:

1. Go to **Tools** → **Browser Compatibility Wizard**.
2. Select the browser executable.
3. The wizard analyzes the browser and generates a custom template with the necessary access rules.
4. Apply the generated template to your sandbox.

## Creating Custom Templates

Create your own templates for applications that need specific rules:

1. Open **Settings** → **Edit Templates.ini** or use **Sandbox Options** → **Templates** → **Create Template**.
2. Define the template with a unique name and the desired rules.

### Template INI Format

Templates are defined in `Templates.ini` using INI section syntax:

```ini
[Template_MyApp]
Tmpl.Title=My Application Template
Tmpl.Class=Custom

# File access rules
OpenFilePath=%AppData%\MyApp\*

# Registry access rules
OpenKeyPath=HKCU\Software\MyApp

# IPC access
OpenIpcPath=\RPC Control\MyAppService
```

### Template Fields

| Field | Description |
| :--- | :--- |
| `Tmpl.Title` | Display name shown in the Templates tab |
| `Tmpl.Class` | Category for organization (Custom, Browser, Email, etc.) |
| `OpenFilePath` | Grant full file access |
| `ReadFilePath` | Grant read-only file access |
| `ClosedFilePath` | Block file access |
| `OpenKeyPath` | Grant full registry access |
| `OpenIpcPath` | Grant IPC access |

## Sharing Templates

Templates defined in `Templates.ini` can be shared:

1. Open **Settings** → **Edit Templates.ini**.
2. Copy the template section.
3. Share it with other users who can paste it into their `Templates.ini`.

## Template Inheritance

Templates can reference other templates, creating a chain of inherited rules:

```ini
[Template_MyBrowser]
Tmpl.Title=My Custom Browser
Tmpl.Class=Browser
Template=Template_Firefox
OpenFilePath=%MyBrowserPath%\*
```

This template inherits all rules from the Firefox template and adds additional file access.

## Updating Templates

Built-in templates are updated with new Sandboxie releases. Check for updates in **Settings → Global Settings → Updates** to receive the latest template definitions.
