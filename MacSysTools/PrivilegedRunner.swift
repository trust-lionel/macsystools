import Foundation

struct PrivilegedRunner {

    // Runs a sudo command via osascript, which triggers
    // the native macOS administrator password dialog
    static func run(_ command: String) async -> CommandResult {
        // Wrap the command in an osascript do shell script call
        // which properly handles sudo elevation on macOS
        let escaped = command
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")

        let script = "do shell script \"\(escaped)\" with administrator privileges"

        let proc    = Process()
        let pipe    = Pipe()
        let errPipe = Pipe()

        proc.executableURL  = URL(fileURLWithPath: "/usr/bin/osascript")
        proc.arguments      = ["-e", script]
        proc.standardOutput = pipe
        proc.standardError  = errPipe

        do {
            try proc.run()
        } catch {
            return CommandResult(
                output:   "",
                error:    error.localizedDescription,
                exitCode: -1
            )
        }

        await Task.detached(priority: .userInitiated) {
            proc.waitUntilExit()
        }.value

        let out = String(
            data: pipe.fileHandleForReading.readDataToEndOfFile(),
            encoding: .utf8) ?? ""
        let err = String(
            data: errPipe.fileHandleForReading.readDataToEndOfFile(),
            encoding: .utf8) ?? ""

        return CommandResult(
            output:   out.isEmpty ? err : out,
            error:    err,
            exitCode: proc.terminationStatus
        )
    }
}
