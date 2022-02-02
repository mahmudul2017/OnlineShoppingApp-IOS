//
//  PostView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 30/1/22.
//

import SwiftUI

struct PostUserView: View {
    @ObservedObject var viewModel = PostUserViewModel()
    @State private var showLoader: Bool = false
    @State var isErrorShowing: Bool = false
    
    var body: some View {
        ZStack(alignment: Alignment.bottomTrailing) {
            VStack {
                List {
                    ForEach(viewModel.userPostLists.indices, id: \.self) { userIndex in
                        let _ = print("ListView.....\(userIndex)")
                        
                        UserPostListRow(viewModel: self.viewModel, userPostLists: $viewModel.userPostLists[userIndex])
                            .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onReceive(self.viewModel.showLoader.receive(on: RunLoop.main)) { shouldShow in
                self.showLoader = shouldShow
            }
            
            VStack {
                UserSelectedPost(viewModel: self.viewModel, isErrorShowing: $isErrorShowing)
                    .padding(.trailing, 8)
            }
            
            if(isErrorShowing) {
                ErrorToast(message: "Please select a userID!")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation() {
                                self.isErrorShowing = false
                            }
                        }
                    }
                    .padding(.bottom, 32)
            }
            
            if self.showLoader {
                SpinLoaderView().zIndex(4)
            }
        }
    }
}

struct UserPostListRow: View {
    @ObservedObject var viewModel: PostUserViewModel
    @Binding var userPostLists: PostModel
    @State var isListChecked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    let _ = print("press at \(userPostLists.id)")
                }, label: {
                    Image(systemName: isListChecked ? "checkmark.circle.fill" : "checkmark.circle")
                        .resizable()
                        .padding(6)
                        .frame(width: 40, height: 40)
                })
                .onTapGesture {
                    viewModel.selectedItemList.append(userPostLists)
                    self.isListChecked.toggle()
                    let _ = print("press at Tab \(viewModel.selectedItemList)")
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("User ID: \(String(userPostLists.userId))")
                        Spacer()
                        Text(String(userPostLists.id))
                            .foregroundColor(Colors.lightGray)
                            .bold()
                    }
                    
                    Text("Title: \(userPostLists.title)")
                    Text("Status: \(String(userPostLists.completed))")
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

struct UserSelectedPost: View {
    @ObservedObject var viewModel: PostUserViewModel
    @Binding var isErrorShowing: Bool
    
    var body: some View {
        VStack {
            NavigationLink(destination: PostDetailsView(selectedPostList: viewModel.selectedItemList), isActive: $viewModel.isSelectedListCheck) {
                Text("")
            }
            Button(action: {
                SelectedItemPressed()
                let _ = print("SelectedItemPressed()")
            }, label: {
                Image(systemName: "paperplane.circle")
                    .resizable()
                    .padding(6)
                    .padding(.bottom, 6)
                    .foregroundColor(Color.black)
                    .frame(width: 48, height: 48, alignment: .bottomTrailing)
            })
            .onTapGesture {
                
            }
        }
    }
    
    private func SelectedItemPressed() {
        if self.viewModel.selectedItemList.count > 0 {
            self.viewModel.isSelectedListCheck = true
        } else {
            self.isErrorShowing = true
        }
    }
}

struct PostUserView_Previews: PreviewProvider {
    static var previews: some View {
        PostUserView()
    }
}
