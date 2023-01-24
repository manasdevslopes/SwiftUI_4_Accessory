//
//  ModelViewView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/01/23.
//

import SwiftUI

/// - Model
@MainActor
class StoreModel: ObservableObject {
  @Published var products: [Product] = []
  
  func populateProducts() async throws {
    self.products = try await Webservice.instance.getAllProducts()
  }
}

struct ModelViewViews: View {
  //  @StateObject private var storeModel = StoreModel()
  @EnvironmentObject private var storeModel: StoreModel
  
  var body: some View {
    List {
      ForEach(storeModel.products, id: \.id) { product in
        Text("\(product.title)")
      }
    }
    .task {
      do {
        try await storeModel.populateProducts()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

struct ModelViewViews_Previews: PreviewProvider {
  static var previews: some View {
    ModelViewViews()
      .environmentObject(StoreModel())
  }
}
