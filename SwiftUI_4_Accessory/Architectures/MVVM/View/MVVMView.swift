//
//  MVVMView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/01/23.
//

import SwiftUI

struct MVVMView: View {
  @StateObject private var productListVM = ProductListViewModel()
  
  var body: some View {
    List {
      ForEach(productListVM.products, id: \.id) { product in
        Text("\(product.title)")
      }
    }
    .task {
      do {
        try await productListVM.populateProducts()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

struct MVVMView_Previews: PreviewProvider {
  static var previews: some View {
    MVVMView()
  }
}

// Component
