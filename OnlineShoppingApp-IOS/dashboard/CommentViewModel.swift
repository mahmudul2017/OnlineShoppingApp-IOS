//
//  CommentViewModel.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 30/1/22.
//

import Foundation
import Combine

class CommentViewModel: ObservableObject {
    private var commentDetailsSubscriber: AnyCancellable? = nil
    var showLoader = PassthroughSubject<Bool, Never>()
    @Published var userCommentLists = [CommentModel]()
    @Published var userSelectedItem: Int = 0
    @Published var userCommentPrice = [Int]()
    @Published var userCommentSumPrice: Int = 0
    @Published var commentRandomNumbers: [Int] = []
    
    init() {
        self.getCommentDetailsStatus()
    }
    
    deinit {
        commentDetailsSubscriber?.cancel()
    }
    
    func getCommentRandomNumber() {
        if userCommentLists.count > 0 {
            for _ in 0..<(self.userCommentLists.count) {
                let randomIntNumber = Int.random(in: 1...10)
                self.commentRandomNumbers.append(randomIntNumber)
            }
        }
        print("random number: \(self.commentRandomNumbers)")
    }
 
    func getCommentSelectedItem() {
        if userCommentLists.count > 0 {
            userCommentPrice.removeAll()
            for item in 0..<(self.userCommentLists.count) {
                if userSelectedItem <= userCommentLists[item].id {
                    //userCommentLists[item].id = 22
                    userCommentPrice.append(commentRandomNumbers[item])
                }
            }
            print("random number List 1: \(userCommentPrice)")
            // MARK: - ListOfPriceSum()
            userCommentSumPrice = userCommentPrice.reduce(0, +)
        }
        print("getCommentSelectedItem: \(userCommentLists)")
    }
    
    func getCommentUnSelectedItem() {
        if userCommentLists.count > 0 {
            userCommentPrice.removeAll()
            for item in 0..<(self.userCommentLists.count) {
                if userSelectedItem > userCommentLists[item].id {
                    //userCommentLists[item].id = 11
                    userCommentPrice.append(commentRandomNumbers[item])
                }
            }
            print("random number List 2: \(userCommentPrice)")
            // MARK: - ListOfPriceSum()
            userCommentSumPrice = userCommentPrice.reduce(0, +)
        }
        print("getCommentUnSelectedItem: \(userCommentLists)")
    }
    
    // MARK: - UserListDetailsApiCall
    func getCommentDetailsStatus() {
        self.commentDetailsSubscriber = self.getCommentDetailsPublisher()?.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }, receiveValue: { response in
            print("commentLists --- \(response)")
            if response.count > 0 {
                self.userCommentLists.removeAll()
                self.userCommentLists.append(contentsOf: response)
                self.userSelectedItem = self.userCommentLists.count + 1
                // MARK: - RandomNumberCall
                self.getCommentRandomNumber()
            }
        })
    }
    
    func getCommentDetailsPublisher() -> AnyPublisher<[CommentModel], Error>? {
        guard let urlComponents = URLComponents(string: ApiService.webBaseUrl + "users") else {
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
        .decode(type: [CommentModel].self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    // MARK: - RefreshCommentCall()
    func refreshCommentApiCall() {
        showLoader.send(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //self.userCommentSumPrice = 0
            //self.userSelectedItem = 0
            //self.userCommentPrice = []
            self.getCommentDetailsStatus()
        }
    }
}
