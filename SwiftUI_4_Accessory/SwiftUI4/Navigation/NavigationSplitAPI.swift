//
//  NavigationSplitAPI.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/11/22.
//

import SwiftUI

struct Team: Identifiable, Hashable {
  let id = UUID()
  var name: String
  var players: [String]
}

struct NavigationSplitAPI: View {
  @State private var players = ["Dani", "Jamie", "Roy"]
  @State private var teams = [
    Team(name: "AFC Richmond", players: ["Dani", "Jamie", "Roy"])
  ]
  @State private var selectedTeam: Team?
  @State private var selectedPlayer: String?
  
  var body: some View {
    NavigationSplitView {
      // List(players, id:\.self, selection: $selectedPlayer, rowContent: Text.init)
      List(teams, selection: $selectedTeam) { team in
        Text(team.name).tag(team)
      }
      .navigationSplitViewColumnWidth(250)
    } content: {
      List(selectedTeam?.players ?? [], id:\.self, selection: $selectedPlayer, rowContent: Text.init)
    } detail: {
      Text(selectedPlayer ?? "Please choose a player.")
    }
    .navigationSplitViewStyle(.prominentDetail) // .prominentDetail or .balanced or .automatic
  }
}

struct NavigationSplitAPI_Previews: PreviewProvider {
  static var previews: some View {
    NavigationSplitAPI()
  }
}
