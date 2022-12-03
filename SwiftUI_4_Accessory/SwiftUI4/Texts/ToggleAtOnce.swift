//
//  ToggleAtOnce.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/12/22.
//

import SwiftUI

struct EmailList: Identifiable {
  var id: String
  var isSubscribed = false
}

struct ToggleAtOnce: View {
  @State private var lists = [
    EmailList(id: "Monthly Updates", isSubscribed: true),
    EmailList(id: "Newsflashes", isSubscribed: true),
    EmailList(id: "Special Offers", isSubscribed: true)
  ]
  
  var body: some View {
    Form {
      Section {
        ForEach($lists) { $list in
          Toggle(list.id, isOn: $list.isSubscribed)
        }
      }
      
      Section {
        Toggle("Subscribe to all", sources: $lists, isOn: \.isSubscribed)
      }
    }
  }
}

struct ToggleAtOnce_Previews: PreviewProvider {
  static var previews: some View {
    ToggleAtOnce()
  }
}
