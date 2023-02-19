//
//  MemoryManagement.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 19/02/23.
//

import SwiftUI

class ViewModel {
  var text: String = "Hello, world!"
  var onUpdate: (() -> ())?
  
  deinit {
    print("ViewModel has been deallocated")
  }
}

struct MemoryManagement: View {
  // Declare a weak reference to the view model
  weak var weakViewModel: ViewModel?
  
  // Declare an unowned reference to the view model
  unowned let unownedViewModel: ViewModel
  
  init() {
    let viewModel = ViewModel()
    self.weakViewModel = viewModel
    self.unownedViewModel = viewModel
  }
  
  var body: some View {
    VStack {
      Text(weakViewModel?.text ?? "Weak: ViewModel has been deallocated")
      Text(unownedViewModel.text)
      Button("Update Text") {
        updateText()
      }
    }
  }
  
  func updateText() {
    // Update the text of the view model and call the callback function
    weakViewModel?.text = "Weak: Text has been updated"
    weakViewModel?.onUpdate?()
    
    unownedViewModel.text = "Unowned: Text has been updated"
    unownedViewModel.onUpdate?()
  }
}

struct MemoryManagement_Previews: PreviewProvider {
  static var previews: some View {
    MemoryManagement()
  }
}
