//
//  DependencyInjection.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 06/03/23.
//

import SwiftUI
import Combine

// PROBLEMS WITH SINGLETONS: -
// 1. Singleton's are Global. It can accessible from Any where from app (Vm, View, normal class, or even outside the struct/class)
// This singleton's accessed from a bunch of different places in ur app at the same time. This could lead to big problems. If maybe we are using multithreaded environment so we're doing different tasks on different threads and those diff threads are trying to access the same instances at the same time, this could create bunch of crashes in the app.
// 2. Can't customize the init() {}
// 3. Can'r swap out dependencies

struct PostsModel: Identifiable, Codable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

protocol DataServiceProtocol {
  func getData() ->  AnyPublisher<[PostsModel], Error>
}

class ProductionDataService: DataServiceProtocol {  
  let url: URL
  
  init(url: URL) {
    self.url = url
  }
  
  func getData() ->  AnyPublisher<[PostsModel], Error> {
    URLSession.shared.dataTaskPublisher(for: url)
      .map({ $0.data })
      .decode(type: [PostsModel].self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}

class MockDataService: DataServiceProtocol {
  let testData: [PostsModel]
  
  init(data: [PostsModel]?) {
    self.testData = data ?? [
      PostsModel(userId: 1, id: 1, title: "One", body: "one"),
      PostsModel(userId: 2, id: 2, title: "Two", body: "two")
    ]
  }
  
  func getData() -> AnyPublisher<[PostsModel], Error> {
    Just(testData)
      .tryMap({ $0 })
      .eraseToAnyPublisher()
  }
}

class DependencyInjectionViewModel: ObservableObject {
  @Published var dataArray: [PostsModel] = []
  var cancellables = Set<AnyCancellable>()
  
  let dataService: DataServiceProtocol
  
  init(dataService: DataServiceProtocol) {
    self.dataService = dataService
    loadPosts()
  }
  
  private func loadPosts() {
    dataService.getData()
      .sink { _ in
        
      } receiveValue: { [weak self] returnedPosts in
        self?.dataArray = returnedPosts
      }
      .store(in: &cancellables)
  }
}

struct DependencyInjection: View {
  @StateObject private var vm: DependencyInjectionViewModel
  
  init(dataService: DataServiceProtocol) {
    _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
  }
  
  var body: some View {
    ScrollView {
      VStack {
        ForEach(vm.dataArray) { post in
          Text("\(post.title)")
        }
      }
    }
  }
}

struct DependencyInjection_Previews: PreviewProvider {
//  static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
  static let dataService = MockDataService(data: nil)
  
  static var previews: some View {
    DependencyInjection(dataService: dataService)
  }
}
