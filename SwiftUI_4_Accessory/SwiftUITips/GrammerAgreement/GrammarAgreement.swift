//
//  GrammarAgreement.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 19/05/23.
//

import SwiftUI

struct GrammarAgreement: View {
  @State private var count = 1
    var body: some View {
      VStack {
        Button("Add") { count += 1 }
        Button("Remove") {
          if count != 1 {
            count -= 1
          }
        }
        Text("^[\(count) Person](inflect: true)")
      }
    }
}

struct GrammerAgreement_Previews: PreviewProvider {
    static var previews: some View {
        GrammarAgreement()
    }
}
