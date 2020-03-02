//
//  FavoriteButton.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
  @EnvironmentObject private var store: Store
  let product: Product
  
  private var imageName: String {
    product.isFavorite ? "heart.fill" : "heart"
  }
  
  var body: some View {
    Symbol(imageName, scale: .large, color: .peach)
      .frame(width: 32, height: 32)
      .onTapGesture {
        withAnimation {
          self.store.toggleFavorite(of: self.product)
        }
      }
  }
}


// MARK: - Previews

struct FavoriteButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      FavoriteButton(product: productSamples[0])
      FavoriteButton(product: productSamples[2])
    }
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
