//
//  CommentView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 30/1/22.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var viewModel = CommentViewModel()
    @State private var isListChecked: Bool = false
    @State private var showLoader: Bool = false
    @State private var userListIndex: Int = 0
    @State var selectList = [Int]()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                dashItemView
                    .padding(.leading, 16)
                
                let _ = print("userSelectedItem: \(self.viewModel.userSelectedItem)")
                HStack {
                    Spacer()
                    Text("Total Price \(String(self.viewModel.userCommentSumPrice))")
                        .foregroundColor(.blue)
                        .bold()
                        .padding(.trailing, 16)
                    Spacer()
                }
                
                List {
                    ForEach(viewModel.userCommentLists.indices, id: \.self) { userIndex in
                        let _ = print("ListView...\(viewModel.commentRandomNumbers)")
                        let commentIndex = userIndex + 1
                        
                        UserCommentListRow(viewModel: self.viewModel, usercommentLists: $viewModel.userCommentLists[userIndex], randomIntNumber: $viewModel.commentRandomNumbers[userIndex], isListChecked: $isListChecked, commentIndex: commentIndex)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onReceive(self.viewModel.showLoader.receive(on: RunLoop.main)) { shouldShow in
                self.showLoader = shouldShow
                print("showLoader - \(shouldShow)")
            }
            
            if self.showLoader {
                SpinLoaderView()
            }
        }
    }
    
    var dashItemView: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            HStack {
                Image("profile_avater")
                    .resizable()
                    .padding(6)
                    .frame(width: 40, height: 40)
                
                VStack {
                    Text("Md. Mahmudul Hasan")
                        .font(.system(size: 18))
                        .bold()
                }
            }
        }
    }
}

struct UserCommentListRow: View {
    @ObservedObject var viewModel: CommentViewModel
    @Binding var usercommentLists: CommentModel
    @Binding var randomIntNumber: Int
    @Binding var isListChecked: Bool
    @State var isFirstChecked: Bool = false
    var commentIndex: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: viewModel.userSelectedItem <= usercommentLists.id ? "checkmark.circle.fill" : "checkmark.circle")
                            .resizable()
                            .padding(6)
                            .frame(width: 40, height: 40)
                    })
                    .onTapGesture {
                        self.isListChecked.toggle()
                        self.isFirstChecked.toggle()
                        
                        if self.isListChecked {
                            if usercommentLists.id <= viewModel.userCommentLists.count {
                                viewModel.userSelectedItem = usercommentLists.id
                                viewModel.getCommentSelectedItem()
                                print("1 \(self.isListChecked) \(usercommentLists.id)")
                            } else {
                                viewModel.userSelectedItem = usercommentLists.id + 1
                                viewModel.getCommentSelectedItem()
                                print("2 \(!self.isListChecked) \(usercommentLists.id)")
                            }
                        } else {
                            if usercommentLists.id < viewModel.userCommentLists.count {
                                viewModel.userSelectedItem = usercommentLists.id
                                viewModel.getCommentSelectedItem()
                                print("3 \(self.isListChecked) \(usercommentLists.id)")
                            } else {
                                viewModel.userSelectedItem = usercommentLists.id + 1
                                viewModel.getCommentSelectedItem()
                                print("4 \(!self.isListChecked) \(usercommentLists.id)")
                            }
                        }
                        
                        //                        if self.isListChecked || usercommentLists.id < 22{
                        //                            viewModel.userSelectedItem = usercommentLists.id
                        //                            viewModel.getCommentSelectedItem()
                        //                            print("1 \(self.isListChecked) \(usercommentLists.id)")
                        //                            //self.isListChecked = false
                        //                        }
                        //                        if !self.isListChecked || usercommentLists.id < 22{
                        //                            viewModel.userSelectedItem = usercommentLists.id
                        //                            viewModel.getCommentSelectedItem()
                        //                            print("2 \(!self.isListChecked) \(usercommentLists.id)")
                        //                            //self.isListChecked = false
                        //                        }
                        //                        if !self.isListChecked || usercommentLists.id == 22 {
                        //                            viewModel.userSelectedItem = usercommentLists.id
                        //                            viewModel.getCommentUnSelectedItem()
                        //                            print("3 \(!self.isListChecked) \(usercommentLists.id)")
                        //                            //self.isListChecked = true
                        //                        }
                        
                        if self.isFirstChecked {
                            //self.isListChecked = false
                            //self.viewModel.userCommentSumPrice = 1
                        }
                        
                        if !self.isFirstChecked {
                            //self.viewModel.userCommentSumPrice = 2
                        }
                        let _ = print("press at Tab \(usercommentLists.id)")
                    }
                    Text(String(randomIntNumber))
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Name: \(usercommentLists.name)")
                        Spacer()
                        Text(String(commentIndex))
                            .foregroundColor(Colors.lightGray)
                            .bold()
                    }
                    Text("Email: \(usercommentLists.email)")
                    Text("Phone: \(usercommentLists.phone)")
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

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
