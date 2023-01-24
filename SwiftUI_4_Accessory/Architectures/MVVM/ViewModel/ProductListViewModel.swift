//
//  ProductListViewModel.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/01/23.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
  @Published var products: [Product] = []
  
  func populateProducts() async throws {
    self.products = try await Webservice.instance.getAllProducts()
  }
}
