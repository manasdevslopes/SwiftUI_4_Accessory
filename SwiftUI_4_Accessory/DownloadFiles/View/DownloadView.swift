//
//  DownloadView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 17/03/23.
//

import SwiftUI

struct DownloadView: View {
  @EnvironmentObject var downloadManager: DownloadManager
  @State private var showVideo = false
  
  var body: some View {
    VStack(spacing: 40) {
      DownloadButton()
      
      if downloadManager.isDownloaded {
        WatchButton()
          .onTapGesture {
            showVideo = true
          }
          .fullScreenCover(isPresented: $showVideo) {
            VideoView(showVideo: $showVideo)
          }
      }
    }
    .padding(.horizontal, 20)
    .onAppear {
      downloadManager.checkFileExists()
    }
    .onChange(of: downloadManager.isDownloading) { _ in
      downloadManager.checkFileExists()
    }
  }
}

struct DownloadView_Previews: PreviewProvider {
  static var previews: some View {
    DownloadView()
      .environmentObject(DownloadManager())
  }
}
