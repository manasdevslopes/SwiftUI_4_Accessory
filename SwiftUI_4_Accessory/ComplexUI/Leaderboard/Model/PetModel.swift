//
//  PetModel.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/03/23.
//

import SwiftUI

struct Pet: Identifiable, Hashable {
  let type: String
  let color: Color
  var votes: Int = 0
  var id: String { type }
}
