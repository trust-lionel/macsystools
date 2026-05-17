import SwiftUI

struct InputToolView: View {

    let tool: Tool
    @StateObject private var runner = ShellRunner()

    // Input state for each tool
    @State private var hostname    = ""
    @State private var recordType  = "A"
    @State private var dnsServer   = "8.8.8.8"
    @State private var pingCount   = "10"
    @State private var processName = ""

    private let recordTypes = ["A", "AAAA", "MX", "TXT", "CNAME", "NS", "ANY"]

    var body: some View {
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

            // Input form
            GroupBox {
                switch tool {

                case .nslookup:
                    inputRow(label: "Hostname") {
                        TextField("e.g. apple.com", text: $hostname)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(.body, design: .monospaced))
                    }
                    Divider().padding(.vertical, 4)
                    inputRow(label: "Record type") {
                        Picker("", selection: $recordType) {
                            ForEach(recordTypes, id: \.self) { Text($0) }
                        }
                        .labelsHidden()
                        .frame(width: 120)
                    }
                    Divider().padding(.vertical, 4)
                    inputRow(label: "DNS server") {
                        TextField("e.g. 8.8.8.8", text: $dnsServer)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(.body, design: .monospaced))
                            .frame(width: 140)
                        Text("8.8.8.8 Google · 1.1.1.1 Cloudflare")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }

                case .pingHost:
                    inputRow(label: "Hostname / IP") {
                        TextField("e.g. apple.com or 8.8.8.8", text: $hostname)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(.body, design: .monospaced))
                    }
                    Divider().padding(.vertical, 4)
                    inputRow(label: "Packet count") {
                        TextField("10", text: $pingCount)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 60)
                        Text("packets")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                case .traceroute:
                    inputRow(label: "Hostname / IP") {
                        TextField("e.g. apple.com or 8.8.8.8", text: $hostname)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(.body, design: .monospaced))
                    }

                case .killProcess:
                    inputRow(label: "Process name") {
                        TextField("e.g. Finder, Safari, Dock", text: $processName)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(.body, design: .monospaced))
                    }
                    Text("Enter the exact process name as shown in Activity Monitor.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)

                default:
                    EmptyView()
                }
            }
            .padding()

            // Command preview
            GroupBox {
                HStack {
                    Text("Command")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(width: 80, alignment: .leading)
                    Text(builtCommand)
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(isReadyToRun ? .primary : .tertiary)
                        .textSelection(.enabled)
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)

            // Run button row
            HStack {
                Button {
                    Task { await runner.run(builtCommand) }
                } label: {
                    Label(
                        runner.isRunning ? "Running…" : "Run Command",
                        systemImage: runner.isRunning ? "stop.circle" : "play.circle"
                    )
                }
                .buttonStyle(.borderedProminent)
                .disabled(runner.isRunning || !isReadyToRun)

                Button("Copy Command") {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(builtCommand, forType: .string)
                }
                .buttonStyle(.bordered)
                .disabled(!isReadyToRun)

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

            // Terminal output
            ScrollView {
                Text(runner.output.isEmpty ? "Output will appear here…" : runner.output)
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
            hostname     = ""
            processName  = ""
            pingCount    = "10"
            recordType   = "A"
            dnsServer    = "8.8.8.8"
            runner.output    = ""
            runner.hasRun    = false
            runner.exitCode  = 0
        }
    }

    // MARK: - Helpers

    @ViewBuilder
    private func inputRow<Content: View>(
        label: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(width: 100, alignment: .leading)
            content()
            Spacer()
        }
        .padding(.vertical, 2)
    }

    private var builtCommand: String {
        switch tool {
        case .nslookup:
            guard !hostname.isEmpty else { return "nslookup — enter a hostname above" }
            let server = dnsServer.isEmpty ? "" : " \(dnsServer)"
            return "nslookup -type=\(recordType) \(hostname)\(server)"
        case .pingHost:
            guard !hostname.isEmpty else { return "ping — enter a hostname above" }
            let count = pingCount.isEmpty ? "10" : pingCount
            return "ping -c \(count) \(hostname)"
        case .traceroute:
            guard !hostname.isEmpty else { return "traceroute — enter a hostname above" }
            return "traceroute \(hostname)"
        case .killProcess:
            guard !processName.isEmpty else { return "killall — enter a process name above" }
            return "killall \(processName)"
        default:
            return tool.command
        }
    }

    private var isReadyToRun: Bool {
        switch tool {
        case .nslookup, .pingHost, .traceroute:
            return !hostname.trimmingCharacters(in: .whitespaces).isEmpty
        case .killProcess:
            return !processName.trimmingCharacters(in: .whitespaces).isEmpty
        default:
            return true
        }
    }
}
