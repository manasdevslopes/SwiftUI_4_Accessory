//
//  SFSymbols.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/12/22.
//

import SwiftUI

struct SFSymbols: View {
  @State private var value = 0.0
  var body: some View {
    VStack {
      HStack {
        Image(systemName: "aqi.low", variableValue: value)
        Image(systemName: "wifi", variableValue: value)
        Image(systemName: "chart.bar.fill", variableValue: value)
        Image(systemName: "waveform", variableValue: value)
      }
      Slider(value: $value)
    }
    .font(.system(size: 72))
    .foregroundColor(.blue)
    .padding()
  }
}

struct SFSymbols_Previews: PreviewProvider {
  static var previews: some View {
    SFSymbols()
  }
}
