//
//  PostViewModel.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 30/1/22.
//

import Foundation
import Combine

class PostUserViewModel: ObservableObject {
    private var userDetailsSubscriber: AnyCancellable? = nil
    var showLoader = PassthroughSubject<Bool, Never>()
    @Published var userPostLists = [PostModel]()
    @Published var userSelectedItem: Int = 0
    @Published var selectedItemList = [PostModel]()
    @Published var selectedAllPostList = [PostModel]()
    @Published var isSelectedListCheck = false
    
    init() {
        getUserPostDetailsStatus()
    }
    
    func getUserSelectItemPost() -> [PostModel] {
        print("...... getUserSelectItemPost vm: \(self.selectedItemList)")
        self.selectedAllPostList.append(contentsOf: self.selectedItemList)
        return self.selectedAllPostList
    }
    
    func getUserSelectedItem() {
        if userPostLists.count > 0 {
            for item in 1..<(self.userPostLists.count) {
                if userSelectedItem < userPostLists[item].id {
                    //userDetailsLists[item].id = 22
                }
            }
        }
        print("...... vm: \(userPostLists)")
    }
    
    // MARK: - UserListDetailsApiCall
    func getUserPostDetailsStatus() {
        self.userDetailsSubscriber = self.getUserPostDetailsPublisher()?.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }, receiveValue: { response in
            if response.count > 0 {
                self.userPostLists.removeAll()
                self.userPostLists.append(contentsOf: response)
            }
            self.objectWillChange.send()
        })
    }
    
    func getUserPostDetailsPublisher() -> AnyPublisher<[PostModel], Error>? {
        guard let urlComponents = URLComponents(string: ApiService.webBaseUrl + "todos") else {
                print("Problem with URLComponent creation...")
                return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = getCommonUrlRequest(url: url)
        request.httpMethod = "GET"
        print(request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .handleEvents(receiveSubscription: { _ in
                self.showLoader.send(true)
                print("receiveSubscription")
            }, receiveOutput: { _ in
                self.showLoader.send(false)
                print("receiveOutput")
            }, receiveCompletion: { _ in
                self.showLoader.send(false)
                print("receiveCompletion")
            }, receiveCancel: {
                self.showLoader.send(false)
                print("receiveCancel")
            })
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("error 200")
                    throw ApiService.APIFailureCondition.InvalidServerResponse
                }
                return data
        }
        .retry(1)
        .decode(type: [PostModel].self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    // MARK: - RefreshUserPostCall()
    func refreshUserPostApiCall() {
        showLoader.send(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getUserPostDetailsStatus()
        }
    }
}
