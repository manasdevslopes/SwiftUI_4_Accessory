//
//  MorphingView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 18/01/23.
//

import SwiftUI

struct MorphingView: View {
  @State private var currentImage: CustomShape = .cloud
  @State private var pickerImage: CustomShape = .cloud
  @State private var turnOffImageMorph: Bool = false
  @State private var blurRadius: CGFloat = 0
  @State private var animateMorph: Bool = false
  
  var body: some View {
    VStack {
      GeometryReader { proxy in
        let size = proxy.size
        Image("manas_iosdev")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .offset(x: 20, y: 84)
          .frame(width: size.width, height: size.height)
          .clipped()
          .overlay {
            Rectangle()
              .fill(.white)
              .opacity(turnOffImageMorph ? 1 : 0)
          }
          .mask {
            // MARK: - Morphing Shape with help of Canvas and Filters
            Canvas {context, size in
              // MARK: - Morphing filters
              // MARK: - For More Morph shape Link change this
              context.addFilter(.alphaThreshold(min: 0.4))
              context.addFilter(.blur(radius: blurRadius >= 20 ? 20 - (blurRadius - 20) : blurRadius))
              
              // MARK: - Draw Inside Layer
              context.drawLayer { ctx in
                if let resolvedImage = context.resolveSymbol(id: 1) {
                  ctx.draw(resolvedImage, at: CGPoint(x: size.width / 2, y: size.height / 2), anchor: .center)
                }
              }
              
            } symbols: {
              // MARK: - Giving Images with ID
              ResolvedImage(currentImage: $currentImage)
                .tag(1)
            }
            .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
              if animateMorph {
                if blurRadius <= 40 {
                  blurRadius += 0.5
                  
                  if blurRadius.rounded() == 20 {
                    currentImage = pickerImage
                  }
                }
                
                if blurRadius.rounded() == 40 {
                  // reset blurRadius
                  animateMorph = false
                  blurRadius = 0
                }
              }
            }
          }
      }
      .frame(height: 400)
      
      // MARK: - Segmented Picker
      Picker("", selection: $pickerImage) {
        ForEach(CustomShape.allCases, id: \.rawValue) { shape in
          Image(systemName: shape.rawValue)
            .tag(shape)
        }
      }
      .pickerStyle(.segmented)
      // MARK: - Avoid Tap Until Current Animation is Finished
      .overlay {
        Rectangle()
          .fill(.primary)
          .opacity(animateMorph ? 0.05 : 0)
      }
      .padding(15)
      .padding(.top, -50)
      .onChange(of: pickerImage) { newValue in
        animateMorph = true
      }
      
      Toggle("Turn Off Image Morph", isOn: $turnOffImageMorph)
        .fontWeight(.semibold)
        .padding(.horizontal, 15)
        .padding(.top, 10)
      
      Slider(value: $blurRadius, in: 0...40)
    }
    .offset(y: -50)
    .frame(maxHeight: .infinity, alignment: .top)
    .preferredColorScheme(.dark)
  }
}

struct ResolvedImage: View {
  @Binding var currentImage: CustomShape
  
  var body: some View {
    Image(systemName: currentImage.rawValue)
      .font(.system(size: 200))
      .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8), value: currentImage)
      .frame(width: 300, height: 300)
  }
}
struct MorphingView_Previews: PreviewProvider {
  static var previews: some View {
    MorphingView()
  }
}
