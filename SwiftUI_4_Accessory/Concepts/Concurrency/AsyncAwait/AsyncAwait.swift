//
//  AsyncAwait.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 28/02/23.
//

import SwiftUI

class DownloadImageAsyncImageLoader {
  let url = URL(string: "https://picsum.photos/200")!
  
  func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
    guard let data = data, let image = UIImage(data: data),
          let response = response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
      return nil
    }
    return image
  }
  
  func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?)->()) {
    URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
      let image = self?.handleResponse(data: data, response: response)
      completionHandler(image, error)
    }
    .resume()
  }
  
  func downloadWithAsync() async throws -> UIImage? {
    do {
      let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
      return handleResponse(data: data, response: response)
    } catch {
      throw error
    }
  }
}

class AsyncAwaitViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  let loader = DownloadImageAsyncImageLoader()
  
  func fetchImage() async {
    /*
    loader.downloadWithEscaping { [weak self] image, error in
      DispatchQueue.main.async {
        self?.image = image
      }
    }
    */
    
    let image = try? await loader.downloadWithAsync()
    await MainActor.run {
      self.image = image
    }
  }
}

struct AsyncAwait: View {
  @StateObject private var vm = AsyncAwaitViewModel()
  
  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable().scaledToFit().frame(width: 250, height: 250)
      }
    }
    .onAppear {
      Task {
        await vm.fetchImage()
      }
    }
  }
}

struct AsyncAwait_Previews: PreviewProvider {
  static var previews: some View {
    AsyncAwait()
  }
}
