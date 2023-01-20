//
//  DropDownPicker.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 20/01/23.
//

import SwiftUI

struct DropDownPicker: View {
  @State private var selection: String = "Easy"
  @State private var selection1: String = "Easy"
  
  @Environment(\.colorScheme) private var scheme
  
  var body: some View {
    VStack {
      VStack {
        DropDown(
          content: ["Easy", "Normal", "Hard", "Expert"],
          selection: $selection,
          activeTint: .primary.opacity(0.1),
          inActiveTint: .primary.opacity(0.05),
          dynamic: false
        )
        .frame(width: 130)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      
      VStack {
        DropDown(
          content: ["Easy", "Normal", "Hard", "Expert"],
          selection: $selection1,
          activeTint: .primary.opacity(0.1),
          inActiveTint: .primary.opacity(0.05),
          dynamic: true
        )
        .frame(width: 130)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    .background {
      if scheme == .dark {
        Color("BGDark")
          .ignoresSafeArea()
      }
    }
    .preferredColorScheme(.dark)
  }
}

struct DropDownPicker_Previews: PreviewProvider {
  static var previews: some View {
    DropDownPicker()
  }
}

struct DropDown: View {
  var content: [String]
  @Binding var selection: String
  var activeTint: Color
  var inActiveTint: Color
  var dynamic: Bool = true
  
  @State private var expandView: Bool = false
  
  var body: some View {
    GeometryReader {
      let size = $0.size
      
      VStack(alignment: .leading, spacing: 0) {
        if !dynamic {
          RowView(selection, size)
        }
        ForEach(content.filter { dynamic ? true : $0 != selection }, id:\.self) { title in
          RowView(title, size)
        }
      }
      .background {
        Rectangle()
          .fill(inActiveTint)
      }
      /// - Moving View based on selection
      .offset(y: dynamic ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
    }
    .frame(height: 55)
    .overlay(alignment: .trailing) {
      Image(systemName: "chevron.up.chevron.down")
        .padding(.trailing, 10)
    }
    .mask(alignment: .top) {
      Rectangle()
        .frame(height: expandView ? CGFloat(content.count) * 55 : 55)
      /// - Moving the maskbased on selection, so that every content will be visible
        .offset(y: dynamic && expandView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
    }
  }
  
  @ViewBuilder
  func RowView(_ title: String, _ size: CGSize) -> some View {
    Text(title)
      .font(.title3)
      .fontWeight(.semibold)
      .padding(.horizontal)
      .frame(width: size.width, height: size.height, alignment: .leading)
      .background {
        if selection == title {
          Rectangle()
            .fill(activeTint)
            .transition(.identity)
        }
      }
      .contentShape(Rectangle())
      .onTapGesture {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
          if expandView {
            expandView = false
            
            /// - Disabling animation for non-dynamic contents
            if dynamic {
              selection = title
            } else {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                selection = title
              }
            }
          } else {
            /// - Disabling outside Taps
            if selection == title {
              expandView = true
            }
          }
        }
      }
  }
}
