//
//  FileExporter.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 30/01/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileExporter: View {
  @State private var exportAssetImage: Bool = false
  @State private var exportImage: PNGDocument?
  
    var body: some View {
      Button("Export Image") {
        if let image = FileImage(named: "manas_iosdev") {
          exportImage = PNGDocument(image: image)
          exportAssetImage.toggle()
        }
      }
      .fileExporter(isPresented: $exportAssetImage, document: exportImage, contentType: .png) { result in
        switch result {
          case .success(let success):
            print("Saved Successfully------>", success)
          case .failure(let failure):
            print("Failed", failure.localizedDescription)
        }
      }
    }
}

/// - Creating Document File for Saving Image as PNG File
/// - Optimising it for Both iOS & macOS
#if os(iOS)
typealias FileImage = UIImage  // iOS
#else
typealias FileImage = NSImage // MacOS
#endif
struct PNGDocument: FileDocument {
  var image: FileImage
  
  init(image: FileImage) {
    self.image = image
  }
  
  static var readableContentTypes: [UTType] {[.png]}
  
  init(configuration: ReadConfiguration) throws {
    guard let pngData = configuration.file.regularFileContents,
          let pngImage = FileImage(data: pngData) else {
      throw CocoaError(.fileReadUnknown)
    }
    image = pngImage
  }
  
  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    #if os(iOS)
    guard let pngData = image.pngData() else { return .init() }
    #else
    guard let pngData = image.tiffRepresentation else { return .init() } // For MacOS , we need to add Sandbox Property -> Under Target Capabilities -> App Sandbox --> File Access Type -> User Selected File --> Select "Read/Write" from dropdown.
    #endif
    
    return .init(regularFileWithContents: pngData)
  }
}

struct FileExporter_Previews: PreviewProvider {
    static var previews: some View {
        FileExporter()
    }
}
