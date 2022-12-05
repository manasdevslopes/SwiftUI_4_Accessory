//
//  Regexs.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 05/12/22.
//

import SwiftUI

struct Regexs: View {
  @State private var textFieldInfo = ""
  var emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  
    var body: some View {
      VStack {
        TextField("Please Enter your Email", text: $textFieldInfo)
          .frame(width: 250, height: 40)
          .multilineTextAlignment(.center)
          .padding()
        
        Button("Check for a valid email") {
          if textFieldInfo.range(of: emailRegEx, options: .regularExpression) == nil {
            print("Incorrect Email")
          } else {
            print("Correct Email Given")
          }
        }
      }
    }
}

struct Regexs_Previews: PreviewProvider {
    static var previews: some View {
        Regexs()
    }
}
