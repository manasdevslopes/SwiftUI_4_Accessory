//
//  Dog.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 16/02/23.
//

import Swift

//model
struct Dog: Codable {
  let imageURL: String
  
  enum CodingKeys: String, CodingKey {
    case imageURL = "message"
  }
}
