//
//  CustomVideoPlayer.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
  typealias UIViewControllerType = AVPlayerViewController
  
  var player: AVPlayer
  
  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = AVPlayerViewController()
    controller.player = player
    controller.showsPlaybackControls = false
    controller.videoGravity = .resizeAspectFill
    controller.view.backgroundColor = .clear
    return controller
  }
  
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    uiViewController.player = player
  }
}
