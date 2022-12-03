//
//  StoreKitReviewAPI.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/12/22.
//

import StoreKit
import SwiftUI

struct StoreKitReviewAPI: View {
  @Environment(\.requestReview) var requestReview
  
    var body: some View {
      Button("Review the app") {
        requestReview()
      }
    }
}

struct StoreKitReviewAPI_Previews: PreviewProvider {
    static var previews: some View {
        StoreKitReviewAPI()
    }
}
