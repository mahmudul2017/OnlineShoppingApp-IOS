//
//  DashBoardModel.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 27/1/22.
//

import Foundation

// MARK: - UserCommentModel
struct CommentModel: Codable, Identifiable {
    var id: Int
    let name, username, email: String
    //let address: Address
    let phone, website: String
    //let company: Company
}
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}
struct Geo: Codable {
    let lat, lng: String
}
struct Company: Codable {
    let name, catchPhrase, bs: String
}

// MARK: - UserPostModel
struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
