//
//  CheckBoxRow.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 27/1/22.
//

import SwiftUI

struct CheckBoxRow: View {
    @State var checkState:Bool = false
    
    var body: some View {
        Button(action: {
            //1. Save state
            self.checkState = !self.checkState
            print("State : \(self.checkState)")
        }) {
            HStack(alignment: .top, spacing: 10) {
                
                //2. Will update according to state
                Image(systemName: self.checkState ? "checkmark.circle.fill" : "checkmark.circle")
                
                Rectangle()
                    .fill(self.checkState ? Color.green : Color.red)
                    .frame(width:20, height:20, alignment: .center)
                    .cornerRadius(5)
                
                Text("Todo  item ")
            }
        }
        .foregroundColor(Color.white)
    }
}

struct CheckBoxRow_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxRow()
    }
}
