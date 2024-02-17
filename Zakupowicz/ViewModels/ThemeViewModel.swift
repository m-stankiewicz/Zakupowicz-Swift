import Foundation

class ThemeViewModel: ObservableObject {
    @Published var isDarkModeEnabled: Bool = false
    
    func toggleTheme() {
        isDarkModeEnabled.toggle()
    }
}
