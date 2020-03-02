//
//  Order.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct Order: Identifiable {
  static var orderSequence = sequence(first: lastOrderID + 1) { $0 &+ 1 }
  static var lastOrderID: Int {
    get { UserDefaults.standard.integer(forKey: "LastOrderID") }
    set { UserDefaults.standard.set(newValue, forKey: "LastOrderID") }
  }
  
  let id: Int
  let product: Product
  let quantity: Int
  
  var price: Int {
    product.price * quantity
  }
}

extension Order: Codable {}
