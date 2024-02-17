import SwiftUI

@main
struct ZakupowiczApp: App {
    @StateObject var themeViewModel = ThemeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ShoppingListView()
                .environmentObject(themeViewModel)
                .preferredColorScheme(themeViewModel.isDarkModeEnabled ? .dark : .light)
        }
    }
}

