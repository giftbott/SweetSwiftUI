//
//  BundleExtension.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

extension Bundle {
  func decode<T: Decodable>(filename: String, as type: T.Type) -> T {
    guard let url = self.url(forResource: filename, withExtension: nil) else {
      fatalError("번들에 \(filename)이 없습니다.")
    }
    guard let data = try? Data(contentsOf: url) else {
      fatalError("\(url)로부터 데이터를 불러올 수 없습니다.")
    }
    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
      fatalError("데이터 복호화에 실패했습니다.")
    }
    return decodedData
  }
}
