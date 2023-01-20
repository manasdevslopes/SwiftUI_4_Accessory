//
//  AutoOTPTextField.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 20/01/23.
//

import SwiftUI

struct AutoOTPTextField: View {
  @State private var otpText: String = ""
  
  @FocusState private var isKeyboardShowing: Bool
  
  var body: some View {
    VStack {
      Text("Verify OTP")
        .font(.largeTitle.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
      
      HStack(spacing: 0) {
        ForEach(0..<6, id: \.self){ index in
          OTPTextBox(index)
        }
      }
      .background {
        TextField("", text: $otpText.limit(6))
          .keyboardType(.numberPad)
          .textContentType(.oneTimeCode) // to show the most recent one-time code from messages
          /// - Hiding it out
          .frame(width: 1, height: 1)
          .opacity(0.001)
          .blendMode(.screen)
          .focused($isKeyboardShowing)
      }
      .contentShape(Rectangle())
      /// - Opening keyboard when tapped
      .onTapGesture {
        isKeyboardShowing.toggle()
      }
      .padding(.bottom, 20)
      .padding(.top,10)
      
      Button {
        
      } label: {
        Text("Verify")
          .fontWeight(.bold)
          .foregroundColor(.white)
          .padding(.vertical, 12)
          .frame(maxWidth: .infinity)
          .background {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
              .fill(.blue)
          }
      }
      .disableWithOpacity(otpText.count < 6)
    }
    .padding(.all)
    .frame(maxHeight: .infinity, alignment: .top)
    .toolbar {
      ToolbarItem(placement: .keyboard) {
        Button("Done") {
          isKeyboardShowing.toggle()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
      }
    }
  }
  
  /// - OTP Text Boxes
  @ViewBuilder
  func OTPTextBox(_ index: Int) -> some View {
    ZStack {
      // Safe check
      if otpText.count > index {
        /// - Finding char at index
        let startIndex = otpText.startIndex
        let charIndex = otpText.index(startIndex, offsetBy: index)
        let charToString = String(otpText[charIndex])
        Text(charToString)
      } else {
        Text(" ")
      }
    }
    .frame(width: 45, height: 45)
    .background {
      /// - Highlighting the current text box
      let status = (isKeyboardShowing && otpText.count == index)
      RoundedRectangle(cornerRadius: 6, style: .continuous)
        .stroke(status ? .black : .gray, lineWidth: status ? 1 : 0.5)
        .animation(.easeInOut(duration: 0.2), value: status)
    }
    .frame(maxWidth: .infinity)
  }
}

struct AutoOTPTextField_Previews: PreviewProvider {
  static var previews: some View {
    AutoOTPTextField()
  }
}

// MARK: - View Extensions
extension View {
  @ViewBuilder
  func disableWithOpacity(_ condition: Bool) -> some View {
    self
      .disabled(condition)
      .opacity(condition ? 0.6 : 1)
  }
}

// MARK: - Binding <String> Extension
extension Binding where Value == String {
  func limit(_ length: Int) -> Self {
    if self.wrappedValue.count > length {
      DispatchQueue.main.async {
        self.wrappedValue = String(self.wrappedValue.prefix(length))
      }
    }
    return self
  }
}
