import Foundation

class ShoppingItem: ObservableObject, Identifiable, Codable {
    var id = UUID()
    @Published var name: String
    @Published var isPurchased: Bool
    @Published var priority: Priority

    enum Priority: Int, Codable, CaseIterable {
        case high = 3
        case medium = 2
        case low = 1
        
        var rawValue: String {
            switch self {
                case .high:
                    return "High"
                case .medium:
                    return "Medium"
                case .low:
                    return "Low"
            }
        }
    }
    
    enum CodingKeys: CodingKey {
        case id, name, isPurchased, priority
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        isPurchased = try container.decode(Bool.self, forKey: .isPurchased)
        priority = try container.decode(Priority.self, forKey: .priority)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isPurchased, forKey: .isPurchased)
        try container.encode(priority, forKey: .priority)
    }
    
    init(name: String, isPurchased: Bool = false, priority: Priority) {
        self.name = name
        self.isPurchased = isPurchased
        self.priority = priority
    }
}

