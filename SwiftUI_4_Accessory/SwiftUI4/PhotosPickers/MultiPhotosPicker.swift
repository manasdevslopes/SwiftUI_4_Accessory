//
//  MultiPhotosPicker.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 19/05/23.
//

import PhotosUI
import SwiftUI

struct MultiPhotosPicker: View {
  @State private var selectedItems = [PhotosPickerItem]()
  @State private var selectedImages = [Image]()

    var body: some View {
      NavigationStack {
        ScrollView {
          LazyVStack {
            ForEach(0..<selectedImages.count, id: \.self) { i in
              selectedImages[i].resizable().scaledToFit().frame(width: 300, height: 300)
            }
          }
        }
        .toolbar {
          PhotosPicker("Select images", selection: $selectedItems, maxSelectionCount: 3, matching: .images)
        }
        .onChange(of: selectedItems) { _ in
          Task {
            selectedImages.removeAll()
            
            for item in selectedItems {
              if let data = try? await item.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                  let image = Image(uiImage: uiImage)
                  selectedImages.append(image)
                }
              }
            }
          }
        }
      }
    }
}

struct MultiPhotosPicker_Previews: PreviewProvider {
    static var previews: some View {
        MultiPhotosPicker()
    }
}
