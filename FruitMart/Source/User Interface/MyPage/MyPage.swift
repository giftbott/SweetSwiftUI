//
//  MyPage.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/03.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct MyPage: View {
  @EnvironmentObject var store: Store
  @State private var pickedImage: Image = Image(systemName: "person.crop.circle")
  @State private var isPickerPresented: Bool = false
  @State private var nickname: String = ""
  private let pickerDataSource: [CGFloat] = [140, 150, 160]
  
  // MARK: Body
  
  var body: some View {
    NavigationView {
      VStack {
        userInfo
        
        Form {
          orderInfoSection
          appSettingSection
        }
      }
      .navigationBarTitle("마이 페이지")
    }
    .sheet(isPresented: $isPickerPresented) {
      ImagePickerView(pickedImage: self.$pickedImage)
    }
  }
}


private extension MyPage {
  // MARK: View
  
  var userInfo: some View {
    VStack {
      profileImage
      nicknameTextField
    }
    .frame(maxWidth: .infinity, minHeight: 200)
    .background(Color.background)
  }
  
  var profileImage: some View {
    pickedImage
      .resizable().scaledToFill()
      .clipShape(Circle())
      .frame(width: 100, height: 100)
      .overlay(pickImageButton.offset(x: 8, y: 0), alignment: .bottomTrailing)
  }
  
  var pickImageButton: some View {
    Button(action: {
      self.isPickerPresented = true
    }) {
      Circle()
        .fill(Color.white)
        .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
        .overlay(Image("pencil").foregroundColor(.black))
        .frame(width: 32, height: 32)
    }
  }
  
  var nicknameTextField: some View {
    TextField("닉네임", text: $nickname)
      .font(.system(size: 25, weight: .medium))
      .textContentType(.nickname)
      .multilineTextAlignment(.center)
      .autocapitalization(.none)
  }
  
  var orderInfoSection: some View {
    Section(header: Text("주문 정보").fontWeight(.medium)) {
      NavigationLink(destination: OrderListView()) {
        Text("주문 목록")
      }
      .frame(height: 44)
    }
  }
  
  var appSettingSection: some View {
    Section(header: Text("앱 설정").fontWeight(.medium)) {
      Toggle("즐겨찾는 상품 표시", isOn: $store.appSetting.showFavoriteList)
        .frame(height: 44)
      
      productHeightPicker
    }
  }
  
  var productHeightPicker: some View {
    VStack(alignment: .leading) {
      Text("상품 이미지 높이 조절")
      
      Picker("", selection: $store.appSetting.productRowHeight) {
        ForEach(pickerDataSource, id: \.self) {
          Text(String(format: "%.0f", $0)).tag($0)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
    }
    .frame(height: 72)
  }
}


// MARK: - Previews

struct MyPage_Previews : PreviewProvider {
  static var previews: some View {
    Preview(source: MyPage())
  }
}

