//
//  Actors.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 02/03/23.
//

import SwiftUI

/// - If want to create own Queue without help of actors then
class MyDataManager {
  static let instance = MyDataManager()
  private init() { }
  
  var data: [String] = []
  private let queue = DispatchQueue(label: "com.MyApp.MyDataManager") /// <-- 1st step declare a queue
  
  func getRandomData(completionHandler: @escaping (_ title: String?) -> ()) {
    queue.async { /// <-- Apply this queue here and then pass all operations and return the value with
                  ///     help of completionHandler as this is closure
      self.data.append(UUID().uuidString)
      print(Thread.current)
      completionHandler(self.data.randomElement())
    }
  }
}

/// - ACTORS
/// In Actors, everything will be isolated as they can be accessible using await keyword becoz all are async. If some function or method u want to access directly without async-await then we need to make it non-isolated then add nonisolateed keyword before that function or method
actor MyActorDataManager {
  static let instance = MyActorDataManager()
  private init() { }
  
  var data: [String] = []
  
  nonisolated let myRandomText = "Hello World!"
  
  func getRandomData() -> String? {
    self.data.append(UUID().uuidString)
    print(Thread.current)
    return self.data.randomElement()
  }
  
  nonisolated func getSavedData() -> String {
    return "Hello Swift Developers!"
  }
}


struct HomeView: View {
//  let manager = MyDataManager.instance
  let manager = MyActorDataManager.instance
  
  @State private var text: String = ""
  let timer = Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
  
  var body: some View {
    ZStack {
      Color.gray.opacity(0.8).ignoresSafeArea()
      
      Text(text)
        .font(.headline)
    }
    .onAppear {
      let dataString = manager.getSavedData()
      let text = manager.myRandomText
      
      Task {
        await manager.getRandomData()
      }
    }
    .onReceive(timer) { _ in
      Task {
        if let data = await manager.getRandomData() {
          await MainActor.run(body: {
            self.text = data
          })
        }
      }
//      DispatchQueue.global(qos: .background).async {
//        manager.getRandomData { title in
//          if let data = title {
//            DispatchQueue.main.async {
//              self.text = data
//            }
//          }
//        }
//      }
    }
  }
}

struct BrowseView: View {
//  let manager = MyDataManager.instance
  let manager = MyActorDataManager.instance
  
  @State private var text: String = ""
  let timer = Timer.publish(every: 0.01, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
  
  var body: some View {
    ZStack {
      Color.yellow.opacity(0.8).ignoresSafeArea()
      
      Text(text)
        .font(.headline)
    }
    .onReceive(timer) { _ in
      Task {
        if let data = await manager.getRandomData() {
          await MainActor.run(body: {
            self.text = data
          })
        }
      }
//      DispatchQueue.global(qos: .background).async {
//        manager.getRandomData { title in
//          if let data = title {
//            DispatchQueue.main.async {
//              self.text = data
//            }
//          }
//        }
//      }
    }
  }
}

struct Actors: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
      BrowseView()
        .tabItem {
          Label("Browse", systemImage: "magnifyingglass")
        }
    }
  }
}

struct Actors_Previews: PreviewProvider {
  static var previews: some View {
    Actors()
  }
}
