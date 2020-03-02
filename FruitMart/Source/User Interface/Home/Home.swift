//
//  Home.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct Home: View {
  @EnvironmentObject private var store: Store
  
  @State private var quickOrder: Product?
  
  // MARK: Body
  
  var body: some View {
    NavigationView {
      List(store.products) { product in
        NavigationLink(destination: ProductDetailView(product: product)) {
          ProductRow(product: product, quickOrder: self.$quickOrder)
        }
      }
      .navigationBarTitle("과일마트")
    }
    .popupOverContext(item: $quickOrder, style: .blur, content: popupMessage(product:))
  }
}


private extension Home {
  // MARK: View
  
  func popupMessage(product: Product) -> some View {
    let name = product.name.split(separator: " ").last!
    return VStack {
      Text(name)
        .font(.title).bold().kerning(3)
        .foregroundColor(.peach)
        .padding()
      
      OrderCompletedMessage()
    }
  }
}

// MARK: - Previews

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: Home())
      .environmentObject(Store())
  }
}
