//
//  Home.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct Home: View {
  let store: Store
  
  // MARK: Body
  
  var body: some View {
    List(store.products) { product in
      ProductRow(product: product)
    }
  }
}


// MARK: - Previews

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home(store: Store())
  }
}
