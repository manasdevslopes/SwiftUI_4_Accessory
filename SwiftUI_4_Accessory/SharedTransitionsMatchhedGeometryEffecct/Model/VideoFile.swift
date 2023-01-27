//
//  VideoFile.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import SwiftUI
import AVKit

struct VideoFile: Identifiable {
  var id: UUID = .init()
  var fileURL: URL
  var thumbnail: UIImage?
  var player: AVPlayer
  var offset: CGSize = .zero
  var playVideo: Bool = false
}

var videoURL1: URL = URL(filePath: Bundle.main.path(forResource: "Reel1", ofType: "MP4") ?? "")
var videoURL2: URL = URL(filePath: Bundle.main.path(forResource: "Reel2", ofType: "MP4") ?? "")
var videoURL3: URL = URL(filePath: Bundle.main.path(forResource: "Reel3", ofType: "MP4") ?? "")
var videoURL4: URL = URL(filePath: Bundle.main.path(forResource: "Reel4", ofType: "MP4") ?? "")
var videoURL5: URL = URL(filePath: Bundle.main.path(forResource: "Reel5", ofType: "MP4") ?? "")
var videoURL6: URL = URL(filePath: Bundle.main.path(forResource: "Reel6", ofType: "MP4") ?? "")
var videoURL7: URL = URL(filePath: Bundle.main.path(forResource: "Reel7", ofType: "MP4") ?? "")

var files: [VideoFile] = [
  .init(fileURL: videoURL1, player: AVPlayer(url: videoURL1)),
  .init(fileURL: videoURL2, player: AVPlayer(url: videoURL2)),
  .init(fileURL: videoURL3, player: AVPlayer(url: videoURL3)),
  .init(fileURL: videoURL4, player: AVPlayer(url: videoURL4)),
  .init(fileURL: videoURL5, player: AVPlayer(url: videoURL5)),
  .init(fileURL: videoURL6, player: AVPlayer(url: videoURL6)),
  .init(fileURL: videoURL7, player: AVPlayer(url: videoURL7))
]
