//
//  Webservice.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/01/23.
//

import Foundation

class Webservice {
  static let instance = Webservice()
  private init() {}
  
  func getAllProducts() async throws -> [Product] {
    guard let url = URL(string: "https://api.escuelajs.co/api/v1/products") else {
      fatalError("URL is incorrect!")
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([Product].self, from: data)
  }
}
