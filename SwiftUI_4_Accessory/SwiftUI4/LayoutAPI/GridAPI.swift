//
//  GridAPI.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/11/22.
//

import SwiftUI

struct GridAPI: View {
  var body: some View {
    Grid(horizontalSpacing: 20, verticalSpacing: 20) {
      GridRow {
        Image(systemName: "xmark")
        Image(systemName: "xmark")
        Image(systemName: "xmark")
      }
      GridRow {
        Image(systemName: "circle")
        Image(systemName: "xmark")
        Image(systemName: "circle")
      }
      GridRow {
        Image(systemName: "xmark")
        Image(systemName: "circle")
        Image(systemName: "circle")
      }
    }
    .font(.title)
  }
}

struct GridAPIThree: View {
  @State private var redScore:Int = 0
  @State private var blueScore:Int = 0
  
  var body: some View {
    Grid {
      GridRow {
        Text("Food")
        Text("$200")
      }
      GridRow {
        Text("Rent")
        Text("$800")
      }
      GridRow {
        Text("Candles")
        Text("$3600")
      }

      Divider()
      
      GridRow {
        Text("$4600r7897348973289478932748979832749873987498378947")
          .gridCellColumns(2)
          .multilineTextAlignment(.trailing)
      }
      .background(.yellow)
    }
    .font(.title)
  }
}

struct GridAPITwo: View {
  @State private var redScore:Int = 0
  @State private var blueScore:Int = 0
  
  var body: some View {
    Grid {
      GridRow {
        Text("Red")
        ForEach(0..<redScore, id:\.self) {_ in
          Rectangle()
            .fill(.red)
            .frame(width: 20, height: 20)
        }
      }
      GridRow {
        Text("Blue")
        ForEach(0..<blueScore, id:\.self) {_ in
          Rectangle()
            .fill(.blue)
            .frame(width: 20, height: 20)
        }
      }
      
      Button("Red Score") { redScore += 1 }
      
      Button("Blue Score") { blueScore += 1 }
    }
  }
}

struct GridAPIOne: View {
    var body: some View {
      Grid {
        GridRow {
          Text("Top Leading")
            .background(.red)
          Text("Top Trailing")
            .background(.orange)
        }
        GridRow {
          Text("Bottom Leading")
            .background(.blue)
          Text("Bottom Trailing")
            .background(.green)
        }
      }
    }
}

struct LayoutAPI_Previews: PreviewProvider {
    static var previews: some View {
        GridAPI()
    }
}
