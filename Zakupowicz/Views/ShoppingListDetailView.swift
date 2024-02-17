import SwiftUI

struct ShoppingListDetailView: View {
    @ObservedObject var viewModel: ShoppingListDetailViewModel
    @State private var showingAddItem = false
    
    var body: some View {
        List {
            ForEach(viewModel.sortedItems) { item in
                HStack {
                    Button(action: {
                        viewModel.toggleIsBought(shoppingItem: item)
                    }) {
                        Image(systemName: item.isPurchased ? "checkmark.square" : "square")
                    }
                    .buttonStyle(BorderlessButtonStyle())

                    Text(item.name)
                    Spacer()
                    Text("\(item.priority.rawValue)")
                }
            }
            .onDelete(perform: viewModel.deleteItems)
        }
        .navigationTitle(viewModel.shoppingList.title)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showingAddItem = true }) {
                    Image(systemName: "plus")
                }
                Button(action: viewModel.toggleSorting) {
                    Image(systemName: viewModel.sortingState == .alphabetical ? "arrow.up.arrow.down.square" : "textformat.abc")
                }
                Button(action: viewModel.toggleAllItemsPurchased) {
                    Image(systemName: "checkmark.seal")
                }
            }
        }
        .sheet(isPresented: $showingAddItem) {
            AddShoppingItemView(viewModel: AddShoppingItemViewModel(detailViewModel: viewModel))
        }
    }
}
