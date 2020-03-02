//
//  Stripes.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct Stripes: Shape, Hashable {
  var stripes: Int = 30
  var insertion: Bool = true
  var ratio: CGFloat
  
  var animatableData: CGFloat {
    get { ratio }
    set { ratio = newValue }
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let stripeWidth = rect.width / CGFloat(stripes)
    let rects = (0..<stripes).map { (index: Int) -> CGRect in
      let xOffset = CGFloat(index) * stripeWidth
      let adjustment = insertion ? 0 : (stripeWidth * (1 - ratio))
      return CGRect(
        x: xOffset + adjustment, y: 0,
        width: stripeWidth * ratio, height: rect.height
      )
    }
    path.addRects(rects)
    return path
  }
}


// MARK: - Previews

struct Stripes_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Stripes(insertion: true, ratio: 0.2).previewDisplayName("20%")
      Stripes(insertion: true, ratio: 0.5).previewDisplayName("50%")
      Stripes(insertion: true, ratio: 0.8).previewDisplayName("80%")
      Stripes(insertion: true, ratio: 1.0).previewDisplayName("100%")
      
      Stripes(insertion: false, ratio: 0.8).previewDisplayName("80%")
      Stripes(insertion: false, ratio: 0.5).previewDisplayName("50%")
      Stripes(insertion: false, ratio: 0.2).previewDisplayName("20%")
      Stripes(insertion: false, ratio: 0.0).previewDisplayName("0%")
    }
    .previewLayout(.fixed(width: 350, height: 30))
  }
}
