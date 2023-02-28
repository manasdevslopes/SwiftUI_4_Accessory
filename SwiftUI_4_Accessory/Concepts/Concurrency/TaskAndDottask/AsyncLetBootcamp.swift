//
//  AsyncLetBootcamp.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 28/02/23.
//

import SwiftUI

struct AsyncLetBootcamp: View {
  @State private var images: [UIImage] = []
  @State private var title: String = ""
  @State private var loading: Bool = false
  
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  let url = URL(string: "https://picsum.photos/300")!
  
  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(images, id: \.self) { image in
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
      .navigationTitle(title)
      .onAppear {
        Task {
          self.loading = true
          do {
            async let fetchImage1 = fetchImage()
            async let fetchTitle1 = fetchTitle()
            async let fetchImage2 = fetchImage()
            async let fetchImage3 = fetchImage()
            async let fetchImage4 = fetchImage()
            
            let (image1, title1, image2, image3, image4) = await (try fetchImage1, fetchTitle1, try fetchImage2, try fetchImage3, try fetchImage4)
            self.images.append(contentsOf: [image1, image2, image3, image4])
            self.title = title1
            self.loading = false
            
//            let image1 = try await fetchImage()
//            self.images.append(image1)
//
//            let image2 = try await fetchImage()
//            self.images.append(image2)
//
//            let image3 = try await fetchImage()
//            self.images.append(image3)
//
//            let image4 = try await fetchImage()
//            self.images.append(image4)
            
          } catch {
            
          }
        }
      }
    }
  }
  
  func fetchTitle() async -> String {
    return "Async Let Bootcamp 🥳"
  }
  
  func fetchImage() async throws -> UIImage {
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

struct AsyncLetBootcamp_Previews: PreviewProvider {
  static var previews: some View {
    AsyncLetBootcamp()
  }
}
