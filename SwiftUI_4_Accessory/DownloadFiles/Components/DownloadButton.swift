//
//  DownloadButton.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 17/03/23.
//

import SwiftUI

struct DownloadButton: View {
  @EnvironmentObject var downloadManager: DownloadManager
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    let colors: Array<Color> = downloadManager.isDownloaded ?
                               (colorScheme == .dark ? [Color(#colorLiteral(red: 0.6196078431, green: 0.6784313725, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5607843137, blue: 0.9803921569, alpha: 1))] : [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1))])
                               : [Color.primary]
    
    return HStack(spacing: 8) {
      VStack(alignment: .leading, spacing: 4) {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
          .mask(Text(downloadManager.isDownloaded ? "Downloaded" : "Download")
            .fontWeight(.semibold)
            .textCase(.uppercase)
            .font(.footnote).frame(maxWidth: .infinity, alignment: .leading))
          .frame(maxHeight: 30)
        
        VStack(alignment: .leading, spacing: 0) {
          Text(downloadManager.isDownloaded ? "Delete the downloaded file" : "Watch offline")
            .font(.caption2).foregroundColor(Color.primary).opacity(0.7)
        }
        .frame(maxWidth: 200, alignment: .leading).fixedSize(horizontal: false, vertical: true)
      }
      
      Group {
        if downloadManager.isDownloading {
          ProgressView()
        } else {
          Image(systemName: downloadManager.isDownloaded ? "trash" : "square.and.arrow.down")
            .font(.system(size: 15, weight: .bold)).foregroundColor(Color.primary).opacity(0.7)
        }
      }
      .frame(width: 32, height: 32).overlay(Circle().stroke(style: StrokeStyle(lineWidth: 1)).opacity(0.1))
    }
    .padding(.horizontal, 12).padding(.vertical, 16)
    .background(colorScheme == .dark ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2) : Color(#colorLiteral(red: 0.9568627451, green: 0.9450980392, blue: 1, alpha: 1)))
    .cornerRadius(20)
    .onTapGesture {
      downloadManager.isDownloaded ? downloadManager.deleteFile() : downloadManager.downloadFile()
    }
  }
}

struct DownloadButton_Previews: PreviewProvider {
  static var previews: some View {
    DownloadButton()
      .environmentObject(DownloadManager())
  }
}
