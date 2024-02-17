import Foundation
import Combine

class ShoppingListViewModel: ObservableObject {
    @Published var shoppingLists: [ShoppingList] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        loadFromUserDefaults()
    }

    func addShoppingList(title: String) {
        let newList = ShoppingList(title: title)
        shoppingLists.append(newList)
        observeShoppingList(newList)
        saveToUserDefaults()
    }

    func deleteLists(at offsets: IndexSet) {
        shoppingLists.remove(atOffsets: offsets)
        saveToUserDefaults()
    }
    
    func itemCounts(for shoppingList: ShoppingList) -> (total: Int, purchased: Int) {
        let totalItems = shoppingList.items.count
        let purchasedItems = shoppingList.items.filter { $0.isPurchased }.count
        return (total: totalItems, purchased: purchasedItems)
    }

    private func observeShoppingList(_ shoppingList: ShoppingList) {
        shoppingList.objectWillChange
            .sink { [weak self] _ in
                self?.saveToUserDefaults()
            }.store(in: &cancellables)
        shoppingList.$items
            .sink { [weak self] _ in
                self?.saveToUserDefaults()
            }.store(in: &cancellables)
        shoppingList.items.forEach { item in
            observeShoppingItem(item)
        }
    }
    
    private func observeShoppingItem(_ item: ShoppingItem) {
        item.objectWillChange
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.saveToUserDefaults()
                }
            }.store(in: &cancellables)
    }

    private func saveToUserDefaults() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(shoppingLists)
            UserDefaults.standard.set(data, forKey: "shoppingLists")
        } catch {
            print("Failed to save shopping lists.")
        }
    }

    private func loadFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: "shoppingLists") else { return }
        do {
            let decoder = JSONDecoder()
            shoppingLists = try decoder.decode([ShoppingList].self, from: data)
            shoppingLists.forEach { observeShoppingList($0) }
        } catch {
            print("Failed to load shopping lists.")
        }
    }
}
