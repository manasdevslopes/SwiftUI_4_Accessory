//
//  StructClassActorBootcamp.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 01/03/23.
//

import SwiftUI

struct StructClassActorBootcamp: View {
    var body: some View {
        Text("Hello, World!")
        .onAppear {
          actorTest1()
        }
    }
}

struct StructClassActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StructClassActorBootcamp()
    }
}

actor MyActor {
  var title: String
  
  init(title: String) {
    self.title = title
  }
  
  func updateTitle(newTitle: String) {
    title = newTitle
  }
}

extension StructClassActorBootcamp {
  private func actorTest1() {
    Task {
      let objectA = MyActor(title: "Starting title!")
      await print("ObjectA: ", objectA.title)
      
      print("Pass the REFERENCE of ObjectA to ObjectB")
      
      let objectB = objectA
      await print("ObjectB: ", objectB.title)
      
      await objectB.updateTitle(newTitle: "Second Title!")
      print("ObjectB title changed")
      
      await print("ObjectA: ", objectA.title)
      await print("ObjectB: ", objectB.title)
    }
  }
}

/// - Class & Actors both are REFERECE Types. Difference is actors required ASYNC Environment & when we want to access inside actors, we have to await it.
/// But Actors are thread safe - If we want to update any ppt of actor then directly we can't access and update. By creating a function inside actors & access that function to update the ppt of actor.

/*
VALUE TYPES :-
- Struct, Enum, Tuple, String, Int, Set, Dictionary, Array
- Stored in Stack
- Faster
- Thread safe
- When you assign or pass value type a new copy of data is created. (New Object always)


REFERENCE TYPES : -
- CLASS, Function, Closure, ACTOR
- Stored in HEAP
- Slower but synchronised.
- Not Thread Safe
- When you assign or pass reference type a new reference to original instance will be created. (Pointer) (Points to the same memory allocation)

------------------------------------
 
STACK : -
- Stores Value Types
- Variables allocated on the Stack are stored directly to the memory, and access to this memory is very fast
- Each Thread has it's own stack
 

HEAP : -
- Stores Reference Types
- Shared across Threads
 
------------------------------------

STRUCT : -
- Based on VALUES
- Can be mutated
- Stored in the stack
- By default init() is present

CLASS : -
- Based on REFERENCES (INSTANCES)
- Stored in the HEAP
- Inherit from other classes
- we need to init()
 
ACTOR : -
- Same as Class, but thread safe!
- Async environment
 
 
------------------------------------
 
USAGE
 
Structs - Data Models, Views
Classes - ViewModels
ACTORS - Shared 'Manager' and 'Data Store' (Netowrk Manager files in short)
 
 
*/
