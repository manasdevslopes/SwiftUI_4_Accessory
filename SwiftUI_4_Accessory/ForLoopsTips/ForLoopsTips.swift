//
//  ForLoopsTips.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 04/12/22.
//

import SwiftUI

struct ForLoopsTips: View {
  @State private var names = ["Ashi", "Manas", "Krishna", "Kalyani Di", "Shikha"]
  
  var body: some View {
    Button("Run For Loop") {
      // tip0()
      // tip1()
      // tip2()
      // tip3()
      // tip4()
      tip5()
    }
  }
  
  // MARK: - 5th Tip For Loop - Sort in For Loops
  func tip5() {
    let sortedNames = names.sorted { n0, n1 in
      n0 < n1
    }
    print(sortedNames)
  }
  
  // MARK: - 4th Tip For Loop - Filter in For Loops
  func tip4() {
    let namesStartingWithK = names.filter { name in
      name.first == Character("K")
    }
    print(namesStartingWithK)
  }
  
  
  // MARK: - 3rd Tip For Loop - Map in For Loops
  func tip3() {
    let firstLetter = names.map { name in
      name.first
    }
    print(firstLetter)
  }
  
  // MARK: - 2nd Tip For Loop - Two D Array
  @State private var twoDArray = [["Ashi", "Manas"], ["Krishna", "Kalyani Di", "Shikha"]]
  func tip2() {
    twoDArray.forEach { array in
      array.forEach { name in
        print(name)
      }
    }
  }
  
  // MARK: - 1st Tip For Loop - Break
  func tip1() {
    for name in names {
      print(name)
      if name == "Kalyani Di" {
        print("Breaking")
        break
      }
    }
  }
  
  // MARK: - Basic For Loop
  func tip0() {
//    for i in 0..<names.count {
//      let name = names[i]
//      print(name)
//    }
    
//    for name in names {
//      print(name)
//    }
    
    names.forEach { name in
      print(name)
    }
  }
}

struct ForLoopsTips_Previews: PreviewProvider {
  static var previews: some View {
    ForLoopsTips()
  }
}
