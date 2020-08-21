//
//  RecipeInfo.swift
//  StoreKitLocalDemo
//
//  Created by Gabriel Theodoropoulos.
//

import Foundation

class RecipeInfo: Codable, Identifiable, ObservableObject {
    var id: Int?
    var image = "salad"
    var name = "Recipe Name"
    var productID: String?
    @Published var isPurchased = false
    
    
    init() { }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        image = try container.decode(String.self, forKey: .image)
        name = try container.decode(String.self, forKey: .name)
        productID = try container.decode(String.self, forKey: .productID)
        getPurchasedState()
    }
    
    
    fileprivate func getPurchasedState() {
        guard let id = id else { return }
        isPurchased = UserDefaults.standard.bool(forKey: "\(id)")
    }
    
    
    func markAsPurchased(_ state: Bool = true) {
        guard let id = id else { return }
        isPurchased = state
        UserDefaults.standard.set(state, forKey: "\(id)")
    }
    
    
    enum CodingKeys: CodingKey {
        case id, image, name, productID
    }
    
}
