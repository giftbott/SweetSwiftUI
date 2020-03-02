//
//  SceneDelegate.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    configureAppearance()
    
    let rootView = MainTabView()
      .environmentObject(Store())
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: rootView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
  private func configureAppearance() {
    UINavigationBar.appearance().largeTitleTextAttributes = [
      .foregroundColor: UIColor(named: "peach")!
    ]
    UINavigationBar.appearance().titleTextAttributes = [
      .foregroundColor: UIColor(named: "peach")!
    ]
    UITableView.appearance().backgroundColor = .clear
    UISlider.appearance().thumbTintColor = UIColor(named: "peach")
  }
}
