//
//  ProductsReducer.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import SwiftUI

func productsReducer(_ state: ProductState, _ action: Action) -> ProductState {
  var state = state
  
  switch action {
    case let action as SetProducts:
      state.products = action.products
    default:
      break
  }
  return state
}
