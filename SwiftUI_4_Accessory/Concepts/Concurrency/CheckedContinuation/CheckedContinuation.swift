//
//  CheckedContinuation.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 01/03/23.
//

import SwiftUI

class CheckedContinuationNetworkManager {
  func getData(url: URL) async throws -> Data {
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      return data
    } catch {
      throw error
    }
  }
  
  func getData2(url: URL) async throws -> Data {
    return try await withCheckedThrowingContinuation { continuation in
      URLSession.shared.dataTask(with: url) { data, response, error in
        if let data {
          continuation.resume(returning: data)
        } else if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(throwing: URLError(.badURL))
        }
      }.resume()
    }
  }
  
  func getHeartImageFromDatabase(completionHandler: @escaping (_ image: UIImage) -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      completionHandler(UIImage(systemName: "heart.fill")!)
    }
  }
  
  func getHeartImageFromDatabase() async -> UIImage {
    return await withCheckedContinuation { continuation in
      getHeartImageFromDatabase { image in
        continuation.resume(returning: image)
      }
    }
  }
}

class CheckedContinuationViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  let manager = CheckedContinuationNetworkManager()
  
  func getImage() async { 
    guard let url = URL(string: "https://picsum.photos/300") else { return }
    
    do {
      // let data = try await manager.getData(url: url)
      let data = try await manager.getData2(url: url)
      
      if let image = UIImage(data: data) {
        await MainActor.run(body: {
          self.image = image
        })
      }
    } catch {
      print(error)
    }
  }
  
  func getHeartImage() async {
    self.image = await manager.getHeartImageFromDatabase()
  }
}

struct CheckedContinuation: View {
  @StateObject private var vm = CheckedContinuationViewModel()
  
  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable().scaledToFit().frame(width: 200, height: 200)
          .clipShape(Circle())
          .overlay {
            Circle().stroke(.white, lineWidth: 5)
          }
          .shadow(color: .black.opacity(0.4), radius: 10)
      }
    }
    .task {
      // await vm.getImage()
      await vm.getHeartImage()
    }
  }
}

struct CheckedContinuation_Previews: PreviewProvider {
  static var previews: some View {
    CheckedContinuation()
  }
}
