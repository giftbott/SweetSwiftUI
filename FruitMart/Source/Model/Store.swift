//
//  Store.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

final class Store: ObservableObject {
  @Published var products: [Product]
  @Published var orders: [Order] = []
  
  // MARK: Initialization
  
  init(filename: String = "ProductData.json") {
    self.products = Bundle.main.decode(filename: filename, as: [Product].self)
  }
}


// MARK: - Action

extension Store {
  func toggleFavorite(of product: Product) {
    guard let index = products.firstIndex(of: product) else { return }
    products[index].isFavorite.toggle()
  }
  
  func placeOrder(product: Product, quantity: Int) {
    let nextID = Order.orderSequence.next()!
    let order = Order(id: nextID, product: product, quantity: quantity)
    orders.append(order)
  }
}
