//
//  Index.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import Foundation

protocol ReduxState { }

/// - Global States
struct AppState: ReduxState {
  var products = ProductState()
}
