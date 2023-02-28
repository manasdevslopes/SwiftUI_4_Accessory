//
//  AsyncAwaitBootcamp.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 28/02/23.
//

import SwiftUI

class AsyncAwaitBootcampViewModel: ObservableObject {
  @Published var dataArray: [String] = []
  
  func addTitle1() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.dataArray.append("Title1 : \(Thread.current)")
    }
  }
  
  func addTitle2() {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      let title = "Title2 : \(Thread.current)"
      DispatchQueue.main.async {
        self.dataArray.append(title)
        
        let title3 = "Title3 : \(Thread.current)"
        self.dataArray.append(title3)
      }
    }
  }
  
  func addAuthor1() async {
    let author1 = "Author1: \(Thread.current)"
    self.dataArray.append(author1)
    
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    
    let author2 = "Author2: \(Thread.current)"
    await MainActor.run(body: {
      self.dataArray.append(author2)
      
      let author3 = "Author3: \(Thread.current)"
      self.dataArray.append(author3)
    })
    
    await addSomething()
  }
  
  func addSomething() async {
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    
    let something1 = "Something1: \(Thread.current)"
    await MainActor.run(body: {
      self.dataArray.append(something1)
      
      let something2 = "Something2: \(Thread.current)"
      self.dataArray.append(something2)
    })
  }
}

struct AsyncAwaitBootcamp: View {
  @StateObject private var vm = AsyncAwaitBootcampViewModel()
  
  var body: some View {
    List {
      ForEach(vm.dataArray, id: \.self) { data in
        Text(data)
      }
    }
    .onAppear {
      Task {
        await vm.addAuthor1()
        
        let finalText = "Final Text: \(Thread.current)"
        vm.dataArray.append(finalText)
      }
      // vm.addTitle1()
      // vm.addTitle2()
    }
  }
}

struct AsyncAwaitBootcamp_Previews: PreviewProvider {
  static var previews: some View {
    AsyncAwaitBootcamp()
  }
}
