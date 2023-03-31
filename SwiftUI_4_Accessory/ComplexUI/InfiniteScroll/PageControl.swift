//
//  PageControl.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 31/03/23.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
  var totalPages: Int
  var currentPage: Int
  
  func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.numberOfPages = totalPages
    control.currentPage = currentPage
    control.backgroundStyle = .prominent
    control.allowsContinuousInteraction = false
    
    return control
  }
  
  func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.numberOfPages = totalPages
    uiView.currentPage = currentPage
  }
}

