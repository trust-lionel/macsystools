import SwiftUI

struct DetailView: View {

    let tool: Tool
    @StateObject private var runner = ShellRunner()

    var body: some View {
        if tool.requiresInput {
            InputToolView(tool: tool)
        } else {
            standardView
        }
    }

    // MARK: - Standard view

    private var standardView: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Header
            VStack(alignment: .leading, spacing: 4) {
                Label(tool.rawValue, systemImage: tool.sfSymbol)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(tool.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            // Command preview
            GroupBox {
                HStack {
                    Text("Command")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(width: 80, alignment: .leading)
                    Text(tool.command)
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(.primary)
                        .textSelection(.enabled)
                    Spacer()
                }
                .padding(.vertical, 2)

                if tool.requiresSudo {
                    HStack {
                        Text("Privileges")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(width: 80, alignment: .leading)
                        Text("Requires administrator password")
                            .font(.caption)
                            .foregroundStyle(.orange)
                        Spacer()
                    }
                    .padding(.vertical, 2)
                }
            }
            .padding()

            // Run button row
            HStack {
                Button {
                    Task {
                        if tool.requiresSudo {
                            let result = await PrivilegedRunner.run(tool.command)
                            await MainActor.run {
                                runner.output    = result.output.isEmpty
                                    ? result.error
                                    : result.output
                                runner.exitCode  = result.exitCode
                                runner.hasRun    = true
                                runner.isRunning = false
                            }
                        } else {
                            await runner.run(tool.command)
                        }
                    }
                } label: {
                    Label(
                        runner.isRunning ? "Running…" : "Run Command",
                        systemImage: runner.isRunning
                            ? "stop.circle"
                            : "play.circle"
                    )
                }
                .buttonStyle(.borderedProminent)
                .disabled(runner.isRunning)

                Button("Copy Command") {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(tool.command, forType: .string)
                }
                .buttonStyle(.bordered)

                Spacer()

                if runner.hasRun {
                    Label(
                        runner.exitCode == 0 ? "Succeeded" : "Failed",
                        systemImage: runner.exitCode == 0
                            ? "checkmark.circle.fill"
                            : "xmark.circle.fill"
                    )
                    .font(.caption)
                    .foregroundStyle(runner.exitCode == 0 ? .green : .red)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)

            Divider()

            // Terminal output pane
            ScrollView {
                Text(runner.output.isEmpty
                     ? "Output will appear here…"
                     : runner.output)
                    .font(.system(.body, design: .monospaced))
                    .foregroundStyle(runner.output.isEmpty ? .tertiary : .primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .textSelection(.enabled)
            }
            .background(Color(nsColor: .textBackgroundColor).opacity(0.5))
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onChange(of: tool) {
            runner.output   = ""
            runner.hasRun   = false
            runner.exitCode = 0
        }
    }
}
