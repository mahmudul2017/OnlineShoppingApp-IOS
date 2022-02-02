//
//  ContentView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 27/1/22.
//

import SwiftUI

struct DashBoardView: View {
    @ObservedObject var viewModel = DashBoardViewModel()
    @ObservedObject var commentViewModel = CommentViewModel()
    @ObservedObject var postUserViewModel = PostUserViewModel()
    @State private var isListChecked: Bool = false
    @State private var userListIndex: Int = 0
    @State private var selectItem: Int = 0
    @State private var selectOptions = ["Comments", "Posts"]
    @State var selectList = [Int]()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        if self.selectItem == 0 {
                            self.commentViewModel.refreshCommentApiCall()
                        } else {
                            self.postUserViewModel.refreshUserPostApiCall()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 18, weight: .light))
                            .imageScale(.large)
                            .accessibility(label: Text("Refresh"))
                            .foregroundColor(Colors.greenTheme)
                    }
                    .padding(.leading, 18)
                    Spacer()
                    Picker("", selection: self.$selectItem) {
                        ForEach(0 ..< self.selectOptions.count) {
                            Text(self.selectOptions[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200, alignment: .center)
                    //.padding(.leading, 64)
                    .padding(.trailing, 18)
                    Spacer()
                }
                
                if self.selectItem == 0 {
                    CommentView()
                } else if self.selectItem == 1 {
                    PostUserView()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}
