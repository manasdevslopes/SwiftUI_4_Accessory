//
//  TaskAndDottask.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 28/02/23.
//

import SwiftUI

class TaskAndDottaskViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  @Published var image2: UIImage? = nil
  
  func fetchImage() async {
    try? await Task.sleep(nanoseconds: 5_000_000_000)
    do {
      guard let url = URL(string: "https://picsum.photos/1000") else { return }
      let (data, _) = try await URLSession.shared.data(from: url)
      await MainActor.run(body: {
        self.image = UIImage(data: data)
        print("Image Returned")
      })
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func fetchImage2() async {
    do {
      guard let url = URL(string: "https://picsum.photos/1000") else { return }
      let (data, _) = try await URLSession.shared.data(from: url)
      await MainActor.run(body: {
        self.image2 = UIImage(data: data)
        print("Image2 Returned")
      })
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct TaskAndDottaskHomeView: View {
  var body: some View {
    NavigationStack {
      ZStack {
        NavigationLink {
          TaskAndDottask()
        } label: {
          Label("Tap Me", systemImage: "globe")
        }
      }
    }
  }
}

struct TaskAndDottask: View {
  @StateObject private var vm = TaskAndDottaskViewModel()
  @State private var fetchImageTask: Task<(), Never>? = nil /// - 1st step
  
  var body: some View {
    VStack(spacing: 40) {
      if let image = vm.image {
        ImageView(image: image)
      }
      
      if let image2 = vm.image2 {
        ImageView(image: image2)
      }
    }
    /// - alternate to all three steps in 1 step
    .task {
      await vm.fetchImage()
      await vm.fetchImage2()
    }
    /// - 3rd step
//    .onDisappear {
//      fetchImageTask?.cancel()
//    }
    
    /// - 2nd step
//    .onAppear {
//      fetchImageTask = Task { /// - This one in 2nd step
//        await vm.fetchImage()
//      }
//      Task {
//        await vm.fetchImage2()
//      }
//
////      Task {
////        print(Thread.current)
////        print(Task.currentPriority)
////        await vm.fetchImage()
////      }
////      Task {
////        print(Thread.current)
////        print(Task.currentPriority)
////        await vm.fetchImage2()
////      }
//
//      /// - Both Outer & Inner give different priority
////      Task(priority: .userInitiated) {
////        print("UserInitiated: \(Thread.current) : \(Task.currentPriority)")
////
////        /// - Acc. to Apple's Docs, we should ignore writing this detached if possible.
////        Task.detached { /// - in detached , we can also give priority
////          print("UserInitiated: \(Thread.current) : \(Task.currentPriority)")
////        }
////      }
//
//      /// - Both Outer & Inner Tasks give same priority.
////      Task(priority: .userInitiated) {
////        print("UserInitiated: \(Thread.current) : \(Task.currentPriority)")
////
////        /// - This task inherites from parent Task
////        Task {
////          print("UserInitiated: \(Thread.current) : \(Task.currentPriority)")
////        }
////      }
//
//
////      Task(priority: .high) {
////        await Task.yield()
////        print("High: \(Thread.current) : \(Task.currentPriority)")
////      }
////      Task(priority: .userInitiated) {
////        print("UserInitiated: \(Thread.current) : \(Task.currentPriority)")
////      }
////      Task(priority: .medium) {
////        print("Medium: \(Thread.current) : \(Task.currentPriority)")
////      }
////      Task(priority: .low) {
////        print("Low: \(Thread.current) : \(Task.currentPriority)")
////      }
////      Task(priority: .utility) {
////        print("Utility: \(Thread.current) : \(Task.currentPriority)")
////      }
////      Task(priority: .background) {
////        print("Background: \(Thread.current) : \(Task.currentPriority)")
////      }
//
////      Task {
////        await vm.fetchImage()
////        await vm.fetchImage2()
////      }
//    }
  }
}

extension TaskAndDottask {
  @ViewBuilder
  private func ImageView(image: UIImage) -> some View {
    Image(uiImage: image)
      .resizable().scaledToFit().frame(width: 200, height: 200)
      .clipShape(Circle())
      .overlay {
        Circle().stroke(.white, lineWidth: 5)
      }
      .shadow(color: .black.opacity(0.4), radius: 10)
  }
}
struct TaskAndDottask_Previews: PreviewProvider {
  static var previews: some View {
    TaskAndDottaskHomeView()
  }
}
