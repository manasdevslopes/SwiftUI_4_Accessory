//
//  Texts.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/12/22.
//

import SwiftUI

struct Texts: View {
  @State private var useBlack = false
  
  @State private var useBold:Bool = false
  @State private var useItalic:Bool = false
  
  @State private var useRed:Bool = false
  
    var body: some View {
      VStack {
        Text("This is some long text that is limited to a specific line range, so anything beyond that range will cause the text to clip.")
          .lineLimit(3...6)
          .frame(width: 200)
          .font(.title)
        
        Text("Hello, world!")
          .font(.largeTitle)
          .fontWeight(useBlack ? .black : .ultraLight)
          .onTapGesture {
            withAnimation {
              useBlack.toggle()
            }
          }
        
        Text("Welcome to SwiftUI 4.0")
          .bold(useBold)
          .italic(useItalic)
        
        Toggle("Use Bold", isOn: $useBold)
        Toggle("Use Italic", isOn: $useItalic)
        
        Text("WWDC22")
          .font(.largeTitle.bold())
          .foregroundColor(useRed ? .red : .black)
          .onTapGesture {
            withAnimation {
              useRed.toggle()
            }
          }
      }
      .padding()
      .font(.title)
    }
}

struct Texts_Previews: PreviewProvider {
    static var previews: some View {
        Texts()
    }
}
