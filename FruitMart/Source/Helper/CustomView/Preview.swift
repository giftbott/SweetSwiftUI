//
//  Preview.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct Preview<V: View>: View {
  enum Device: String, CaseIterable {
    case iPhone8 = "iPhone 8"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
  }

  let source: V
  var devices: [Device] = [.iPhone11Pro, .iPhone11ProMax, .iPhone8]
  var displayDarkMode: Bool = true

  // MARK: Body
  
  var body: some View {
    return Group {
      ForEach(devices, id: \.self) {
        self.previewSource(device: $0)
      }
      if !devices.isEmpty && displayDarkMode {
        self.previewSource(device: devices[0])
          .preferredColorScheme(.dark)
      }
    }
  }

  private func previewSource(device: Device) -> some View {
    source
      .previewDevice(PreviewDevice(rawValue: device.rawValue))
      .previewDisplayName(device.rawValue)
  }
}


// MARK: - Previews

struct Preview_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: Text("Hello, SwiftUI!"))
  }
}
