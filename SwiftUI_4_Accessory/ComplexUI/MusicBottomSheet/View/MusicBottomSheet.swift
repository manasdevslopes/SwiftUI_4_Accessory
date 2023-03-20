//
//  MusicBottomSheet.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 20/03/23.
//

import SwiftUI

struct MusicBottomSheet: View {
  @State private var expandSheet: Bool = false
  @Namespace private var animation
  
  var body: some View {
    TabView {
      ListenNow()
        .tabItem {
          Image(systemName: "play.circle.fill")
          Text("Listen Now")
        }
      /// Changing Tab Background Color
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
      /// - Hiding Tab Bar when sheet is opened
        .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
      
      SampleTabView("Browse", "square.grid.2x2.fill")
      SampleTabView("Radio", "dot.radiowaves.left.and.right")
      SampleTabView("Music", "play.square")
      SampleTabView("Search", "magnifyingglass")
    }
    .tint(.red)
    .preferredColorScheme(.dark)
    .safeAreaInset(edge: .bottom) {
      CustomBottomSheet()
    }
    .overlay {
      if expandSheet {
        ExpandedBottomSheet(expandSheet: $expandSheet, animation: animation)
          .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
      }
    }
  }
  
  /// - Custom Listen For Now
  @ViewBuilder
  func ListenNow() ->  some View {
    NavigationStack {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 20) {
          Image("manas_iosdev")
            .resizable().aspectRatio(contentMode: .fit).clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
          Image("manas_iosdev")
            .resizable().aspectRatio(contentMode: .fit).clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
        .padding().padding(.bottom, 100)
      }
      .navigationTitle("Listen Now")
    }
  }
  /// - Custom Bottom Sheet
  @ViewBuilder
  func CustomBottomSheet() -> some View {
    ZStack {
      if expandSheet {
        Rectangle().fill(.clear)
      } else {
        Rectangle().fill(.ultraThinMaterial)
          .overlay {
            /// Music Info
            MusicInfo(expandSheet: $expandSheet, animation: animation)
          }
          .matchedGeometryEffect(id: "BGVIEW", in: animation)
      }
    }
    .frame(height: 79)
    /// - Seperation Line
    .overlay(alignment: .bottom) {
      Rectangle().fill(.gray.opacity(0.1)).frame(height: 1).offset(y: -5)
    }
    /// - Default Tab Bar Height -> 49
    .offset(y: -49)
  }
  
  @ViewBuilder
  func SampleTabView(_ title: String, _ icon: String) -> some View {
    ScrollView(.vertical, showsIndicators: false) {
      Text(title).padding(.top, 25)
    }
    .tabItem {
      Image(systemName: icon)
      Text(title)
    }
    /// Changing Tab Background Color
    .toolbarBackground(.visible, for: .tabBar)
    .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    /// - Hiding Tab Bar when sheet is opened
    .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
  }
}

struct MusicBottomSheet_Previews: PreviewProvider {
  static var previews: some View {
    MusicBottomSheet()
  }
}

struct MusicInfo: View {
  @Binding var expandSheet: Bool
  var animation: Namespace.ID
  
  var body: some View {
    HStack(spacing: 0) {
      /// - Adding Matched Geometry Effect (Hero Animation)
      ZStack {
        if !expandSheet {
          GeometryReader {
            let size = $0.size
            
            Image("manas_iosdev")
              .resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
              .clipShape(RoundedRectangle(cornerRadius: expandSheet ? 15 : 5, style: .continuous))
          }
          .matchedGeometryEffect(id: "MANAS", in: animation)
        }
      }
      .frame(width: 45, height: 45)
      
      Text("Look What You Made Me do").fontWeight(.semibold).lineLimit(1).padding(.horizontal, 15)
      
      Spacer(minLength: 0)
      
      Button { } label: {
        Image(systemName: "pause.fill")
          .font(.title2)
      }
      
      Button { } label: {
        Image(systemName: "forward.fill")
          .font(.title2)
      }.padding(.leading, 25)
    }
    .foregroundColor(.primary).padding(.horizontal).padding(.bottom, 5)
    .frame(height: 70)
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation(.easeInOut(duration: 0.3)) {
        expandSheet = true
      }
    }
  }
}
