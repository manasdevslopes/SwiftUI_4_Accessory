//
//  VideoView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 17/03/23.
//

import SwiftUI
import AVKit

struct VideoView: View {
  @EnvironmentObject var downloadManager: DownloadManager
  @State var player = AVPlayer()
  @Binding var showVideo: Bool
  
  var body: some View {
    VideoPlayer(player: player) {
      VStack {
        HStack {
          Button {
            self.showVideo = false
          } label: {
            Image(systemName: "xmark")
              .resizable()
              .renderingMode(.template)
              .frame(width: 30, height: 30)
              .foregroundColor(.white)
          }
          Spacer()
        }
        Spacer()
      }
      .padding([.leading, .top], 16)
    }
    .edgesIgnoringSafeArea(.all)
    .onAppear {
      let playerItem = downloadManager.getVideoFileAsset()
      if let playerItem {
        player = AVPlayer(playerItem: playerItem)
      }
      player.play()
    }
  }
}

struct VideoView_Previews: PreviewProvider {
  static var previews: some View {
    VideoView(showVideo: .constant(false)).environmentObject(DownloadManager())
  }
}
