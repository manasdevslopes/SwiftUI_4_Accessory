//
//  ContainerPatternView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/01/23.
//

import SwiftUI

/// - PRESENTER VIEW
struct ProductListView: View {
  var products: [Product]
  
  var body: some View {
    List {
      ForEach(products, id: \.id) { product in
        Text("\(product.title)")
      }
    }
  }
}

/// - CONTAINER VIEW
struct ContainerPatternView: View {
  @State private var products: [Product] = []
  
  var body: some View {
    ProductListView(products: products)
      .task {
        do {
          self.products = try await Webservice.instance.getAllProducts()
        } catch {
          print(error.localizedDescription)
        }
      }
  }
}

struct ContainerPatternView_Previews: PreviewProvider {
  static var previews: some View {
    ContainerPatternView()
  }
}
