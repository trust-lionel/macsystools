import Foundation

// MARK: - Category

enum Category: String, CaseIterable, Identifiable {
    case network   = "Network"
    case system    = "System"
    case security  = "Security"
    case developer = "Developer"
    case sharing   = "Sharing"

    var id: String { rawValue }

    var sfSymbol: String {
        switch self {
        case .network:   return "network"
        case .system:    return "gearshape"
        case .security:  return "lock.shield"
        case .developer: return "hammer"
        case .sharing:   return "square.and.arrow.up"
        }
    }
}

// MARK: - Tool

enum Tool: String, CaseIterable, Identifiable {

    // Network
    case flushDNS         = "Flush DNS Cache"
    case nslookup         = "nslookup"
    case wifiDiagnostics  = "Wi-Fi Diagnostics"
    case pingHost         = "Ping Host"
    case traceroute       = "Traceroute"
    case renewDHCP        = "Renew DHCP Lease"

    // System
    case purgeMemory      = "Purge Memory"
    case diskPermissions  = "Disk Permissions"
    case clearLogs        = "Clear System Logs"
    case rebuildSpotlight = "Rebuild Spotlight"
    case openPorts        = "Show Open Ports"
    case clearFontCache   = "Clear Font Cache"

    // Security
    case killProcess      = "Kill Process"
    case firewallStatus   = "Firewall Status"
    case gatekeeperStatus = "Gatekeeper Status"
    case clearAppCaches   = "Clear App Caches"

    // Developer
    case xcodeDerivedData = "Clear Xcode Derived Data"
    case hiddenFiles      = "Show Hidden Files"
    case hostsFile        = "Edit /etc/hosts"
    case systemInfo       = "System Information"

    // Sharing
    case screenSharing    = "Enable Screen Sharing"
    case remoteLogin      = "Enable Remote Login"
    case fileSharing      = "Enable File Sharing"

    // MARK: Identifiable
    var id: String { rawValue }

    // MARK: Category
    var category: Category {
        switch self {
        case .flushDNS, .nslookup, .wifiDiagnostics,
             .pingHost, .traceroute, .renewDHCP:
            return .network
        case .purgeMemory, .diskPermissions, .clearLogs,
             .rebuildSpotlight, .openPorts, .clearFontCache:
            return .system
        case .killProcess, .firewallStatus,
             .gatekeeperStatus, .clearAppCaches:
            return .security
        case .xcodeDerivedData, .hiddenFiles,
             .hostsFile, .systemInfo:
            return .developer
        case .screenSharing, .remoteLogin, .fileSharing:
            return .sharing
        }
    }

    // MARK: SF Symbol
    var sfSymbol: String {
        switch self {
        case .flushDNS:          return "clock.arrow.2.circlepath"
        case .nslookup:          return "dot.radiowaves.left.and.right"
        case .wifiDiagnostics:   return "wifi"
        case .pingHost:          return "dot.scope"
        case .traceroute:        return "arrow.triangle.branch"
        case .renewDHCP:         return "arrow.clockwise.circle"
        case .purgeMemory:       return "memorychip"
        case .diskPermissions:   return "externaldrive.badge.checkmark"
        case .clearLogs:         return "doc.text.fill"
        case .rebuildSpotlight:  return "magnifyingglass.circle"
        case .openPorts:         return "network"
        case .clearFontCache:    return "textformat"
        case .killProcess:       return "xmark.circle"
        case .firewallStatus:    return "shield.lefthalf.filled"
        case .gatekeeperStatus:  return "lock.shield"
        case .clearAppCaches:    return "trash"
        case .xcodeDerivedData:  return "hammer"
        case .hiddenFiles:       return "eye"
        case .hostsFile:         return "doc.text"
        case .systemInfo:        return "info.circle"
        case .screenSharing:     return "rectangle.on.rectangle"
        case .remoteLogin:       return "terminal"
        case .fileSharing:       return "folder.badge.person.crop"
        }
    }

