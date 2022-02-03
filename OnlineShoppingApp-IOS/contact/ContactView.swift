//
//  ContactView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 27/1/22.
//

import SwiftUI
import Combine

struct ContactView: View {
    var callPassThroughtSubject = CallPassThroughtSubject()
    @State private var phoneNumber: String?
    
    var body: some View {
        VStack {
            Text("Phone No: \(phoneNumber ?? "Contact Us")")
            
            Button(action: {
                self.callPassThroughtSubject.getPhoneNumber()
            }, label: {
                Text("Phone Number")
            })
        }
        .onReceive(self.callPassThroughtSubject.callNumberChange, perform: { phoneNo in
            self.phoneNumber = nil
            self.phoneNumber = phoneNo
        })
    }
}

struct CallPassThroughtSubject {
    var callNumberChange = PassthroughSubject<String, Never>()
    
    func getPhoneNumber() {
        callNumberChange.send("01313-350895")
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
