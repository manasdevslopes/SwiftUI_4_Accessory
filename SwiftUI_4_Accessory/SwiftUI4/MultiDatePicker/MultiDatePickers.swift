//
//  MultiDatePickers.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 02/12/22.
//

import SwiftUI

struct MultiDatePickers: View {
  @State private var dates = Set<DateComponents>()
  @Environment(\.calendar) var calendar
  
  var body: some View {
    VStack {
      MultiDatePicker("Select your preferred dates", selection: $dates, in: Date.now...)
      Text(summary)
    }
    .padding()
  }
  
  var summary: String {
    dates.compactMap { components in
      calendar.date(from: components)?.formatted(date: .long, time: .omitted)
    }.formatted()
  }
}

struct MultiDatePickers_Previews: PreviewProvider {
  static var previews: some View {
    MultiDatePickers()
  }
}
