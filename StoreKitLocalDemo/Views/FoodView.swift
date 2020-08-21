//
//  FoodView.swift
//  StoreKitLocalDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI

struct FoodView: View {
    @ObservedObject var recipe: RecipeInfo
    
    var body: some View {
        HStack {
            Image(recipe.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            
            Spacer()
            
            Text(recipe.name)
                .font(.headline)
            
            Spacer()
            
            if !recipe.isPurchased {
                Image(systemName: "lock.fill")
                    .padding(.trailing, 10)
            }
        }
        .padding(8)
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(recipe: RecipeInfo())
            .previewLayout(.sizeThatFits)
    }
}
