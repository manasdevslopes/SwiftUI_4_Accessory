//
//  Expense.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 18/01/23.
//

import Foundation

struct Expense: Identifiable {
  var id: UUID = .init()
  var amountSpent: String
  var product: String
  var productIcon: String
  var spendType: String
}

var expenses: [Expense] = [
  Expense(amountSpent: "$128", product: "Amazon", productIcon: "Amazon", spendType: "Groceries"),
  Expense(amountSpent: "$18", product: "YouTube", productIcon: "YouTube", spendType: "Streaming"),
  Expense(amountSpent: "$10", product: "Dribble", productIcon: "Dribble", spendType: "Membership"),
  Expense(amountSpent: "$28", product: "Netflix", productIcon: "Netflix", spendType: "Movies"),
  Expense(amountSpent: "$9", product: "Patreon", productIcon: "Patreon", spendType: "Membership"),
  Expense(amountSpent: "$108", product: "Instagram", productIcon: "Instagram", spendType: "Reels"),
  Expense(amountSpent: "$55", product: "Photoshop", productIcon: "Photoshop", spendType: "Editing"),
  Expense(amountSpent: "$348", product: "Apple", productIcon: "Apple", spendType: "Apple Pay"),
  Expense(amountSpent: "$99", product: "Figma", productIcon: "Figma", spendType: "Pro Member"),
]
