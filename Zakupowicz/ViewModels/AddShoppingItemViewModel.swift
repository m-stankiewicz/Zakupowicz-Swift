import Foundation

class AddShoppingItemViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var priority: ShoppingItem.Priority = .medium
    var detailViewModel: ShoppingListDetailViewModel

    init(detailViewModel: ShoppingListDetailViewModel) {
        self.detailViewModel = detailViewModel
    }
    
    func addNewItem() {
        detailViewModel.addItem(name: name, priority: priority)
    }
}

