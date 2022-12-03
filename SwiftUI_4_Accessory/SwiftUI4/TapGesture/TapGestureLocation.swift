//
//  TapGestureLocation.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/11/22.
//

import SwiftUI

struct TapGestureLocation: View {
    var body: some View {
        Circle()
        .fill(.red)
        .frame(width: 100, height: 100)
        // .onTapGesture {location in // wrt only circle
        //   print("Tapped at: \(location)")
        // }
        .onTapGesture(coordinateSpace: .global) {location in // wrt whole screen area
          print("Tapped at: \(location)")
        }
    }
}

struct TapGestureLocation_Previews: PreviewProvider {
    static var previews: some View {
        TapGestureLocation()
    }
}
