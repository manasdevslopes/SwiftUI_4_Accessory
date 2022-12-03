//
//  NewLayoutAPI.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 06/11/22.
//

import SwiftUI

struct NewLayoutAPI: View {
  @State private var tags: [Tag] = rawTags.compactMap { tag -> Tag? in
    return .init(name: tag)
  }
  
  // MARK: - Segment Value
  @State private var alignmentValue: Int = 0
  // MARK: - Text Value
  @State private var text: String = ""
  
  var body: some View {
    NavigationStack {
      HStack {
        // MARK: - Multiline Text Field New API
        TextField("Add Tag", text: $text, axis: .vertical)
          .textFieldStyle(.roundedBorder)
          .lineLimit(1...5)
        
        Button("Add") {
          withAnimation(.spring()) {
            tags.append(Tag(name: text))
            text = ""
          }
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 4))
        .tint(.red)
        .disabled(text == "")
      }
      .padding(.horizontal, 15)
      
      VStack{
        ScrollView {
          VStack {
            Picker("", selection: $alignmentValue) {
              Text("Leading")
                .tag(0)
              Text("Center")
                .tag(1)
              Text("Trailing")
                .tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 20)
            
            TagView(alignment: alignmentValue == 0 ? .leading : alignmentValue == 1 ? .center : .trailing, spacing: 20) {
              ForEach($tags) { $tag in
                // MARK: - New Toggle API
                Toggle(tag.name, isOn: $tag.isSelected)
                  .toggleStyle(.button)
                  .buttonStyle(.bordered)
                  .tint(tag.isSelected ? .red : .gray)
              }
            }
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6), value: alignmentValue)
            
            
            //          HStack {
            //            // MARK: - Multiline Text Field New API
            //            TextField("Add Tag", text: $text, axis: .vertical)
            //              .textFieldStyle(.roundedBorder)
            //              .lineLimit(1...5)
            //
            //            Button("Add") {
            //              withAnimation(.spring()) {
            //                tags.append(Tag(name: text))
            //                text = ""
            //              }
            //            }
            //            .buttonStyle(.bordered)
            //            .buttonBorderShape(.roundedRectangle(radius: 4))
            //            .tint(.red)
            //            .disabled(text == "")
            //          }
          }
          .padding(15)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .navigationTitle("Layout")
        .scrollDismissesKeyboard(.immediately) // .automatic, .immediately, .interactively, .never
        .scrollIndicators(.visible) // .visible, .hidden, .automatic, .never
      }
      
      // MARK: - selected tags
      VStack {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(tags.filter({ tag in
              tag.isSelected == true
            })) {selectedTag in
              Text(selectedTag.name)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .overlay {
                  Capsule(style: .continuous)
                    .stroke(.purple, style: StrokeStyle(lineWidth: 1))
                }
            }
          }
          .padding(1)
        }
      }
      .padding(15)
      
      HStack {
        // MARK: - Multiline Text Field New API
        TextField("Add Tag", text: $text, axis: .vertical)
          .textFieldStyle(.roundedBorder)
          .lineLimit(1...5)
        
        Button("Add") {
          withAnimation(.spring()) {
            tags.append(Tag(name: text))
            text = ""
          }
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 4))
        .tint(.red)
        .disabled(text == "")
      }
      .padding(15)
    }
    .persistentSystemOverlays(.hidden)
  }
}

struct NewLayoutAPI_Previews: PreviewProvider {
  static var previews: some View {
    NewLayoutAPI()
  }
}

// MARK: - Building custom layout with the new layout API
struct TagView: Layout {
  var alignment: Alignment = .center
  var spacing: CGFloat = 10
  init(alignment: Alignment, spacing: CGFloat) {
    self.alignment = alignment
    self.spacing = spacing
  }
  
  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    // returning default proposal size
    return .init(width: proposal.width ?? 0 , height: proposal.height ?? 0)
  }
  
  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    // MARK: - Placing Views
    var origin = bounds.origin
    let maxWidth = bounds.width
    
    // MARK: - Type 2
    var row: ([LayoutSubviews.Element], Double) = ([], 0.0)
    var rows: [([LayoutSubviews.Element], Double)] = []
    
    for view in subviews {
      let viewSize = view.sizeThatFits(proposal)
      if (origin.x + viewSize.width + spacing) > maxWidth {
        // This will give how much space remaining in a row
        row.1 = (bounds.maxX - origin.x + bounds.minX + spacing)
        rows.append(row)
        row.0.removeAll()
        // Resetting Horizontal Axis
        origin.x = bounds.origin.x
        // Next View
        row.0.append(view)
        origin.x += (viewSize.width + spacing)
      } else {
        row.0.append(view)
        origin.x += (viewSize.width + spacing)
      }
    }
    
    // MARK: - Exhaust Ones
    if !row.0.isEmpty {
      row.1 = (bounds.maxX - origin.x + bounds.minX + spacing)
      rows.append(row)
    }
    
    // MARK: - Resetting Origin
    origin = bounds.origin
    
    for row in rows {
      // Resetting x Origin for new Row
      origin.x = (alignment == .leading ? bounds.minX : (alignment == .trailing ? row.1 : row.1 / 2 ))
      for view in row.0 {
        let viewSize = view.sizeThatFits(proposal)
        view.place(at: origin, proposal: proposal)
        origin.x += (viewSize.width + spacing)
      }
      // Max Height in the row
      let maxHeight = row.0.compactMap { view -> CGFloat? in
        return view.sizeThatFits(proposal).height
      }.max() ?? 0
      // Updating vertical origin
      origin.y += (maxHeight + spacing)
      
    }
    
    // MARK: - Type 1
    //    subviews.forEach { view in
    //      let viewSize = view.sizeThatFits(proposal)
    //      // Checking if view is going over maxWidth
    //      if (origin.x + viewSize.width + spacing) > maxWidth {
    //        // Updating for next element in vertical direction
    //        origin.y += (viewSize.height + spacing)
    //        // Resetting Horizontal Axis
    //        origin.x = bounds.origin.x
    //        // Next View
    //        view.place(at: origin, proposal: proposal)
    //        // Updating origin for Next Placement
    //        // Adding padding
    //        origin.x += (viewSize.width + spacing)
    //      } else {
    //        view.place(at: origin, proposal: proposal)
    //        // Updating origin for Next Placement
    //        // Adding padding
    //        origin.x += (viewSize.width + spacing)
    //      }
    //    }
    //
  }
}

// MARK: - String tags
var rawTags: [String] = [
  "SwiftUI", "Swift", "Xcode", "Apple ", "WWDC22", "iOS16", "iPadOS16", "macOS13", "watchOS9", "Xcode14", "API's"
]

// MARK: - Tag Model
struct Tag: Identifiable {
  var id = UUID().uuidString
  var name: String
  var isSelected: Bool = false
}
