//
//  CityView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 28/01/23.
//

import SwiftUI

struct CityView: View {
  let city: City
  
  var body: some View {
    VStack {
      ZStack {
        if city.isCapital {
          Text("🌟")
            .font(.system(size: 200))
        }
        VStack {
          Text(city.name)
          Text("(\(city.country))")
          Text("\(city.population)")
            .font(.title)
        }
        .font(.largeTitle)
        .padding()
      }
    }
    .navigationTitle("City")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct CityView_Previews: PreviewProvider {
  static var previews: some View {
    CityView(city: City.sample[1])
  }
}
