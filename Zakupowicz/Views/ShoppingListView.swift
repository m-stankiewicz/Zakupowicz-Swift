import SwiftUI

struct ShoppingListView: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @StateObject private var viewModel = ShoppingListViewModel()
    @State private var showingAddList = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.shoppingLists.indices, id: \.self) { index in
                let shoppingList = viewModel.shoppingLists[index]
                let itemCounts = viewModel.itemCounts(for: shoppingList)
                NavigationLink(destination: ShoppingListDetailView(viewModel: ShoppingListDetailViewModel(shoppingList: shoppingList))) {
                        HStack {
                            Text(shoppingList.title)
                            Spacer()
                            Text("\(itemCounts.purchased)/\(itemCounts.total)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteLists)
            }
            .navigationTitle("Shopping Lists")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddList = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { themeViewModel.toggleTheme() }) {
                        Image(systemName: themeViewModel.isDarkModeEnabled ? "sun.max.fill" : "moon.fill")
                    }
                }

            }
            .sheet(isPresented: $showingAddList) {
                AddShoppingListView(viewModel: AddShoppingListViewModel(shoppingListViewModel: viewModel))
            }
        }
    }
    
    func deleteLists(at offsets: IndexSet) {
        viewModel.deleteLists(at: offsets)
    }
}
