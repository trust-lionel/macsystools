import SwiftUI

struct SidebarView: View {

    @Binding var selectedTool: Tool?

    var body: some View {
        List(selection: $selectedTool) {
            ForEach(Category.allCases) { category in
                Section(category.rawValue) {
                    ForEach(category.tools) { tool in
                        Label(tool.rawValue, systemImage: tool.sfSymbol)
                            .tag(tool)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("MacSysTools")
    }
}
