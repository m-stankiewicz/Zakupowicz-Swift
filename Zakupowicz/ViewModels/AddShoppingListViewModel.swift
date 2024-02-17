import Foundation

class AddShoppingListViewModel: ObservableObject {
    var shoppingListViewModel: ShoppingListViewModel

    init(shoppingListViewModel: ShoppingListViewModel) {
        self.shoppingListViewModel = shoppingListViewModel
    }

    func addShoppingList(title: String) {
        shoppingListViewModel.addShoppingList(title: title)
    }
}
