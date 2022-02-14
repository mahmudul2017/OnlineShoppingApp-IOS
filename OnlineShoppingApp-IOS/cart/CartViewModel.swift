//
//  CartViewModel.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 13/2/22.
//

import Foundation
import Combine
import SwiftUI

class CartViewModel: ObservableObject {
    init() {
        print("cartViewModel called....")
    }
    
    var didChange = PassthroughSubject<Void, Never>()
    static let types = ["Bookstores", "Pharmacies", "Giftshops", "Candyshops"]
    @Published var type = 0 { didSet { update() } }
    @Published var quantity = 1 { didSet { update() } }
    @Published var extraItemOrder = false { didSet { update() } }
    @Published var extraBookItem = false { didSet { update() } }
    @Published var extraGiftItem = false { didSet { update() } }
    @Published var extraCandyItem = false { didSet { update() } }
    @Published var extraMedicineItem = false { didSet { update() } }
    @Published var name = "" { didSet { update() } }
    @Published var address = "" { didSet { update() } }
    @Published var isAlertDialog = false { didSet { update() } }
    var isValid: Bool {
        if name.isEmpty || address.isEmpty {
            return false
        }
        return true
    }
    
    func update() {
        didChange.send(())
    }
}
