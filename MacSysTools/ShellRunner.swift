import Foundation
import Combine

// Result of any shell command execution
struct CommandResult {
    let output:   String
    let error:    String
    let exitCode: Int32

    var succeeded: Bool { exitCode == 0 }
}

// Streams output line-by-line as the command runs
@MainActor
class ShellRunner: ObservableObject {

    @Published var output:    String = ""
    @Published var isRunning: Bool   = false
    @Published var exitCode:  Int32  = 0
    @Published var hasRun:    Bool   = false

    private var process: Process?

    // Run a command, streaming stdout live to self.output
    func run(_ command: String) async {
        // Reset state
        output    = ""
        exitCode  = 0
        hasRun    = false
        isRunning = true

        let proc  = Process()
        let pipe  = Pipe()
        let errPipe = Pipe()

        proc.executableURL      = URL(fileURLWithPath: "/bin/zsh")
        proc.arguments          = ["-c", command]
        proc.standardOutput     = pipe
        proc.standardError      = errPipe
        process                 = proc

        // Stream stdout live, line by line
        pipe.fileHandleForReading.readabilityHandler = { [weak self] handle in
            let data = handle.availableData
            guard !data.isEmpty,
                  let line = String(data: data, encoding: .utf8) else { return }
            DispatchQueue.main.async {
                self?.output += line
            }
        }

        // Capture stderr separately
        errPipe.fileHandleForReading.readabilityHandler = { [weak self] handle in
            let data = handle.availableData
            guard !data.isEmpty,
                  let line = String(data: data, encoding: .utf8) else { return }
            DispatchQueue.main.async {
                self?.output += line
            }
        }

        do {
            try proc.run()
        } catch {
            output    = "Failed to launch: \(error.localizedDescription)"
            isRunning = false
            hasRun    = true
            return
        }

        // Wait off the main thread so UI stays responsive
        await Task.detached(priority: .userInitiated) {
            proc.waitUntilExit()
        }.value

        pipe.fileHandleForReading.readabilityHandler    = nil
        errPipe.fileHandleForReading.readabilityHandler = nil

        exitCode  = proc.terminationStatus
        isRunning = false
        hasRun    = true
    }

    // Non-streaming version — returns full output when done
    static func runOnce(_ command: String) async -> CommandResult {
        let proc    = Process()
        let pipe    = Pipe()
        let errPipe = Pipe()

        proc.executableURL  = URL(fileURLWithPath: "/bin/zsh")
        proc.arguments      = ["-c", command]
        proc.standardOutput = pipe
        proc.standardError  = errPipe

        do {
            try proc.run()
        } catch {
            return CommandResult(output: "", error: error.localizedDescription, exitCode: -1)
        }

        await Task.detached(priority: .userInitiated) {
            proc.waitUntilExit()
        }.value

        let out = String(data: pipe.fileHandleForReading.readDataToEndOfFile(),
                         encoding: .utf8) ?? ""
        let err = String(data: errPipe.fileHandleForReading.readDataToEndOfFile(),
                         encoding: .utf8) ?? ""

        return CommandResult(output: out, error: err, exitCode: proc.terminationStatus)
    }

    func cancel() {
        process?.terminate()
        isRunning = false
    }
}
