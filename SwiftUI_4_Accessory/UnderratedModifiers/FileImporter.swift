//
//  FileImporter.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 30/01/23.
//

import SwiftUI
import QuickLook

struct FileImporter: View {
  @State private var pickFile: Bool = false
  @State private var fileURL: URL?
  
    var body: some View {
      Button("Pick File") {
        pickFile.toggle()
      }
      .fileImporter(isPresented: $pickFile, allowedContentTypes: [.mp3, .pdf, .png, .jpeg]) { result in
        switch result {
          case .success(let success):
            /// - File URL
            fileURL = success.absoluteURL
            print("success----->", fileURL!)
          case .failure(let failure):
            print("failure----->", failure.localizedDescription)
        }
      }
      .quickLookPreview($fileURL)
    }
}

struct FileImporter_Previews: PreviewProvider {
    static var previews: some View {
        FileImporter()
    }
}
