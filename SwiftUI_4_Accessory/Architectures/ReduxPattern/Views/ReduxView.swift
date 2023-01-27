//
//  ReduxView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import SwiftUI

struct ReduxView: View {
  @EnvironmentObject var store: Store<AppState>
  
  /// - Props
  struct Props {
    let products: [Products]
    let onFetchProducts: () -> ()
  }
  
  /// - mapDisptachToProp
  private func map(state: ProductState) -> Props {
    Props(products: state.products, onFetchProducts: {
      store.dispatch(action: FetchProducts(search: ""))
    })
  }
  
  var body: some View {
    /// - MapStateToProps
    let props = map(state: store.state.products)
    
    List {
      ForEach(props.products) { product in
        Text("\(product.title)")
      }
    }
    .task {
      props.onFetchProducts()
    }
  }
}

struct ReduxView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(reducer: appReducer, state: AppState(), middlewares: [productsMiddleware()])
    NavigationStack {
      ReduxView()
        .environmentObject(store)
    }
  }
}
