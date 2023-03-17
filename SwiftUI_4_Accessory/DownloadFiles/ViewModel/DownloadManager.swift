//
//  DownloadManager.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 17/03/23.
//

import Foundation
import AVKit

final class DownloadManager: ObservableObject {
  @Published var isDownloading = false
  @Published var isDownloaded = false
  
  ///- Download File
  func downloadFile() {
    print("************downloadFile***************")
    isDownloading = true
    
    let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let destinationUrl = docsUrl?.appendingPathComponent("myVideo.mp4")
    
    if let destinationUrl {
      if FileManager().fileExists(atPath: destinationUrl.path()) {
        print("File already exists")
        isDownloading = false
      } else {
        // https://download.samplelib.com/mp4/sample-5s.mp4
        guard let url = URL(string: "https://download.samplelib.com/mp4/sample-5s.mp4") else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
          if let error {
            print("Request error: ", error)
            self.isDownloading = false
            return
          }
          
          guard let response = response as? HTTPURLResponse else { return }
          if response.statusCode == 200 {
            guard let data else {
              self.isDownloading = false
              return
            }
            
            DispatchQueue.main.async {
              do {
                try data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                DispatchQueue.main.async {
                  self.isDownloading = false
                }
              } catch {
                print("Error decoding: ", error)
                self.isDownloading = false
              }
            }
          }
        }.resume()
      }
    }
  }
  
  ///- Delete File
  func deleteFile() {
    let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let destinationUrl = docsUrl?.appendingPathComponent("myVideo.mp4")
    
    if let destinationUrl {
      guard FileManager().fileExists(atPath: destinationUrl.path) else { return }
      do {
        try FileManager().removeItem(atPath: destinationUrl.path())
        isDownloaded = false
        print("File deleted successfully")
      } catch let error {
        print("Error while deleting video file: ", error)
      }
    }
  }
  
  ///- FileExists
  func checkFileExists() {
    let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let destinationUrl = docsUrl?.appendingPathComponent("myVideo.mp4")
    
    if let destinationUrl {
      if (FileManager().fileExists(atPath: destinationUrl.path)) {
        isDownloaded = true
      } else {
        isDownloaded = false
      }
    } else {
      isDownloaded = false
    }
  }
  
  ///- Get the downloaded Video
  func getVideoFileAsset() -> AVPlayerItem? {
    let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let destinationUrl = docsUrl?.appendingPathComponent("myVideo.mp4")
    
    if let destinationUrl {
      if(FileManager().fileExists(atPath: destinationUrl.path())) {
        let avAssest = AVAsset(url: destinationUrl)
        return AVPlayerItem(asset: avAssest)
      } else {
        return nil
      }
    } else {
      return nil
    }
  }
}
