//
//  MyEqualWidthVStack.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/03/23.
//

import SwiftUI

struct MyEqualWidthVStack: Layout {
  func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout CacheData
  ) -> CGSize {
    guard !subviews.isEmpty else { return .zero }
    
    let maxSize = cache.maxSize
    let totalSpacing = cache.totalSpacing
    
    return CGSize(
      width: maxSize.width,
      height: maxSize.height * CGFloat(subviews.count) + totalSpacing)
  }
  
  func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout CacheData
  ) {
    guard !subviews.isEmpty else { return }
    
    let maxSize = cache.maxSize
    let spacing = cache.spacing
    
    let placementProposal = ProposedViewSize(width: maxSize.width, height: bounds.height)
    var nextY = bounds.minY + maxSize.height / 2
    
    for index in subviews.indices {
      subviews[index].place(
        at: CGPoint(x: bounds.midX, y: nextY),
        anchor: .center,
        proposal: placementProposal)
      nextY += maxSize.height + spacing[index]
    }
  }
  

  struct CacheData {
    let maxSize: CGSize
    let spacing: [CGFloat]
    let totalSpacing: CGFloat
  }
  
  func makeCache(subviews: Subviews) -> CacheData {
    let maxSize = maxSize(subviews: subviews)
    let spacing = spacing(subviews: subviews)
    let totalSpacing = spacing.reduce(0) { $0 + $1 }
    
    return CacheData(
      maxSize: maxSize,
      spacing: spacing,
      totalSpacing: totalSpacing)
  }
  
  private func maxSize(subviews: Subviews) -> CGSize {
    let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
    let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
      CGSize(
        width: max(currentMax.width, subviewSize.width),
        height: max(currentMax.height, subviewSize.height))
    }
    
    return maxSize
  }

  private func spacing(subviews: Subviews) -> [CGFloat] {
    subviews.indices.map { index in
      guard index < subviews.count - 1 else { return 0 }
      
      return subviews[index].spacing.distance(
        to: subviews[index + 1].spacing,
        along: .vertical)
    }
  }
}
