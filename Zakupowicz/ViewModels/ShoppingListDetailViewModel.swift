import Foundation
enum SortingState {
    case alphabetical
    case priority
}
class ShoppingListDetailViewModel: ObservableObject {
    @Published var shoppingList: ShoppingList
    @Published var sortingState: SortingState = .alphabetical
    var totalItemsCount: Int {
        shoppingList.items.count
    }

    var purchasedItemsCount: Int {
        shoppingList.items.filter { $0.isPurchased }.count
    }
    
    init(shoppingList: ShoppingList) {
        self.shoppingList = shoppingList
    }
    
    var sortedItems: [ShoppingItem] {
        switch sortingState {
        case .alphabetical:
            return shoppingList.items.sorted { $0.name < $1.name }
        case .priority:
            return shoppingList.items.sorted {
                if $0.priority == $1.priority {
                    return $0.name < $1.name
                }
                return $0.priority.rawValue > $1.priority.rawValue
            }
        }
    }

    func toggleSorting() {
        sortingState = sortingState == .alphabetical ? .priority : .alphabetical
    }

    func deleteItems(at offsets: IndexSet) {
        shoppingList.remove(offsets: offsets)
    }
    
    func addItem(name: String, priority: ShoppingItem.Priority) {
        let newItem = ShoppingItem(name: name, isPurchased: false, priority: priority)
        self.objectWillChange.send()
        shoppingList.append(item: newItem)
    }
    func toggleIsBought(shoppingItem: ShoppingItem) {
        if let index = shoppingList.items.firstIndex(where: { $0.id == shoppingItem.id }) {
            shoppingList.items[index].isPurchased.toggle()
            objectWillChange.send()
        }
    }

    func toggleAllItemsPurchased() {
        let allPurchased = shoppingList.items.allSatisfy { $0.isPurchased }
        shoppingList.items.forEach { $0.isPurchased = !allPurchased }
        objectWillChange.send()
    }
}
