//
//  SettingsStack.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 12/04/23.
//

import SwiftUI

/// - Home View Nav Link's
enum SettingsStack: String, CaseIterable {
  case myProfile = "My Profile"
  case dataUsage = "Data Usage"
  case privacyPolicy = "Privacy Policy"
  case termsOfService = "Terms Of Service"
  
  static func convert(from text: String) -> Self? {
    return self.allCases.first { tab in
      tab.rawValue.lowercased() == text.lowercased()
    }
  }
}
