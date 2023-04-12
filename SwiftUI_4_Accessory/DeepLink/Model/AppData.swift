//
//  AppData.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 12/04/23.
//

import SwiftUI

class AppData: ObservableObject {
  @Published var activeTab: Tab = .home
  @Published var homeNavStack: [HomeStack] = []
  @Published var favouriteNavStack: [FavouriteStack] = []
  @Published var settingNavStack: [SettingsStack] = []
  
  
}
