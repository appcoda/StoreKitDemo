//
//  RecipesModel.swift
//  StoreKitLocalDemo
//
//  Created by Gabriel Theodoropoulos.
//

import Foundation
import StoreKit

class RecipesModel: ObservableObject {
    @Published var recipes = [RecipeInfo]()
    @Published var recipeProducts = [SKProduct]()
    
    
    init() {
        loadRecipes()
        loadProducts()
    }
    
    
    private func loadRecipes() {
        guard let url = Bundle.main.url(forResource: "Recipes", withExtension: "json"), let data = try? Data(contentsOf: url) else {
            return
        }
        
        let decoder = JSONDecoder()
        guard let loadedRecipes = try? decoder.decode([RecipeInfo].self, from: data) else { return }
        recipes = loadedRecipes
    }
    
    
    
    
    fileprivate func loadProducts() {
        IAPManager.shared.getProducts { (productResults) in
            DispatchQueue.main.async {
                switch productResults {
                    case .success(let fetchedProducts): self.recipeProducts = fetchedProducts
                    case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func getProduct(with identifier: String?) -> SKProduct? {
        guard let id = identifier else { return nil }
        return recipeProducts.filter({ $0.productIdentifier == id }).first
    }
    
    
    func buyRecipe(using product: SKProduct?, completion: @escaping (_ success: Bool) -> Void) {
        guard let product = product else { return }
        IAPManager.shared.buy(product: product) { (iapResult) in
            switch iapResult {
                case .success(let success):
                    if success {
                        self.recipes.filter({ $0.productID == product.productIdentifier }).first?.markAsPurchased()
                    }
                    completion(true)
                case .failure(_): completion(false)
            }
        }
    }
    
    
    func resetPurchasedState() {
        recipes.forEach { $0.markAsPurchased(false) }
    }
}
