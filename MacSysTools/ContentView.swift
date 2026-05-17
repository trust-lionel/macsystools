import SwiftUI

struct ContentView: View {

    @State private var selectedTool: Tool? = .flushDNS
    @State private var columnVisibility = NavigationSplitViewVisibility.all

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarView(selectedTool: $selectedTool)
                .navigationSplitViewColumnWidth(min: 220, ideal: 240)
        } detail: {
            if let tool = selectedTool {
                DetailView(tool: tool)
            } else {
                WelcomeView()
            }
        }
        .navigationSplitViewStyle(.balanced)
        .frame(minWidth: 900, minHeight: 520)
    }
}

// MARK: - Welcome screen

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "terminal")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("MacSysTools")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Select a tool from the sidebar to get started.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
