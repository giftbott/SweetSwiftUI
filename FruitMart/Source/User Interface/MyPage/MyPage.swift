//
//  MyPage.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/03.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct MyPage: View {
  
  // MARK: Body
  
  var body: some View {
    NavigationView {
      Form {
        orderInfoSection
      }
      .navigationBarTitle("마이 페이지")
    }
  }
}


private extension MyPage {
  // MARK: View
  
  var orderInfoSection: some View {
    Section(header: Text("주문 정보").fontWeight(.medium)) {
      NavigationLink(destination: OrderListView()) {
        Text("주문 목록")
      }
      .frame(height: 44)
    }
  }
}


// MARK: - Previews

struct MyPage_Previews : PreviewProvider {
  static var previews: some View {
    Preview(source: MyPage())
  }
}

