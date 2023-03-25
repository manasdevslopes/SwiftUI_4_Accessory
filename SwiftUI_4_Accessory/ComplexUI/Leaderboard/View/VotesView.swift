//
//  VotesView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/03/23.
//

import SwiftUI

struct VotesView: View {
    var body: some View {
      VStack {
        Spacer()
        Profile()
        Spacer()
        Leaderboard()
        Spacer()
        ButtonStack()
          .padding(.bottom)
      }
    }
}

struct VotesView_Previews: PreviewProvider {
    static var previews: some View {
        VotesView().environmentObject(Model.previewData)
    }
}

