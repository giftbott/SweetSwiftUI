//
//  Popup.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

enum PopupStyle {
  case none
  case blur
  case dimmed
}

// MARK: - Popup

fileprivate struct Popup<Message: View>: ViewModifier {
  let size: CGSize?
  let style: PopupStyle
  let message: Message
  
  init(
    size: CGSize? = nil,
    style: PopupStyle = .none,
    message: Message
  ) {
    self.size = size
    self.style = style
    self.message = message
  }

  func body(content: Content) -> some View {
    content
      .blur(radius: style == .blur ? 2 : 0)
      .overlay(Rectangle()
        .fill(Color.black.opacity(style == .dimmed ? 0.4 : 0)))
      .overlay(popupContent)
  }

  private var popupContent: some View {
    GeometryReader { g in
      VStack { self.message }
        .frame(width: self.size?.width ?? g.size.width * 0.6,
               height: self.size?.height ?? g.size.height * 0.25)
        .background(Color.primary.colorInvert())
        .cornerRadius(12)
        .shadow(color: .primaryShadow, radius: 15, x: 5, y: 5)
        .overlay(self.checkCircleMark, alignment: .top)
        // iOS 13과 iOS 14의 지오메트리 리더 뷰 정렬 위치가 달라졌으므로 조정
        .position(x: g.size.width / 2, y: g.size.height / 2)
    }
  }

  private var checkCircleMark: some View {
    Symbol("checkmark.circle.fill", color: .peach)
      .font(Font.system(size: 60).weight(.semibold))
      // iOS 13과 14에서 크기 차이가 있어 조정
      .background(Color.white.scaleEffect(0.7))
      .offset(x: 0, y: -20)
  }
}


fileprivate struct PopupToggle: ViewModifier {
  @Binding var isPresented: Bool
  func body(content: Content) -> some View {
    content
      .disabled(isPresented)
      .onTapGesture { self.isPresented.toggle() }
  }
}

fileprivate struct PopupItem<Item: Identifiable>: ViewModifier {
  @Binding var item: Item?
  func body(content: Content) -> some View {
    content
      .disabled(item != nil)
      .onTapGesture { self.item = nil }
  }
}


// MARK: - View Extension

extension View {
  func popup<Content: View>(
    isPresented: Binding<Bool>,
    size: CGSize? = nil,
    style: PopupStyle = .none,
    @ViewBuilder content: () -> Content
  ) -> some View {
    if isPresented.wrappedValue {
      let popup = Popup(size: size, style: style, message: content())
      let popupToggle = PopupToggle(isPresented: isPresented)
      let modifiedContent = self.modifier(popup).modifier(popupToggle)
      return AnyView(modifiedContent)
    } else {
      return AnyView(self)
    }
  }
  
  func popup<Content: View, Item: Identifiable>(
    item: Binding<Item?>,
    size: CGSize? = nil,
    style: PopupStyle = .none,
    @ViewBuilder content: (Item) -> Content
  ) -> some View {
    if let selectedItem = item.wrappedValue {
      let content = content(selectedItem)
      let popup = Popup(size: size, style: style, message: content)
      let popupItem = PopupItem(item: item)
      let modifiedContent = self.modifier(popup).modifier(popupItem)
      return AnyView(modifiedContent)
    } else {
      return AnyView(self)
    }
  }
  
  func popupOverContext<Item: Identifiable, Content: View>(
    item: Binding<Item?>,
    size: CGSize? = nil,
    style: PopupStyle = .none,
    ignoringEdges edges: Edge.Set = .all,
    @ViewBuilder content: (Item) -> Content
  ) -> some View  {
    let isNonNil = item.wrappedValue != nil
    return ZStack {
      self
        .blur(radius: isNonNil && style == .blur ? 2 : 0)
      
      if isNonNil {
        Color.black
          .luminanceToAlpha()
          .popup(item: item, size: size, style: style, content: content)
          .edgesIgnoringSafeArea(edges)
      }
    }
  }
}
