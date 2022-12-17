//
//  Closures.swift
//  SwiftUI_4_Accessory
//  Closures are self-contained blocks of functionality that can be passed around and used in your code. In simple words - the functions that can be passed around.
//
//  Use @escaping when the closure needs to outlive the life of the function that called it.
//  
//  Created by MANAS VIJAYWARGIYA on 17/12/22.
//

import SwiftUI

struct Student {
  let name: String
  var testScore: Int
}

struct Closures: View {
  let students = [Student(name: "Manas", testScore: 88),
                  Student(name: "Ashi", testScore: 88),
                  Student(name: "Kanishk", testScore: 90),
                  Student(name: "Kalyani Di", testScore: 86),
                  Student(name: "Shikha", testScore: 80),
                  Student(name: "Riddhi", testScore: 78),
                  Student(name: "Nakul", testScore: 65)]
  
  // Closure
  var topStudentFilter: (Student) -> Bool = { student in
    return student.testScore >= 80
  }
  
  // Function
  func topStudentFilters(student: Student) -> Bool {
    return student.testScore >= 80
  }
  
  var body: some View {
    VStack {
      topStudentsList()
    }
  }
  
  @ViewBuilder
  func topStudentsList() -> some View {
    // let topStudents = students.filter(topStudentFilter)
    // let topStudents = students.filter { student in // trailing closure Syntax
      // return student.testScore >= 80
    // }
    let topStudents = students.filter { $0.testScore >= 80 }// Shorthand
    
    // let studentRanking = topStudents.sorted { student1, student2 in
      // return student1.testScore > student2.testScore
    // }
    let studentRanking = topStudents.sorted { $0.testScore > $1.testScore }
    
    // ForEach(topStudents, id:\.name) { topStudent in
      // Text(topStudent.name)
    // }
    ForEach(studentRanking, id:\.name) { topStudent in
      Text(topStudent.name)
    }
  }
}

struct Closures_Previews: PreviewProvider {
  static var previews: some View {
    Closures()
  }
}
