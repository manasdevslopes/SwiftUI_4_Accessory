//
//  CollapsibleHeaderMenu.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 18/01/23.
//

import SwiftUI

struct CollapsibleHeaderMenu: View {
  /// - Animation properties
  @State private var expandMenu:Bool = false
  @State private var dimContent:Bool = false
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView()
      
      VStack(spacing: 10) {
        Text("Budgets")
          .font(.system(size: 30))
          .font(.title)
          .foregroundColor(expandMenu ? Color("Blue") : .white)
          .contentTransition(.interpolate)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 15)
          .padding(.top, 10)
        
        CardView()
        /// - Making it above the scrollview
          .zIndex(1)
        
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: 12) {
            ForEach(expenses) {expense in
              ExpenseCardView(expense)
            }
          }
          .padding(.top, 40)
          .padding([.horizontal, .bottom], 15)
        }
        .padding(.top,-20)
        .zIndex(0)
      }
      /// - Moving view up by negative padding
      .padding(.top,expandMenu ? 30 : -130)
      /// - Diming Content
      .overlay {
        Rectangle()
          .fill(.black)
          .opacity(dimContent ? 0.45 : 0)
          .ignoresSafeArea()
        
      }
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .background(
      Color("BG")
        .ignoresSafeArea()
    )
  }
  
  /// - Header View
  @ViewBuilder
  func HeaderView()-> some View {
    GeometryReader {
      let size = $0.size
      let offset = (size.height + 200.0) * 0.2
      
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          RoundedRectangle(cornerRadius: 2, style: .continuous)
          /// - Hiding the lines when expanded
            .menuTitleView(CGSize(width: 15, height: 2),"Limits", offset, expandMenu) {
              print("Tapped Limits")
            }
          
          RoundedRectangle(cornerRadius: 2, style: .continuous)
            .menuTitleView(CGSize(width: 25, height: 2), "Money", (offset * 2), expandMenu) {
              print("Tapped Money")
            }
          
          RoundedRectangle(cornerRadius: 2, style: .continuous)
            .menuTitleView(CGSize(width: 20, height: 2), "Wallets", (offset * 3), expandMenu) {
              print("Tapped Wallets")
            }
        }
        .overlay {
          Image(systemName: "xmark")
            .font(.title3)
            .foregroundColor(.white)
            .scaleEffect(expandMenu ? 1 : 0.001)
            .rotationEffect(.init(degrees: expandMenu ? 0 : -180))
        }
        .overlay {
          Rectangle()
            .foregroundColor(.clear)
            .contentShape(Rectangle())
            .onTapGesture(perform: animateMenu)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Button {
          
        } label: {
          Image("manas_iosdev")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 35, height: 35)
            .clipShape(Circle())
        }
        
      }
      .padding(15)
    }
    .frame(height: 60)
    .padding(.bottom,expandMenu ? 200 : 130)
    .background(
      Color("Blue")
        .ignoresSafeArea()
    )
  }
  
  /// - Animating View
  func animateMenu() {
    if expandMenu {
      /// - Closing with Little speed
      withAnimation(.easeInOut(duration: 0.25)) {
        dimContent = false
      }
      
      /// - Dimming Content Little Later
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        withAnimation(.easeInOut(duration: 0.2)) {
          expandMenu = false
        }
      }
    } else {
      withAnimation(.easeInOut(duration: 0.35)) {
        expandMenu = true
      }
      
      /// - Dimming Content Little Later
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
        withAnimation(.easeInOut(duration: 0.3)) {
          dimContent = true
        }
      }
    }
  }
  
  /// - Card View
  @ViewBuilder
  func CardView()->some View {
    HStack {
      VStack(alignment: .leading, spacing: 10) {
        Text("Total")
          .font(.body)
          .font(.system(size: 16))
        Text("$5,020")
          .font(.largeTitle)
          .font(.system(size: 40))
          .fontWeight(.medium)
          .foregroundColor(Color("Blue"))
        Text("-235 today")
          .font(.caption)
          .font(.system(size: 12))
          .foregroundColor(.red)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Button {
        
      } label: {
        Image(systemName: "plus")
          .font(.title)
          .scaleEffect(0.9)
          .foregroundColor(.white)
          .frame(width: 60, height: 60)
          .background(Color("Blue"))
          .clipShape(Circle())
          .shadow(color: .black.opacity(0.15), radius: 5, x: 10, y: 10)
      }
      
    }
    .padding(15)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    .shadow(color: .black.opacity(0.15), radius: 10, x: 5, y: 5)
    .padding(.horizontal, 15)
    .padding(.top, 10)
  }
  
  /// - Expense Card View
  @ViewBuilder
  func ExpenseCardView(_ expense: Expense) -> some View {
    HStack(spacing: 12) {
      Image(expense.productIcon)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 40, height: 40)
      VStack(alignment: .leading, spacing: 4) {
        Text(expense.product)
          .font(.body)
          .font(.system(size: 16))
        Text(expense.spendType)
          .font(.caption)
          .font(.system(size: 12))
          .foregroundColor(.gray)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Text(expense.amountSpent)
        .font(.title3)
        .font(.system(size: 18))
        .fontWeight(.medium)
        .foregroundColor(Color("Blue"))
    }
    .padding(10)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
  }
}

struct CollapsibleHeaderMenu_Previews: PreviewProvider {
  static var previews: some View {
    CollapsibleHeaderMenu()
  }
}

/// - Custom Extension to avoid Redundant Codes
extension View {
  @ViewBuilder
  fileprivate func menuTitleView(_ size: CGSize, _ title: String, _ offset: CGFloat, _ condition: Bool, onTap: @escaping ()->())->some View {
    self
      .foregroundColor(condition ? .clear : .white)
      .contentTransition(.interpolate)
      .frame(width: size.width, height: size.height)
      .background(alignment: .topLeading) {
        Text(title)
          .font(.title)
          .font(.system(size: 25))
          .fontWeight(.medium)
          .foregroundColor(.white)
          .frame(width: 150, alignment: .leading)
          .scaleEffect(condition ? 1 : 0.01, anchor: .topLeading)
          .offset(y: condition ? -6 : 0)
          .onTapGesture(perform: onTap)
      }
      .offset(x: condition ? 40 : 0, y: condition ? offset : 0)
  }
}
