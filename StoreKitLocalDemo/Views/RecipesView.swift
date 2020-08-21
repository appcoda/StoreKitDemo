//
//  RecipesView.swift
//  StoreKitLocalDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI
import StoreKit

struct RecipesView: View {
    @ObservedObject var recipesModel = RecipesModel()
    @State private var product: SKProduct?
    @State var alertVisible = false
    @State var failedTransaction = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipesModel.recipes) { (recipe) in
                    Button(action: {
                        if !recipe.isPurchased {
                            if let recipeProduct = recipesModel.getProduct(with: recipe.productID) {
                                self.product = recipeProduct
                                self.alertVisible.toggle()
                            }
                        } else {
                            print("Recipe already purchased!")
                        }
                    }, label: {
                        FoodView(recipe: recipe)
                    })
                }
            }
            .alert(isPresented: $alertVisible, content: {
                Alert(title: Text(product!.localizedTitle),
                      message: Text(product!.localizedDescription),
                      primaryButton: .default(Text("Get recipe for \(IAPManager.shared.getPriceFormatted(for: self.product!)!)"), action: {
                        self.recipesModel.buyRecipe(using: self.product) { (success) in
                            self.failedTransaction = !success
                        }
                      }),
                      secondaryButton: .cancel())
            })
            .navigationBarTitle("Recipes")
            .navigationBarItems(
                leading:
                Button(action: {
                    self.recipesModel.resetPurchasedState()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            )
        }
        .alert(isPresented: $failedTransaction, content: {
            Alert(title: Text("The transaction could not be completed."))
        })
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
