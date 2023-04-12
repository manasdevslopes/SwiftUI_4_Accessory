//
//  HomeStack.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 12/04/23.
//

import Foundation

/// - Home View Nav Link's
enum HomeStack: String, CaseIterable {
  case myPosts = "My Posts"
  case oldPosts = "Old Posts"
  case latestPosts = "Latest Posts"
  case deletedPosts = "Deleted Posts"
  
  static func convert(from text: String) -> Self? {
    return self.allCases.first { tab in
      tab.rawValue.lowercased() == text.lowercased()
    }
  }
}
