//
//  Model.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/03/23.
//

import SwiftUI

class Model: ObservableObject {
  @Published var pets: [Pet]
  
  /// Creates a new model object with the given set of pets.
  init(pets: [Pet]) {
    self.pets = pets
  }
  
  /// The sum of all votes across all pets.
  var totalVotes: Int { pets.reduce(0) { $0 + $1.votes } }
  
  /// A Boolean value that indicates whether all the pets have the same
  /// number of votes.
  var isAllWayTie: Bool {
    pets.allSatisfy { $0.votes == pets.first?.votes }
  }
  
  /// Calculates the rank of the specified pet.
  ///
  /// Because this method calculates the rank as the number of pets that have
  /// more votes than the specified pet, pets with the same number of votes
  /// have the same rank, resulting in a tie.
  func rank(_ pet: Pet) -> Int {
    pets.reduce(1) { $0 + (($1.votes > pet.votes) ? 1 : 0) }
  }
}

extension Model {
  /// A model instance to use for running the app, starting with zero votes
  /// for each contender.
  static var startData: Model = Model(pets: [
    Pet(type: "Cat", color: .orange),
    Pet(type: "Goldfish", color: .yellow),
    Pet(type: "Dog", color: .brown)
  ])
  
  /// A model instance to use for previews.
  ///
  /// This preview data assigns each pet the number of votes that matches its
  /// index to ensure that the preview looks the same all the time.
  /// If you prefer random data, use something like the following instead:
  ///
  /// ```swift
  /// model.pets[index].votes = Int.random(in: 0...100)
  /// ```
  static var previewData: Model {
    let model = startData
    for index in model.pets.indices {
      model.pets[index].votes = index
    }
    return model
  }
}
