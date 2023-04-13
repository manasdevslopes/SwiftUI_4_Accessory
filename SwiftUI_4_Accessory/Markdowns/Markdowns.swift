//
//  Markdowns.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 13/04/23.
//

import SwiftUI

struct Markdowns: View {
  @State private var text: String = ""
  @State private var helperText: String = "**Bold** *Italic* ***Bold Italic*** ~Strike Through~ [click](https://www.apple.com) #hashtags"
  
  var str1 = "**Bold**"
  var str2 = "*Italic*"
  var str3 = "***Bold Italic***"
  var str4 = "~Strike Through~"
  var str5 = "[link_text](https://www.apple.com)"
  var str6 = "#hashtag"
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        notetext
        TextField("Enter Markdowns Text...", text: $text, axis: .vertical)
          .textFieldStyle(.roundedBorder)
          .lineLimit(1...5)
          .font(.body)
        
        Divider().padding(.top)
        Text("Preview:")
          .font(.headline)
        textWithHashtags(text, color: Color(hex: "#53E0BC"))
          .font(Font.custom("Avenir Next", size: 20)).tint(Color(hex: "#53E0BC"))
      }
      .padding(20)
    }
    .scrollDismissesKeyboard(.interactively)
  }
}

extension Markdowns {
  private var notetext: some View {
    VStack(alignment: .leading) {
      Text("**Note:** You can use markdowns too.\neg.:")
      Text("\u{2022} \(str1)")
      Text("\u{2022} \(str2)")
      Text("\u{2022} \(str3)")
      Text("\u{2022} \(str4)")
      Text("\u{2022} \(str5)")
      Text("\u{2022} \(str6)")
    }
  }
}

extension Markdowns {
  func textWithHashtags(_ text: String, color: Color) -> Text {
    let words = text.split(separator: " ")
    var output: Text = Text("")
    
    for word in words {
      if word.hasPrefix("#") { // Pick out hash in words
        output = output + Text(" ") + Text(String(word))
          .foregroundColor(color) // Add custom styling here
      } else if word.hasPrefix("**") || word.hasPrefix("*") || word.hasPrefix("***") ||  word.hasPrefix("~") {
        output = output + Text(" ") + Text(getAttributedString(markdown: String(word)))
          .foregroundColor(color) // Add custom styling here
      } else if word.hasPrefix("[") {
        output = output + Text(" ") + Text(getAttributedString(markdown: String(word)))
      } else {
        output = output + Text(String(word))
      }
    }
    return output
  }
  
  
  func getAttributedString(markdown: String) -> AttributedString {
    do {
      let attributedString = try AttributedString(markdown: markdown)
      return attributedString
    } catch {
      print("Couldn't parse: \(error)")
    }
    return AttributedString("Error parsing markdown")
  }
  
}

struct Markdowns_Previews: PreviewProvider {
  static var previews: some View {
    Markdowns()
  }
}
