//
//  OrderCompletedMessage.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct OrderCompletedMessage: View {
  var body: some View {
    Text("주문 완료!")
      .font(.system(size: 24))
      .bold()
      .kerning(2)
  }
}


// MARK: - Previews

struct OrderCompletedMessage_Previews: PreviewProvider {
  static var previews: some View {
    Color.primary.colorInvert()
      .popup(isPresented: .constant(true)) { OrderCompletedMessage() }
      .edgesIgnoringSafeArea(.vertical)
  }
}
