//
//  ShareLinkAPI.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/11/22.
//

import SwiftUI

struct ShareLinkAPI: View {
  var link = URL(string: "https://blacenova.wordpress.com")!

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading, spacing: 20) {
        Group {
          ShareLink(item: link) {
            Text("Share link")
          }
          Text("Share Link with Custom Text only")
        }
        Group {
          ShareLink("", item: link)
          Text("Share Link with no Text, only default Icon")
        }
        Group {
          ShareLink(item: link)
          Text("Share Link with default Text & default Icon")
        }
        Group {
          ShareLink("Learn Swift here", item: link)
          Text("Share Link with Custom Text & default Icon")
        }
        Group {
          ShareLink(item: link, subject: Text(" Developer"), message: Text("Learn Swift here"))
          Text("Share Link with custom subject, message & default Text & default Icon")
        }
        Group {
          ShareLink(item: link) {
            Label("Learn Swift here", systemImage: "swift")
          }
          Text("Share Link with Custom Text & Custom Icon")
        }
        Group {
          // Combining all
          ShareLink(item: link, subject: Text(" Developer"), message: Text("Learn  development w/ Swift here")) {
            Label("Learn Swift here", systemImage: "swift")
          }
          Text("Share Link with custom subject, custom message & custom Text & custom Icon")
        }
        Group {
          ShareLink(item: link, preview: SharePreview("Check New Blog every week", image: Image(systemName: "swift")))
          Text("Share Link with custom Preview of ShareSheet in Beta Mode.")
        }
      }
    }
    .toolbar {
      ToolbarItem(placement: .bottomBar) {
        ShareLink(item: link) //Share Link with Custom Icon only
      }
    }
  }
}

struct ShareLinkAPI_Previews: PreviewProvider {
  static var previews: some View {
    ShareLinkAPI()
  }
}
