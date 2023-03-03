//
//  AsyncPublishers.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/03/23.
//

import SwiftUI
import Combine

class AsyncPublishersDataManager {
  @Published var myData: [String] = []
  
  func addData() async {
    myData.append("Apple")
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    myData.append("Orange")
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    myData.append("Banana")
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    myData.append("Watermelon")
  }
}

class AsyncPublishersViewModel: ObservableObject {
  @MainActor @Published var dataArray: [String] = []
  let manager = AsyncPublishersDataManager()
  
  init() {
    addSubscriber()
  }
  
  private func addSubscriber() {
    Task {
      for await value in manager.$myData.values {
        await MainActor.run(body: {
          self.dataArray = value
        })
      }
    }
  }
  
  func start() async {
    await manager.addData()
  }
}

struct AsyncPublishers: View {
  @StateObject private var vm = AsyncPublishersViewModel()
  
    var body: some View {
      ScrollView {
        VStack {
          ForEach(vm.dataArray, id: \.self) {
            Text($0).font(.headline)
          }
        }
      }
      .task {
        await vm.start()
      }
    }
}

struct AsyncPublishers_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPublishers()
    }
}
