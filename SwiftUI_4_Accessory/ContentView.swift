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
    
    Clock().padding().frame(width: 200, height: 200)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

