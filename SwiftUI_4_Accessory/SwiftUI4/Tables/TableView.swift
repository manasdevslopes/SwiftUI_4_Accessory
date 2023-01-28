//
//  TableView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 28/01/23.
//

import SwiftUI

struct TableView: View {
  @State private var users: [TableUser] = [
    TableUser(name: "Manas", score: 95),
    TableUser(name: "Ashi", score: 95),
    TableUser(name: "Kanishk", score: 94),
    TableUser(name: "Kalyani Di", score: 90),
    TableUser(name: "Shikha", score: 90)
  ]
  
  /// - Single Selction
  // @State private var selection: TableUser.ID?
  /// - Multiple Selection
  @State private var selection = Set<TableUser.ID>()
  
  @State private var sortOrder = [KeyPathComparator(\TableUser.name)]
  
  var body: some View {
    VStack(spacing: 50) {
      Table(users, selection: $selection, sortOrder: $sortOrder) {
        TableColumn("Name", value: \.name)
        TableColumn("Score") {user in
          Text("\(user.score)")
        }
        // .width(100) Or,
        .width(min: 50, max: 100)
      }
      .tableStyle(.inset)
      .onChange(of: sortOrder) { newOrder in
        users.sort(using: newOrder)
      }
      
      Table(selection: $selection, sortOrder: $sortOrder) {
        TableColumn("Name", value: \.name)
        TableColumn("Score") {user in
          Text("\(user.score)")
        }
        // .width(100) Or,
        .width(min: 50, max: 100)
      } rows: {
        TableRow(TableUser(id: UUID(), name: "FIRST", score: 0))
        ForEach(users, content: TableRow.init)
        TableRow(TableUser(id: UUID(), name: "LAST", score: 100))
      }
      .tableStyle(InsetTableStyle())
      .onChange(of: sortOrder) { newOrder in
        users.sort(using: newOrder)
      }
      
//      if !selection.isEmpty {
//        ForEach(users.filter({ $0.id == selection })) { item in
//
//        }
//      }
    }
  }
}

struct TableView_Previews: PreviewProvider {
  static var previews: some View {
    TableView()
  }
}
