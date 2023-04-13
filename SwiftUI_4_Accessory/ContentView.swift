//
//  ContentView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 06/11/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var storeModel = StoreModel()
  @StateObject private var downloadManager = DownloadManager()
  @StateObject private var model: Model = Model.startData
  @StateObject private var appData: AppData = .init()
  
  var body: some View {
    //    if #available(iOS 15, *) {
    //      NavigationView {
    //        AutoOTPTextField()
    //          .navigationBarTitleDisplayMode(.inline)
    //          .navigationBarHidden(true)
    //      }
    //    } else {
    //      NavigationStack {
    //        AutoOTPTextField()
    //          .navigationBarTitleDisplayMode(.inline)
    //          .toolbar(.hidden, for: .navigationBar)
    //      }
    //    }
    //    NavigationStack {
    //      NativePopover()
    //    }
    //    ModelViewViews()
    //      .environmentObject(storeModel)
    //    ContainerPatternView()
    
    /// - ReduxView
    //    let store = Store(reducer: appReducer, state: AppState(), middlewares: [productsMiddleware()])
    //    NavigationStack {
    //      ReduxView()
    //        .environmentObject(store)
    //    }
    
    //    SharedTransitionMatchedGeometryEffectView()
    //      .preferredColorScheme(.light)
    
    //    NavigationStack {
    //      TableView()
    //    }
    //    StartView()
    //    FileImporter()
    //    FileExporter()
    //    AppReviews()
    //    ImageCroppingTool()
    //    DogView()
    //    MemoryManagement()
    //    TaskAndDottaskHomeView()
    //    Actors()
    
    //    DownloadView()
    //      .environmentObject(downloadManager)
    
    //    Clock().padding().frame(width: 200, height: 200)
    
    //    MusicBottomSheet()
    
    //    VotesView().environmentObject(model)
    
    //            ShimmerEffect()
    
    //    InfiniteScroll()
    
    //    DeepLinkApp()
    //      .environmentObject(appData)
    //    // MARK: - Called when Deep Links was triggered
    //      .onOpenURL { url in
    //        let string = url.absoluteString.replacingOccurrences(of: "swiftui://", with: "")
    //        print(string)
    //        /// - Splitting URL Component's
    //        let components = string.components(separatedBy: "?")
    //        print("COMPONENTS Array_of_Strings----->", components)
    //        // swiftui://tab=settings?nav=terms_of_service
    //        for component in components {
    //          if component.contains("tab=") {
    //            // Tab Change Request
    //            let tabRawValue = component.replacingOccurrences(of: "tab=", with: "")
    //            print(tabRawValue)
    //            if let requestedTab = Tab.convert(from: tabRawValue) {
    //              appData.activeTab = requestedTab
    //            }
    //          }
    //
    //          /// Navigation will only be updated if the link contains or specifies which tab navigation needs to be changed.
    //          if component.contains("nav=") && string.contains("tab"){
    //            // Nav Change Request
    //            let requestedNavPath = component.replacingOccurrences(of: "nav=", with: "")
    //              .replacingOccurrences(of: "_", with: " ")
    //            print(requestedNavPath)
    //
    //            switch appData.activeTab {
    //              case .home:
    //                if let navPath = HomeStack.convert(from: requestedNavPath) {
    //                  appData.homeNavStack.append(navPath)
    //                }
    //              case .favourites:
    //                if let navPath = FavouriteStack.convert(from: requestedNavPath) {
    //                  appData.favouriteNavStack.append(navPath)
    //                }
    //              case .settings:
    //                if let navPath = SettingsStack.convert(from: requestedNavPath) {
    //                  appData.settingNavStack.append(navPath)
    //                }
    //            }
    //          }
    //        }
    //      }
    
    //    Markdowns()
    
    VisaCard().preferredColorScheme(.light)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

