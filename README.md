cat > README.md << 'EOF'
# MacSysTools

A native macOS system administration app built with SwiftUI and Xcode 26,
designed for macOS Tahoe (26.x) on Intel MacBook Pro.

## Features
- 23 system tools across 5 categories
- **Network** — Flush DNS Cache, nslookup, Wi-Fi Diagnostics, Ping Host, Traceroute, Renew DHCP
- **System** — Purge Memory, Disk Permissions, Clear Logs, Rebuild Spotlight, Open Ports, Font Cache
- **Security** — Kill Process, Firewall Status, Gatekeeper Status, Clear App Caches
- **Developer** — Xcode Derived Data, Hidden Files, /etc/hosts, System Information
- **Sharing** — Screen Sharing, Remote Login, File Sharing

## Requirements
- macOS Tahoe 26.x
- Xcode 26.4.1 or later
- Swift 6.3.1

## Build
Open `MacSysTools.xcodeproj` in Xcode and press ⌘R to run.

## Author
Lionel Mosley
EOF
