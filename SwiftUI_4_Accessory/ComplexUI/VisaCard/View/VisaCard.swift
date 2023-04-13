//
//  VisaCard.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 13/04/23.
//

import SwiftUI

struct VisaCard: View {
  @FocusState private var activeTF: ActiveKeyboardField!
  @State private var cardNumber: String = ""
  @State private var cardHolderName: String = ""
  @State private var cvvCode: String = ""
  @State private var expireDate: String = ""
  
  var body: some View {
    NavigationStack {
      VStack {
        HeaderView()
        
        CardView()
        
        Spacer(minLength: 0)
        
        CardButtonView()
      }
      .padding()
      .toolbar(.hidden, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .keyboard) {
          if activeTF != .cardHolderName {
            Button("Next") {
              switch activeTF {
                case .cardNumber:
                  activeTF = .expirationDate
                case .expirationDate:
                  activeTF = .cvv
                case .cvv:
                  activeTF = .cardHolderName
                case .cardHolderName:
                  break
                case .none: break
              }
            }
            // .tint(.white)
            .frame(maxWidth: .infinity, alignment: .trailing)
          }
        }
      }
    }
  }
}

struct VisaCard_Previews: PreviewProvider {
  static var previews: some View {
    VisaCard()
  }
}


extension VisaCard {
  @ViewBuilder
  func HeaderView() -> some View {
    HStack {
      Button {
        
      } label: {
        Image(systemName: "xmark").font(.title2).foregroundColor(.black)
      }
      
      Text("Add Card").font(.title3).padding(.leading, 10)
      
      Spacer(minLength: 0)
      
      Button {
        
      } label: {
        Image(systemName: "arrow.counterclockwise").font(.title2)
      }
    }
  }
  
  @ViewBuilder
  func CardView() -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20, style: .continuous)
        .fill(.linearGradient(colors: [Color("CardGradient1"), Color("CardGradient2")], startPoint: .topLeading, endPoint: .bottomTrailing))
      
      /// - Card Details
      VStack(spacing: 10) {
        HStack {
          TextField("xxxx xxxx xxxx xxxx", text: .init(get: {
            cardNumber
          }, set: { value in
            cardNumber = ""
            
            /// - Inserting space every 4 Digits. Total is 19chars
            let startIndex = value.startIndex
            for index in 0..<value.count {
              let stringIndex = value.index(startIndex, offsetBy: index)
              cardNumber += String(value[stringIndex])
              
              if (index + 1) % 5 == 0 && value[stringIndex] != " " {
                cardNumber.insert(" ", at: stringIndex)
              }
            }
            /// - Removing Empty Space when going back
            if value.last == " " {
              cardNumber.removeLast()
            }
            // setting the limit to 19 (16chars + 3empty space)
            cardNumber = String(cardNumber.prefix(19))
          }))
          .font(.title3).keyboardType(.numberPad).focused($activeTF, equals: .cardNumber)
          Spacer(minLength: 0)
          Image("visa").resizable().renderingMode(.template).aspectRatio(contentMode: .fit).frame(width: 60, height: 50)
        }
        
        HStack(spacing: 12) {
          TextField("MM/YY", text: .init(get: {
            expireDate
          }, set: { value in
            expireDate = value
            // inserting slash '/' in the third string position
            if value.count == 3 && !value.contains("/") {
              let startIndex = value.startIndex
              let thirdPosition = value.index(startIndex, offsetBy: 2)
              expireDate.insert("/", at: thirdPosition)
            }
            
            /// - Removing Empty Space when going back
            if value.last == "/" {
              expireDate.removeLast()
            }
            // setting the limit to 5 (4 chars +  1 Slash)
            expireDate = String(expireDate.prefix(5))
          }))
          .keyboardType(.numberPad).focused($activeTF, equals: .expirationDate)
          Spacer(minLength: 0)
          
          TextField("CVV", text: .init(get: {
            cvvCode
          }, set: { value in
            cvvCode = value
            // setting the limit to 3
            cvvCode = String(cvvCode.prefix(3))
          }))
          .frame(width: 35).focused($activeTF, equals: .cvv).keyboardType(.numberPad)
          
          Image(systemName: "questionmark.circle.fill")
        }
        .padding(.top, 15)
        
        Spacer(minLength: 0)
        TextField("CARD HOLDER NAME", text: $cardHolderName).focused($activeTF, equals: .cardHolderName).submitLabel(.done)
      }
      .padding(20).environment(\.colorScheme, .dark).tint(.white)
    }
    .frame(height: 200).padding(.top, 35)
  }
  
  @ViewBuilder
  func CardButtonView() -> some View {
    Button { } label: {
      Label("Add Card", systemImage: "lock")
        .fontWeight(.semibold).foregroundColor(.white).padding(.vertical, 12).frame(maxWidth: .infinity)
        .background {
          RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.blue.gradient)
        }
    }
    .disableWithOpacity(cardNumber.count != 19 || cardHolderName.isEmpty || expireDate.count != 5 || cvvCode.count != 3)
  }
}

extension VisaCard {
  @ViewBuilder
  func disableWithOpacity(_ status: Bool) -> some View {
    self.disabled(status).opacity(status ? 0.6 : 1)
  }
}
