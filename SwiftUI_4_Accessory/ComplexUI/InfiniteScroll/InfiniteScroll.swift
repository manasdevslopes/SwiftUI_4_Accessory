//
//  InfiniteScroll.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 31/03/23.
//

import SwiftUI

struct InfiniteScroll: View {
  @State private var currentPage: String = ""
  @State private var listOfPages: [Page] = []
  @State private var fakedPages: [Page] = []
  
  var body: some View {
    NavigationStack {
      GeometryReader {
        let size = $0.size
        
        TabView(selection: $currentPage) {
          ForEach(fakedPages) { page in
            RoundedRectangle(cornerRadius: 25, style: .continuous)
              .fill(page.color.gradient).frame(width: 300, height: size.height)
              .tag(page.id.uuidString)
            /// - Calculating Entire page Scroll Offset
              .offsetX(currentPage == page.id.uuidString) { rect in
                let minX = rect.minX
                let pageOffset = minX - (size.width * CGFloat(fakeIndex(page)))
                /// - Converting Pageoffset into %age
                let pageProgress = pageOffset / size.width
                /// - Infinite Carousel Logic
                if -pageProgress < 1.0 {
                  /// - Moving to the last page
                  /// - which is Actually the First duplicate page
                  /// - Safe Check
                  if fakedPages.indices.contains(fakedPages.count - 1) {
                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                  }
                }
                
                if -pageProgress > CGFloat(fakedPages.count - 1) {
                  /// - Moving to the First page
                  /// - which is Actually the Last duplicate page
                  /// - Safe Check
                  if fakedPages.indices.contains(1) {
                    currentPage = fakedPages[1].id.uuidString
                  }
                }
              }
          }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
          PageControl(totalPages: listOfPages.count, currentPage: originalIndex(currentPage))
            .offset(y: -15)
        }
      }
      .frame(height: 400)
      .onAppear {
        guard fakedPages.isEmpty else { return }
        for color in [Color.red, Color.green, Color.blue, Color.yellow, Color.black, Color.brown] {
          listOfPages.append(.init(color: color))
        }
        
        fakedPages.append(contentsOf: listOfPages)
        
        if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
          currentPage = firstPage.id.uuidString
          
          ///- Updating IDS
          firstPage.id = .init()
          lastPage.id = .init()
          
          fakedPages.append(firstPage)
          fakedPages.insert(lastPage, at: 0)
        }
      }
      .navigationTitle("Infinite Carousel")
    }
  }
}

extension InfiniteScroll {
  func fakeIndex(_ of: Page) -> Int {
    return fakedPages.firstIndex(of: of) ?? 0
  }
  
  func originalIndex(_ id: String) -> Int {
    return listOfPages.firstIndex { page in
      page.id.uuidString == id
    } ?? 0
  }
}

struct InfiniteScroll_Previews: PreviewProvider {
  static var previews: some View {
    InfiniteScroll()
  }
}
