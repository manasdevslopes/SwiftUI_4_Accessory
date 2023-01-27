//
//  RootReducer.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
  var state = state
  state.products = productsReducer(state.products, action)
  return state
}
