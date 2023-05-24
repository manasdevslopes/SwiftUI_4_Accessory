//
//  TextTips6.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/05/23.
//

import SwiftUI

// 6. Dynamic dates
struct TextTips6: View {
    var body: some View {
      let eventDate = Date(timeIntervalSinceNow: 646)
      
      VStack {
        // Date updates automatically in the UI
        Text(eventDate, style: .time)
        Text(eventDate, style: .timer)
        Text(eventDate, style: .offset)
        Text(eventDate, style: .date)
        Text(eventDate, style: .relative)
        
        // Force numeric characters take the same width independent of the digits
        // and prevent the UI from jittering
        Text("\(eventDate, style: .relative) left until the event")
          .monospacedDigit()
          .font(.title)
          .padding()
      }
      .font(.title)
      .padding()
    }
}

struct TextTips6_Previews: PreviewProvider {
    static var previews: some View {
        TextTips6()
    }
}
