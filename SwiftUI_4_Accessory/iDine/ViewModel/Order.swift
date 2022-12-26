//
//  Order.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 19/12/22.
//

import SwiftUI

class Order: ObservableObject {
  @Published var items = [MenuItem]()
  
  var total: Int {
    if items.count > 0 {
      return items.reduce(0) { $0 + $1.price }
    } else {
      return 0
    }
  }
}
