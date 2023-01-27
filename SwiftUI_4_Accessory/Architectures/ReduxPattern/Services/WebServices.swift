//
//  WebServices.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import Foundation

class Webservices {
  static let instance = Webservices()
  private init() {}
  
  func getAllProducts() async throws -> [Products] {
    guard let url = URL(string: "https://api.escuelajs.co/api/v1/products") else {
      fatalError("URL is incorrect!")
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([Products].self, from: data)
  }
}
