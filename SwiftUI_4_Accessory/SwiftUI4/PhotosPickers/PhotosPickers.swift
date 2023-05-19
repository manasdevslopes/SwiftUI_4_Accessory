//
//  PhotosPickers.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 19/05/23.
//

import SwiftUI
import PhotosUI

struct PhotosPickers: View {
  @State private var avatarItem: PhotosPickerItem?
  @State private var avatarImage: Image?
  
  var body: some View {
    VStack {
      PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
      
      if let avatarImage {
        avatarImage.resizable().scaledToFit().frame(width: 300, height: 300)
      }
    }
    .onChange(of: avatarItem) { _ in
      Task {
        if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
          if let uiImage = UIImage(data: data) {
            avatarImage = Image(uiImage: uiImage)
            return
          }
        }
        
        print("Failed")
      }
    }
  }
}

struct PhotosPicker_Previews: PreviewProvider {
  static var previews: some View {
    PhotosPickers()
  }
}

/* If you want more control over the data that is selected, adjust the matching parameter based on what you’re looking for:
 // Use matching: .screenshots if you only want screenshots.
 // Use matching: .any(of: [.panoramas, .screenshots]) if you want either of those types.
 // Use matching: .not(.videos) if you want any media that isn’t a video.
 // Use matching: .any(of: [.images, .not(.screenshots)])) if you want all kinds of images except screenshots.
 */
