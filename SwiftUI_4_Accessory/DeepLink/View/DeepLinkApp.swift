//
//  DeepLinkApp.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 12/04/23.
//

import SwiftUI

struct DeepLinkApp: View {
  @EnvironmentObject private var appData: AppData
  
  var body: some View {
    TabView(selection: $appData.activeTab) {
      HomeView()
        .tag(Tab.home)
        .tabItem {
          Image(systemName: Tab.home.symbolImage)
        }
      
      FavouriteView()
        .tag(Tab.favourites)
        .tabItem {
          Image(systemName: Tab.favourites.symbolImage)
        }
      
      SettingView()
        .tag(Tab.settings)
        .tabItem {
          Image(systemName: Tab.settings.symbolImage)
        }
    }
    .tint(.red)
  }
}

struct DeepLinkApp_Previews: PreviewProvider {
  static var previews: some View {
    DeepLinkApp()
      .environmentObject(AppData())
  }
}

extension DeepLinkApp {
  // MARK: - Home View with Nav View's
  @ViewBuilder
  func HomeView() -> some View {
    NavigationStack(path: $appData.homeNavStack) {
      List {
        ForEach(HomeStack.allCases, id: \.rawValue) { link in
          NavigationLink(value: link) {
            Text(link.rawValue)
          }
        }
      }
      .navigationTitle("Home")
      .navigationDestination(for: HomeStack.self) { link in
        Text(link.rawValue + " View")
      }
    }
  }
  
  // MARK: - Favourite View with Nav View's
  @ViewBuilder
  func FavouriteView() -> some View {
    NavigationStack(path: $appData.favouriteNavStack) {
      List {
        ForEach(FavouriteStack.allCases, id: \.rawValue) { link in
          NavigationLink(value: link) {
            Text(link.rawValue)
          }
        }
      }
      .navigationTitle("Favourites")
      .navigationDestination(for: FavouriteStack.self) { link in
        Text(link.rawValue + " View")
      }
    }
  }
  
  // MARK: - Settings View with Nav View's
  @ViewBuilder
  func SettingView() -> some View {
    NavigationStack(path: $appData.settingNavStack) {
      List {
        ForEach(SettingsStack.allCases, id: \.rawValue) { link in
          NavigationLink(value: link) {
            Text(link.rawValue)
          }
        }
      }
      .navigationTitle("Settings")
      .navigationDestination(for: SettingsStack.self) { link in
        Text(link.rawValue + " View")
      }
    }
  }
}
