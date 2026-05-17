# MacSysTools — Native macOS System Administration Tools

A native macOS system administration app built with SwiftUI and Xcode 26,
designed for macOS Tahoe (26.x) on Intel MacBook Pro. MacSysTools provides
a clean graphical interface for common macOS Terminal commands — no more
memorizing syntax for DNS flushing, network diagnostics, memory management,
and system maintenance.

## Why MacSysTools?

macOS power users and developers frequently need tools like:
- Flush DNS cache on macOS Tahoe
- Run nslookup with custom DNS servers
- Ping hosts and trace network routes
- Purge memory and clear system caches
- Manage screen sharing and remote login via SSH
- Check firewall and Gatekeeper status

MacSysTools wraps all of these into a single native macOS app with live
terminal output streaming, native sudo elevation via macOS authentication
dialog, and a UI that follows Apple Human Interface Guidelines (HIG).

## Installation

### Option 1 — Download the release (easiest)
1. Go to [Releases](https://github.com/trust-lionel/macsystools/releases/tag/v1.0.0)
2. Download `MacSysTools.app.zip`
3. Unzip the file
4. Drag `MacSysTools.app` to your `/Applications` folder
5. Double-click to launch

> **First launch security note:** macOS may show a security warning since
> the app is not distributed through the App Store.
> Go to **System Settings → Privacy & Security → Open Anyway**

### Option 2 — Build from source

**Requirements:**
- macOS Tahoe 26.x
- Xcode 26.4.1 or later
- Swift 6.3.1

**Steps:**

```bash
git clone https://github.com/trust-lionel/macsystools.git
```

1. Open `MacSysTools.xcodeproj` in Xcode
2. Select **My Mac** as the run destination
3. Press **⌘R** to build and run
4. To install: **Product → Show Build Folder in Finder → Products → Debug → MacSysTools.app**
5. Drag `MacSysTools.app` to `/Applications`

## Features

### Network Tools
| Tool | Description |
|---|---|
| Flush DNS Cache | Clears stale DNS records — fixes DNS errors and cache poisoning |
| nslookup | Query A, AAAA, MX, TXT, CNAME, NS records with custom DNS server |
| Wi-Fi Diagnostics | Interface info, signal strength, and network details |
| Ping Host | Test reachability and measure round-trip latency |
| Traceroute | Trace network hops between your Mac and any destination |
| Renew DHCP Lease | Request a new IP address from your router |

### System Tools
| Tool | Description |
|---|---|
| Purge Memory | Force inactive RAM to free up system memory |
| Disk Permissions | Verify and repair file system permissions |
| Clear System Logs | Remove accumulated log files from /private/var/log |
| Rebuild Spotlight | Erase and rebuild the Spotlight search index |
| Show Open Ports | List all listening network ports and processes |
| Clear Font Cache | Fix font rendering issues by removing font cache |

### Security Tools
| Tool | Description |
|---|---|
| Kill Process | Force-terminate any running process by name |
| Firewall Status | Check or toggle the macOS application firewall |
| Gatekeeper Status | Check app notarization enforcement settings |
| Clear App Caches | Delete all user app cache files |

### Developer Tools
| Tool | Description |
|---|---|
| Clear Xcode Derived Data | Free disk space and fix Xcode build issues |
| Show Hidden Files | Toggle dotfile visibility in Finder |
| Edit /etc/hosts | Open the hosts file for editing |
| System Information | Full hardware and software details |

### Sharing Tools
| Tool | Description |
|---|---|
| Enable Screen Sharing | Toggle VNC screen sharing via launchctl |
| Enable Remote Login | Start or stop SSH access |
| Enable File Sharing | Toggle SMB file sharing |

## Technical Details

| Component | Details |
|---|---|
| Language | Swift 6.3.1 |
| Framework | SwiftUI |
| Architecture | NavigationSplitView with async/await command execution |
| Privilege elevation | osascript with administrator privileges |
| Output | Live streaming via Process() and Pipe() |
| Design | Apple Human Interface Guidelines (HIG) compliant |
| Compatibility | macOS Tahoe 26.x — Intel MacBook Pro (x86_64) |

## Project Structure

MacSysTools/
├── MacSysToolsApp.swift      — @main entry point
├── ContentView.swift         — NavigationSplitView root layout
├── SidebarView.swift         — Sidebar with tools grouped by category
├── DetailView.swift          — Detail panel, routes to correct view
├── InputToolView.swift       — Input fields for nslookup, ping, traceroute
├── ShellRunner.swift         — Async command engine, live output streaming
├── PrivilegedRunner.swift    — sudo elevation via osascript
├── Tool.swift                — Master enum defining all 23 tools
└── Assets.xcassets           — App icon

## Learn More

Full technical writeup including design decisions, architecture, and
the reasoning behind SwiftUI over Electron:

[MacSysTools — trust-lionel.com](https://trust-lionel.com/blog/macsystools.html)

## Author

**Lionel Mosley** — Houston, TX
- Website: [trust-lionel.com](https://trust-lionel.com)
- GitHub: [trust-lionel](https://github.com/trust-lionel)

## License

MIT License — feel free to fork, modify, and build on this project.