//
//  GlobalActors.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 02/03/23.
//

import SwiftUI

/// - Use struct or final class
@globalActor struct MyFirstGlobalActor {
  static var shared = MyNewDataManager()
}

actor MyNewDataManager {
  func getDataFromDatabase() -> [String] {
    return ["One", "Two", "Three", "Four", "Five", "Six", "Seven"]
  }
}

class GlobalActorsViewModel: ObservableObject {
  @MainActor @Published var dataArray: [String] = []
  let manager = MyFirstGlobalActor.shared
  
  @MyFirstGlobalActor func getData() {
    Task {
      let data = await manager.getDataFromDatabase()
      await MainActor.run(body: {
        self.dataArray = data
      })
    }
  }
  
}

struct GlobalActors: View {
  @StateObject private var vm = GlobalActorsViewModel()
  
  var body: some View {
    ScrollView {
      VStack {
        ForEach(vm.dataArray, id: \.self) {
          Text($0).font(.headline)
        }
      }
    }
    .task {
      await vm.getData()
    }
  }
}

struct GlobalActors_Previews: PreviewProvider {
  static var previews: some View {
    GlobalActors()
  }
}
