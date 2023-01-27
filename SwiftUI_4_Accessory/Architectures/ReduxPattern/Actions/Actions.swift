//
//  Actions.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import Foundation

/// - Action 1
struct FetchProducts: Action {
  let search: String
}

/// - Action 2
struct SetProducts: Action {
  let products: [Products]
}

/// - And u can add more actions here.

