# MacSysTools

A native macOS system administration app built with SwiftUI and Xcode 26,
designed for macOS Tahoe (26.x) on Intel MacBook Pro.

## Installation

### Option 1 — Download the release (easiest)
1. Go to [Releases](https://github.com/trust-lionel/macsystools/releases/tag/v1.0.0)
2. Download `MacSysTools.app.zip`
3. Unzip the file
4. Drag `MacSysTools.app` to your `/Applications` folder
5. Double-click to launch

> **Note:** On first launch macOS may show a security warning since the app
> is not distributed through the App Store. To open it:
> System Settings → Privacy & Security → scroll down → click Open Anyway

### Option 2 — Build from source
**Requirements:**
- macOS Tahoe 26.x
- Xcode 26.4.1 or later
- Swift 6.3.1

**Steps:**
1. Clone the repository
```bash
git clone https://github.com/trust-lionel/macsystools.git
```
2. Open `MacSysTools.xcodeproj` in Xcode
3. Select **My Mac** as the run destination
4. Press **⌘R** to build and run
5. To install permanently:
   - Press **⌘B** to build
   - In Xcode go to **Product → Show Build Folder in Finder**
   - Navigate to **Products → Debug → MacSysTools.app**
   - Drag `MacSysTools.app` to your `/Applications` folder

## Features
- 23 system tools across 5 categories
- **Network** — Flush DNS Cache, nslookup, Wi-Fi Diagnostics, Ping Host, Traceroute, Renew DHCP
- **System** — Purge Memory, Disk Permissions, Clear Logs, Rebuild Spotlight, Open Ports, Font Cache
- **Security** — Kill Process, Firewall Status, Gatekeeper Status, Clear App Caches
- **Developer** — Xcode Derived Data, Hidden Files, /etc/hosts, System Information
- **Sharing** — Screen Sharing, Remote Login, File Sharing

## Requirements
- macOS Tahoe 26.x
- Intel MacBook Pro

## Learn More
Full project writeup and technical details:
[trust-lionel.com/blog/macsystools.html](https://trust-lionel.com/blog/macsystools.html)

## Author
Lionel Mosley
