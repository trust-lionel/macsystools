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
git add README.md
git commit -m "Optimize README for SEO and public release"
git push
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
