//
//  MainTabView.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
  private enum Tabs {
    case home, recipe, gallery, myPage
  }
  
  @State private var selectedTab: Tabs = .home
  
  // MARK: Body
  
  var body: some View {
    TabView(selection: $selectedTab) {
      Group {
        home
        recipe
        imageGallery
        myPage
      }
      .accentColor(.primary)
    }
    .accentColor(.peach)
    .edgesIgnoringSafeArea(edges)
    .statusBar(hidden: selectedTab == .recipe)
  }
}


private extension MainTabView {
  // MARK: View
  
  var home: some View {
    Home()
      .tag(Tabs.home)
      .tabItem(image: "house", text: "홈")
      .onAppear { UITableView.appearance().separatorStyle = .none }
  }
  
  var recipe: some View {
    RecipeView()
      .tag(Tabs.recipe)
      .tabItem(image: "book", text: "레시피")
  }
  
  var imageGallery: some View {
    ImageGallery()
      .tag(Tabs.gallery)
      .tabItem(image: "photo.on.rectangle", text: "갤러리")
  }
  
  var myPage: some View {
    MyPage()
      .tag(Tabs.myPage)
      .tabItem(image: "person", text: "마이페이지")
      .onAppear { UITableView.appearance().separatorStyle = .singleLine }
  }
  
  // MARK: Computed Values
  
  var edges: Edge.Set {
    if #available(iOS 13.4, *) {
      return .init()
    } else {
      return .top
    }
  }
}


// MARK: - View Extension

fileprivate extension View {
  func tabItem(image: String, text: String) -> some View {
    self.tabItem {
      Symbol(image, scale: .large)
        .font(Font.system(size: 17, weight: .light))
      Text(text)
    }
  }
}


// MARK: - Preview

struct MainTabView_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: MainTabView())
      .environmentObject(Store())
  }
}
