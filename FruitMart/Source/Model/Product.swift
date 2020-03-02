//
//  Product.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct Product {
  let id: UUID = UUID()
  let name: String
  let imageName: String
  let price: Int
  let description: String
  var isFavorite: Bool = false
}

extension Product: Codable {}
extension Product: Identifiable {}
extension Product: Equatable {}


let productSamples = [
  Product(name: "나는야 무화과", imageName: "fig", price: 3100, description: "소화가 잘되고 변비에 좋은 달달한 국내산 무화과에요. 고기와 찰떡궁합!"),
  Product(name: "유기농 아보카도", imageName: "avocado", price: 2900, description: "미네랄도 풍부하고, 요리 장식과 소스로도 좋은 아보카도입니다"),
  Product(name: "바나나 안 바나나", imageName: "banana", price: 2400, description: "달콤한 맛의 바나나. 이렇게 맛있으니 내가 바나나 안 바나나?", isFavorite: true),
  Product(name: "아임 파인애플", imageName: "pineapple", price: 3000, description: "소화와 피로회복, 비타민까지! 파인애플로 맛과 영양까지 한번에!"),
  Product(name: "시원한 수박", imageName: "watermelon", price: 3500, description: "아이들이 너무나 좋아하는 시원하고 달콤한 하우스 수박이에요", isFavorite: true),
  Product(name: "베리베리 블루베리", imageName: "blueberry", price: 2300, description: "타임지 선정 10대 파워 푸드. 신이 내린 선물이라 불리는 블루베리에요"),
]

