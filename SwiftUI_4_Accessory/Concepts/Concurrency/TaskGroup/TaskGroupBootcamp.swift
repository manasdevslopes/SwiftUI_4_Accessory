//
//  TaskGroupBootcamp.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 01/03/23.
//

import SwiftUI

class TaskGroupBootcampDataManager {
  let url = "https://picsum.photos/300"
  func fetchImagesWithAsyncLet() async throws -> [UIImage] {
    async let fetchImage1 = fetchImage(urlString: url)
    async let fetchImage2 = fetchImage(urlString: url)
    async let fetchImage3 = fetchImage(urlString: url)
    async let fetchImage4 = fetchImage(urlString: url)
    
    let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
    return [image1, image2, image3, image4]
  }
  
//  func fetchImagesWithTaskGroup() async throws -> [UIImage] {
//    return try await withThrowingTaskGroup(of: UIImage.self) { group in
//      var images: [UIImage] = []
//
//      /// - Adding Child Tasks to the Group
//      group.addTask {
//        try await self.fetchImage(urlString: "https://picsum.photos/300")
//      }
//      group.addTask {
//        try await self.fetchImage(urlString: "https://picsum.photos/300")
//      }
//      group.addTask {
//        try await self.fetchImage(urlString: "https://picsum.photos/300")
//      }
//      group.addTask {
//        try await self.fetchImage(urlString: "https://picsum.photos/300")
//      }
//
//      for try await image in group {
//        images.append(image)
//      }
//
//      return images
//    }
//  }
  
  /// - Or in simple way. Modifying above function as follows. If there are more calls
  func fetchImagesWithTaskGroup() async throws -> [UIImage] {
    let urlStrings = [
      "https://picsum.photos/300","https://picsum.photos/300","https://picsum.photos/300",
      "https://picsum.photos/300","https://picsum.photos/300"
    ]
    return try await withThrowingTaskGroup(of: UIImage?.self) { group in
      var images: [UIImage] = []
      images.reserveCapacity(urlStrings.count)
      
      for urlString in urlStrings {
        /// - Adding Child Tasks to the Group
        group.addTask {
          /// - Optional try becoz if some image download fails, then also others should work.
          try? await self.fetchImage(urlString: urlString)
        }
      }
      
      for try await image in group {
        if let image {
          images.append(image)
        }
      }
      
      return images
    }
  }
  
  private func fetchImage(urlString: String) async throws -> UIImage {
    guard let url = URL(string: urlString) else {
      throw URLError(.badURL)
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let image = UIImage(data: data) {
        return image
      } else {
        throw URLError(.badURL)
      }
    } catch {
      throw error
    }
  }
  
}

class TaskGroupBootcampViewModel: ObservableObject {
  @Published var images: [UIImage] = []
  let manager = TaskGroupBootcampDataManager()
  
  func getImages() async {
//    if let images = try? await manager.fetchImagesWithAsyncLet() {
//      self.images.append(contentsOf: images)
//    }
    
    if let images = try? await manager.fetchImagesWithTaskGroup() {
      self.images.append(contentsOf: images)
    }
  }
}

struct TaskGroupBootcamp: View {
  @StateObject private var vm = TaskGroupBootcampViewModel()
  
  @State private var title: String = ""
  @State private var loading: Bool = false
  
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  let url = URL(string: "https://picsum.photos/300")!
  
  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(vm.images, id: \.self) { image in
            Image(uiImage: image)
              .resizable().scaledToFit().frame(height: 150)
          }
        }
      }
      .overlay {
        if loading {
          VStack {
            ProgressView()
          }
          .frame(width: 50, height: 50)
          .background(.white)
          .clipShape(Circle())
          .shadow(color: .black.opacity(0.4), radius: 10)
        }
      }
      .navigationTitle("Task Group 🥳")
      .task {
        await vm.getImages()
      }
    }
  }
}

struct TaskGroupBootcamp_Previews: PreviewProvider {
  static var previews: some View {
    TaskGroupBootcamp()
  }
}
