//
//  PostDetailsView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 31/1/22.
//

import SwiftUI

struct PostDetailsView: View {
    @State var selectedPostList: [PostModel]
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(self.selectedPostList.indices, id: \.self) { userIndex in
                        let _ = print("ListView.....\(userIndex)")
                        
                        SelectedPostListRow(selectedPostList: $selectedPostList[userIndex])
                            .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("Selected Posts"), displayMode: .inline)
            }
        }
    }
}

struct SelectedPostListRow: View {
    @Binding var selectedPostList: PostModel
    @State var isListChecked: Bool = false
 
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("User ID: \(String(selectedPostList.userId))")
                        Spacer()
                        Text(String(selectedPostList.id))
                            .foregroundColor(Colors.lightGray)
                            .bold()
                    }
                    
                    Text("Title: \(selectedPostList.title)")
                    Text("Status: \(String(selectedPostList.completed))")
                }
                .padding(.leading, 8)
                
                Spacer()
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsView(selectedPostList: [PostModel]())
    }
}
