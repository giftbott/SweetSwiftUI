//
//  ImageGallery.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct ImageGallery: View {
  static private let galleryImages: [String] = Store().products.map { $0.imageName }
  @State private var productImages: [String] = galleryImages
  @State private var spacing: CGFloat = 20
  @State private var scale: CGFloat = 0.020
  @State private var angle: CGFloat = 5
  @GestureState private var translation: CGSize = .zero
  
  // MARK: Body
  
  var body: some View {
    VStack {
      Spacer()
      ZStack {
        backgroundCards
        frontCard
      }
      Spacer()
      controller
    }
    .edgesIgnoringSafeArea(.top)
  }
}


private extension ImageGallery {
  // MARK: View
  
  var frontCard: some View {
    let dragGesture = DragGesture()
      .updating($translation) { (value, state, _) in
        state = value.translation
    }
    return FruitCard(productImages[0])
      .offset(translation)
      .shadow(color: .primaryShadow, radius: 4, x: 2, y: 2)
      .onLongPressGesture(perform: {
        self.productImages.append(self.productImages.removeFirst())
      })
      .simultaneousGesture(dragGesture)
  }
  
  var backgroundCards: some View {
    ForEach(productImages.dropFirst().reversed(), id: \.self) {
      self.backgroundCard(image: $0)
    }
  }
  
  func backgroundCard(image: String) -> some View {
    let index = productImages.firstIndex(of: image)!
    let response = computeResponse(index: index)
    let animation = Animation.spring(response: response, dampingFraction: 0.68)
    return FruitCard(image)
      .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
      .offset(computePosition(index: index))
      .scaleEffect(computeScale(index: index))
      .rotation3DEffect(computeAngle(index: index), axis: (0,0,1))
      .transition(AnyTransition.scale.animation(animation))
      .animation(animation)
  }
    
  var controller: some View {
    let titles = ["간격", "크기", "각도"]
    let values = [$spacing, $scale, $angle]
    let ranges: [ClosedRange<CGFloat>] = [1.0...40.0, 0...0.05, -90.0...90.0]
    
    return VStack {
      ForEach(titles.indices) { i in
        HStack {
          Text(titles[i])
            .font(.system(size: 17))
            .frame(width: 80)
          Slider(value: values[i], in: ranges[i])
            .accentColor(Color.gray.opacity(0.25))
        }
      }
    }
    .padding()
  }
  
  
  // MARK: Computed Values
  
  func computePosition(index: Int) -> CGSize {
    let x = translation.width
    let y = translation.height - CGFloat(index) * spacing
    return CGSize(width: x, height: y)
  }
  
  func computeScale(index: Int) -> CGFloat {
    let cardScale = 1.0 - CGFloat(index) * (0.05 - scale)
    return max(cardScale, 0.1)
  }
  
  func computeAngle(index: Int) -> Angle {
    let degrees = Double(index) * Double(angle)
    return Angle(degrees: degrees)
  }
  
  func computeResponse(index: Int) -> Double {
    max(Double(index) * 0.04, 0.2)
  }
}


// MARK: - Previews

struct ImageGallery_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: ImageGallery())
  }
}
