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
    NavigationView {
      List(store.products) { product in
        NavigationLink(destination: Text("상세 정보")) {
          ProductRow(product: product)
        }
      }
      .navigationBarTitle("과일마트")
    }
  }
}


// MARK: - Previews

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home(store: Store())
  }
}
