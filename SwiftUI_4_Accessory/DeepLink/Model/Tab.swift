//
//  Tab.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 12/04/23.
//

import SwiftUI

/// - TabView Tab's
enum Tab: String, CaseIterable {
  case home = "Home"
  case favourites = "Favourites"
  case settings = "Settings"
  
  var symbolImage: String {
    switch self {
      case .home: return "house.fill"
      case .favourites: return "heart.fill"
      case .settings: return "gear"
    }
  }
  
  static func convert(from text: String) -> Self? {
    return self.allCases.first { tab in
      tab.rawValue.lowercased() == text.lowercased()
    }
  }
}
