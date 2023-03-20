//
//  ExpandedBottomSheet.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 20/03/23.
//

import SwiftUI

struct ExpandedBottomSheet: View {
  @Binding var expandSheet: Bool
  var animation: Namespace.ID
  
  @State private var animateContent: Bool = false
  @State private var offsetY: CGFloat = 0
  
  var body: some View {
    GeometryReader {
      let size = $0.size
      let safeArea = $0.safeAreaInsets
      
      ZStack {
        RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: .continuous).fill(.ultraThickMaterial)
          .overlay {
            RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: .continuous).fill(Color("BG"))
              .opacity(animateContent ? 1 : 0)
          }
          .overlay(alignment: .top) {
            MusicInfo(expandSheet: $expandSheet, animation: animation).allowsHitTesting(false)
              .opacity(animateContent ? 0 : 1)
          }
          .matchedGeometryEffect(id: "BGVIEW", in: animation)
        
        VStack(spacing: 15) {
          /// - Grab Indicator
          Capsule().fill(.gray).frame(width: 40, height: 5)
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : size.height)
          
          /// - Hero Image
          GeometryReader {
            let size = $0.size
            
            Image("manas_iosdev")
              .resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
              .clipShape(RoundedRectangle(cornerRadius: animateContent ? 15 : 5, style: .continuous))
          }
          .matchedGeometryEffect(id: "MANAS", in: animation)
          .frame(height: size.width - 50)
          /// - For smaller devices padding will be 10, bigger devices padding will be 30
          .padding(.vertical, size.height < 700 ? 10 : 30)
          
          /// - Player View
          PlayerView(size)
          /// - Moving it from Bottom
            .offset(y: animateContent ? 0 : size.height)
        }
        .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
        .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .clipped()
      }
      .contentShape(Rectangle())
      .offset(y: offsetY)
      .gesture(
        DragGesture()
          .onChanged({ value in
            let translationY = value.translation.height
            offsetY = (translationY > 0 ? translationY : 0)
          })
          .onEnded({ value in
            withAnimation(.easeInOut(duration: 0.3)) {
              if offsetY > size.height * 0.4 {
                expandSheet = false
                animateContent = false
              } else {
                offsetY = .zero
              }
            }
          })
      )
      .ignoresSafeArea(.container, edges: .all)
    }
    .onAppear {
      withAnimation(.easeInOut(duration: 0.35)) {
        animateContent = true
      }
    }
    .preferredColorScheme(.dark)
  }
}

struct ExpandedBottomSheet_Previews: PreviewProvider {
  static var previews: some View {
    MusicBottomSheet()
  }
}


extension ExpandedBottomSheet {
  @ViewBuilder
  func PlayerView(_ mainSize: CGSize) -> some View {
    GeometryReader {
      let size = $0.size
      let spacing = size.height * 0.04
      
      VStack(spacing: spacing) {
        VStack(spacing: spacing) {
          HStack(alignment: .center, spacing: 15) {
            VStack(alignment: .leading, spacing: 4) {
              Text("Look What You Made Me do").font(.title3).fontWeight(.semibold)
              Text("Manas iOSDev").foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button { } label: {
              Image(systemName: "ellipsis").foregroundColor(.white).padding(12)
                .background {
                  Circle().fill(.ultraThinMaterial).environment(\.colorScheme, .light)
                }
            }
          }
          
          Capsule()
            .fill(.ultraThinMaterial).environment(\.colorScheme, .light).frame(height: 5).padding(.top, spacing)
          
          HStack {
            Text("0:00").font(.caption).foregroundColor(.gray)
            Spacer(minLength: 0)
            Text("3:33").font(.caption).foregroundColor(.gray)
          }
        }
        .frame(height: size.height / 2.5, alignment: .top)
        
        HStack(spacing: size.width * 0.18) {
          Button { } label: {
            Image(systemName: "backward.fill")
              .font(size.height < 300 ? .title3 : .title)
          }
          
          Button { } label: {
            Image(systemName: "pause.fill")
              .font(size.height < 300 ? .largeTitle : .system(size: 50))
          }
          
          Button { } label: {
            Image(systemName: "forward.fill")
              .font(size.height < 300 ? .title3 : .title)
          }
        }
        .foregroundColor(.white)
        .frame(maxHeight: .infinity)
        
        VStack(spacing: spacing) {
          HStack(spacing: 15) {
            Image(systemName: "speaker.fill").foregroundColor(.gray)
            Capsule().fill(.ultraThinMaterial).environment(\.colorScheme, .light).frame(height: 5)
            Image(systemName: "speaker.wave.3.fill").foregroundColor(.gray)
          }
          
          HStack(alignment: .top, spacing: size.width * 0.18) {
            Button { } label: {
              Image(systemName: "quote.bubble")
                .font(.title2)
            }
            
            VStack(spacing: 6) {
              Button { } label: {
                Image(systemName: "airpods.gen3")
                  .font(.title2)
              }
              
              Text("iManas's Airpods").font(.caption)
            }
            
            Button { } label: {
              Image(systemName: "list.bullet")
                .font(.title2)
            }
          }
          .foregroundColor(.white).blendMode(.overlay).padding(.top, spacing)
        }
        .frame(height: size.height / 2.5, alignment: .bottom)
      }
    }
  }
}

extension View {
  var deviceCornerRadius: CGFloat {
    let key = "_displayCornerRadius"
    if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
      if let cornerRadius = screen.value(forKey: key) as? CGFloat {
        return cornerRadius
      }
      return 0
    }
    return 0
  }
}
