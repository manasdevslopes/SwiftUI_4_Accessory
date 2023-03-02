//
//  Sendable.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 02/03/23.
//

import SwiftUI

actor CurrentUserManager {
  func updateDatabase(userInfo: MyClassUserInfo) {
    
  }
}

struct MyUserInfo: Sendable {
  let name: String
}

final class MyClassUserInfo: @unchecked Sendable {
  private var name: String
  let queue = DispatchQueue(label: "com.MyApp.MyClassUserInfo")
  
  init(name: String) {
    self.name = name
  }
  
  func updateName(name: String) {
    queue.async {
      self.name = name
    }
  }
}

class SendableViewModel: ObservableObject {
  let manager = CurrentUserManager()
  
  func updateCurrentUserInfo() async {
    let info = MyClassUserInfo(name: "info")
    await manager.updateDatabase(userInfo: info)
  }
}

struct Sendables: View {
  @StateObject private var vm = SendableViewModel()
  
  var body: some View {
    Text("Hello, World!")
      .task {
        await vm.updateCurrentUserInfo()
      }
  }
}

struct Sendables_Previews: PreviewProvider {
  static var previews: some View {
    Sendables()
  }
}
