//
//  DogView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 16/02/23.
//

import SwiftUI

struct DogView: View {
  @ObservedObject var dogVM = DogViewModel()
  @State private var backgroundIsGreen = false
  
  var body: some View {
    ZStack {
      Color(backgroundIsGreen ? .green : .white)
      VStack(spacing: 20) {
        Group {
          if dogVM.image != nil {
            Image(uiImage: dogVM.image!)
              .resizable()
              .frame(width: 320, height: 240)
              .aspectRatio(contentMode: .fill)
          } else {
            Rectangle().stroke(lineWidth: 2).foregroundColor(.red)
              .frame(width: 320, height: 240)
          }
        }
        Button("Get Dog Image") {
          // self.dogVM.getDog()
          self.dogVM.getDogWithSession()
        }
        Button("Change Background") {
          self.backgroundIsGreen.toggle()
        }
      }
    }
  }
}

struct DogView_Previews: PreviewProvider {
  static var previews: some View {
    DogView()
  }
}
