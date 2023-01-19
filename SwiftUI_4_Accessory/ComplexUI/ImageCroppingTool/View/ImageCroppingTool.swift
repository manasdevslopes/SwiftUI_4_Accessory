//
//  ImageCroppingTool.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 19/01/23.
//

import SwiftUI

struct ImageCroppingTool: View {
  @State private var showPicker: Bool = false
  @State private var croppedImage: UIImage?
  
  var body: some View {
    NavigationStack {
      VStack {
        if let croppedImage {
          Image(uiImage: croppedImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 400)
        } else {
          Text("No Image is Selected")
            .font(.caption)
            .foregroundColor(.gray)
        }
      }
      .navigationTitle("Crop Image Picker")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showPicker.toggle()
          } label: {
            Image(systemName: "photo.on.rectangle.angled")
              .font(.callout)
          }
          .tint(.black)
        }
      }
      .cropImagePicker(options: [.circle, .rectangle, .square, .custom(.init(width: 200, height: 200))], show: $showPicker, croppedImage: $croppedImage)
    }
  }
}

struct ImageCroppingTool_Previews: PreviewProvider {
  static var previews: some View {
    ImageCroppingTool()
  }
}
