//
//  ProductsMiddleware.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import Foundation

func productsMiddleware() -> Middleware<AppState> {
  return { stat, action, dispatch in
    switch action {
      case let action as FetchProducts:
        Task {
          let products = try await Webservices.instance.getAllProducts()
          dispatch(SetProducts(products: products))
        }
        
      default:
        break
    }
  }
}
