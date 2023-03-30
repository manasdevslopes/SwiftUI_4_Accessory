//
//  ShimmerEffectModifier.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 30/03/23.
//

import SwiftUI

struct ShimmerConfig {
  var tint: Color
  var highlight: Color
  var blur: CGFloat = 0
  var highlightOpacity: CGFloat = 1
  var speed: CGFloat = 2
}

/// Shimmer Effect Helper
fileprivate struct ShimmerEffectHelper: ViewModifier {
  var config: ShimmerConfig
  
  @State private var moveTo: CGFloat = -0.7
  
  func body(content: Content) -> some View {
    content
    /// Adding the shimmer animation with help of Masking Modifier.
    /// Hiding the normal One and Adding Shimmer One instead
      .hidden()
      .overlay {
        /// Changing the tint color
        Rectangle().fill(config.tint)
          .mask {
            content
          }
          .overlay {
            GeometryReader {
              let size = $0.size
              let extraOffset = size.height / 2.5
              
              Rectangle().fill(config.highlight)
                .mask {
                  Rectangle()
                  /// Gradient for glowing at the center
                    .fill(.linearGradient(colors: [
                      .white.opacity(0),
                      config.highlight.opacity(config.highlightOpacity),
                      .white.opacity(0)
                    ], startPoint: .top, endPoint: .bottom))
                    .blur(radius: config.blur)
                    .rotationEffect(.init(degrees: -70))
                    .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                    .offset(x: size.width * moveTo)
                }
            }
            .mask {
              content
            }
          }
        /// Animation Movement
          .onAppear {
            DispatchQueue.main.async {
              moveTo = 0.7
            }
          }
          .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
      }
  }
}

extension View {
  @ViewBuilder
  func shimmer(_ config: ShimmerConfig) -> some View {
    modifier(ShimmerEffectHelper(config: config))
  }
}




