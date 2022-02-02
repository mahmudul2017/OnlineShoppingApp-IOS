//
//  WarningToast.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 31/1/22.
//

import Foundation
import SwiftUI

struct WarningToast: View {
    var message = ""
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Text(self.message)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 10)
            .padding(.top, 10)
            .background(Color.yellow)
            .cornerRadius(8)
            .shadow(radius: 8)
            .transition(.slide)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .padding(.bottom, 20)
        .padding(.top, 20)
    }
}

struct WarningToast_Previews: PreviewProvider {
    static var previews: some View {
        WarningToast()
    }
}
