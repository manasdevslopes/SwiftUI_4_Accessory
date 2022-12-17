//
//  NavigationStackSeanAllen.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 17/12/22.
//

import SwiftUI

struct NavigationStackSeanAllen: View {
  var platforms: [Platform] = [.init(name: "Xbox", imageName: "xbox.logo", color: .green),
                               .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
                               .init(name: "PC", imageName: "pc", color: .pink),
                               .init(name: "Mobile", imageName: "iphone", color: .mint)]
  
  var games: [Game] = [.init(name: "Minecraft", rating: "99"),
                       .init(name: "God of War", rating: "98"),
                       .init(name: "Fortnite", rating: "92"),
                       .init(name: "Madden 2023", rating: "88")]
  
  //  @State private var path: [Game] = []
  @State private var path = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $path) {
      List {
        Section("Platforms") {
          ForEach(platforms, id:\.name) { platform in
            NavigationLink(value: platform) {
              Label(platform.name, systemImage: platform.imageName)
                .foregroundColor(platform.color)
            }
          }
        }
        
        Section("Games") {
          ForEach(games, id:\.name) { game in
            NavigationLink(value: game) {
              Text(game.name)
            }
          }
          
          //          Button("Add Games") {
          //            // path.append(games.first!)
          //            path = games
          //          }
        }
      }
      .navigationTitle("Gaming")
      .navigationDestination(for: Platform.self) { platform in
        ZStack {
          platform.color.ignoresSafeArea()
          VStack {
            Label(platform.name, systemImage: platform.imageName)
              .font(.largeTitle).bold()
            
            List {
              ForEach(games, id:\.name) { game in
                NavigationLink(value: game) {
                  Text(game.name)
                }
              }
            }
          }
        }
      }
      .navigationDestination(for: Game.self) { game in
        VStack(spacing: 20) {
          Text("\(game.name) - \(game.rating)")
            .font(.largeTitle).bold()
          
          Button("Recommended game") {
            path.append(games.randomElement()!)
          }
          
          Button("Go to another platform") {
            path.append(platforms.randomElement()!)
          }
          
          Button("Go Home") {
            // path.removeLast(4)
            path.removeLast(path.count)
          }
        }
      }
    }
  }
}

struct NavigationStackSeanAllen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStackSeanAllen()
  }
}

struct Platform: Hashable {
  let name: String
  let imageName: String
  let color: Color
}

struct Game: Hashable {
  let name: String
  let rating: String
}
