import Foundation

class ShoppingList: ObservableObject, Identifiable, Codable {
    var id = UUID()
    @Published var title: String
    @Published var items: [ShoppingItem]

    enum CodingKeys: CodingKey {
        case id, title, items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        items = try container.decode([ShoppingItem].self, forKey: .items)
    }
    
    func append(item: ShoppingItem)
    {
        self.items.append(item)
        self.objectWillChange.send()
    }
    
    func toggleIsPurchased(for item: ShoppingItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].isPurchased.toggle()
        objectWillChange.send()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(items, forKey: .items)
    }
    
    func remove(offsets: IndexSet) {
        self.items.remove(atOffsets: offsets)
    }
    
    init(title: String, items: [ShoppingItem] = []) {
        self.title = title
        self.items = items
    }
}
