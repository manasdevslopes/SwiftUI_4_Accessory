//
//  DoTryCatchThrows.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/02/23.
//

import SwiftUI

/// - Manager Class
class DoTryCatchThrowsDataManager {
  let isActive: Bool = true
  
  func getTitle() -> (title: String?, error: Error?) {
    if isActive {
      return ("New Text.", nil)
    } else {
      return (nil, URLError(.badURL))
    }
  }
  
  func getTitle2() -> Result<String, Error> {
    if isActive {
      return .success("New Text.")
    } else {
      return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
    }
  }
  
  func getTitle3() throws -> String {
    if isActive {
      return "New Text."
    } else {
      throw URLError(.badServerResponse)
    }
  }
  
  func getTitle4() throws -> String {
    if isActive {
      return "Final Text."
    } else {
      throw URLError(.badServerResponse)
    }
  }
}

/// - View Model
class DoTryCatchThrowsViewModel: ObservableObject {
  @Published var text: String = "Starting Text."
  let manager = DoTryCatchThrowsDataManager()
  
  func fetchTitle() {
    
    /*
    let returnedValue = manager.getTitle()
    if let newTitle = returnedValue.title {
      self.text = newTitle
    } else if let error = returnedValue.error {
      self.text = error.localizedDescription
    }
     */
    
    /*
    let result = manager.getTitle2()
    switch result {
      case .success(let newTitle):
        self.text = newTitle
      case .failure(let error):
        self.text = error.localizedDescription
    }
     */
    
//    let newTitle = try? manager.getTitle3()
//    if let newTitle {
//      self.text = newTitle
//    }
    
    do {
      //    let newTitle = try? manager.getTitle3()
      //    if let newTitle {
      //      self.text = newTitle
      //    }
      
      let newTitle = try manager.getTitle3()
      self.text = newTitle
      
      let finalTitle = try manager.getTitle4()
      self.text = finalTitle
    } catch {
      self.text = error.localizedDescription
    }
  }
}

struct DoTryCatchThrows: View {
  @StateObject private var vm = DoTryCatchThrowsViewModel()
  
  var body: some View {
    Text(vm.text)
      .frame(width: 300, height: 300).background(.blue)
      .onTapGesture {
        vm.fetchTitle()
      }
  }
}

struct DoTryCatchThrows_Previews: PreviewProvider {
  static var previews: some View {
    DoTryCatchThrows()
  }
}
