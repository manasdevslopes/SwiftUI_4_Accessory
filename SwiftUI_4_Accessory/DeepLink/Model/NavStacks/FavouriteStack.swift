//
//  FavouriteStack.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 12/04/23.
//

import SwiftUI

/// - Home View Nav Link's
enum FavouriteStack: String, CaseIterable {
  case iManas = "iManas"
  case iKanishk = "iKanishk"
  case iKrishna = "iKrishna"
  
  static func convert(from text: String) -> Self? {
    return self.allCases.first { tab in
      tab.rawValue.lowercased() == text.lowercased()
    }
  }
}