    // MARK: Description
    var description: String {
        switch self {
        case .flushDNS:
            return "Clear stale DNS records and force fresh lookups. Fixes DNS errors and cache poisoning."
        case .nslookup:
            return "Query DNS records for any domain — A, AAAA, MX, TXT, CNAME, and NS."
        case .wifiDiagnostics:
            return "Show current Wi-Fi interface info, signal strength, and network details."
        case .pingHost:
            return "Test reachability and measure round-trip latency to any host."
        case .traceroute:
            return "Trace the network path and each hop between your Mac and a destination."
        case .renewDHCP:
            return "Release and renew your IP address lease from the router."
        case .purgeMemory:
            return "Force inactive memory to be freed, releasing RAM back to the system."
        case .diskPermissions:
            return "Verify and repair file system permissions on the boot volume."
        case .clearLogs:
            return "Remove accumulated system log files from /private/var/log."
        case .rebuildSpotlight:
            return "Erase and rebuild the Spotlight search index for the entire disk."
        case .openPorts:
            return "List all currently listening network ports and their associated processes."
        case .clearFontCache:
            return "Remove the font cache database to fix rendering and display issues."
        case .killProcess:
            return "Force-terminate a running process by name or PID."
        case .firewallStatus:
            return "Check or toggle the macOS application-layer firewall."
        case .gatekeeperStatus:
            return "Check the current Gatekeeper setting controlling app notarization."
        case .clearAppCaches:
            return "Delete all user application cache files from ~/Library/Caches."
        case .xcodeDerivedData:
            return "Delete Xcode derived data folder to free disk space and fix build issues."
        case .hiddenFiles:
            return "Toggle visibility of hidden dotfiles and system files in Finder."
        case .hostsFile:
            return "Open the /etc/hosts file for editing in a text editor."
        case .systemInfo:
            return "Display full hardware and software details for this Mac."
        case .screenSharing:
            return "Enable or disable the built-in VNC screen sharing service via launchctl."
        case .remoteLogin:
            return "Enable or disable SSH remote login access to this Mac."
        case .fileSharing:
            return "Enable or disable SMB file sharing so others can access your folders."
        }
    }

    // MARK: Command
    var command: String {
        switch self {
        case .flushDNS:
            return "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
        case .nslookup:
            return "nslookup"
        case .wifiDiagnostics:
            return "networksetup -getinfo Wi-Fi && echo '---' && /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I"
        case .pingHost:
            return "ping -c 10"
        case .traceroute:
            return "traceroute"
        case .renewDHCP:
            return "sudo ipconfig set en0 DHCP"
        case .purgeMemory:
            return "sudo purge"
        case .diskPermissions:
            return "diskutil verifyPermissions /"
        case .clearLogs:
            return "sudo rm -rf /private/var/log/asl/*.asl && echo 'System logs cleared.'"
        case .rebuildSpotlight:
            return "sudo mdutil -E /"
        case .openPorts:
            return "sudo lsof -i -n -P | grep LISTEN"
        case .clearFontCache:
            return "sudo atsutil databases -remove && sudo atsutil server -shutdown && echo 'Font cache cleared.'"
        case .killProcess:
            return "killall"
        case .firewallStatus:
            return "/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate"
        case .gatekeeperStatus:
            return "spctl --status"
        case .clearAppCaches:
            return "rm -rf ~/Library/Caches/* && echo 'App caches cleared.'"
        case .xcodeDerivedData:
            return "rm -rf ~/Library/Developer/Xcode/DerivedData && echo 'Derived data cleared.'"
        case .hiddenFiles:
            return "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder && echo 'Hidden files now visible.'"
        case .hostsFile:
            return "open -e /etc/hosts"
        case .systemInfo:
            return "system_profiler SPHardwareDataType SPSoftwareDataType"
        case .screenSharing:
            return "sudo launchctl enable system/com.apple.screensharing && sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist && echo 'Screen Sharing enabled.'"
        case .remoteLogin:
            return "sudo systemsetup -setremotelogin on && echo 'Remote Login enabled.'"
        case .fileSharing:
            return "sudo launchctl enable system/com.apple.smbd && sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist && echo 'File Sharing enabled.'"
        }
    }

    // MARK: Flags

    var requiresSudo: Bool {
        switch self {
        case .nslookup, .wifiDiagnostics, .pingHost,
             .traceroute, .killProcess, .clearAppCaches,
             .xcodeDerivedData, .hiddenFiles, .hostsFile,
             .systemInfo, .firewallStatus, .gatekeeperStatus:
            return false
        default:
            return true
        }
    }

    var isToggle: Bool {
        switch self {
        case .screenSharing, .remoteLogin, .fileSharing,
             .firewallStatus, .gatekeeperStatus:
            return true
        default:
            return false
        }
    }

    var requiresInput: Bool {
        switch self {
        case .nslookup, .pingHost, .traceroute, .killProcess:
            return true
        default:
            return false
        }
    }
}

// MARK: - Category tools

extension Category {
    var tools: [Tool] {
        Tool.allCases.filter { $0.category == self }
    }
}
