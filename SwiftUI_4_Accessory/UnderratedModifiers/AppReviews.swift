//
//  AppReviews.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 30/01/23.
//

import SwiftUI
import StoreKit

struct AppReviews: View {
  @Environment(\.requestReview) var requestReview
  
    var body: some View {
      Button("Request Review") {
        requestReview()
      }
    }
}

struct AppReviews_Previews: PreviewProvider {
    static var previews: some View {
        AppReviews()
    }
}
