//
//  CartItemView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 13/2/22.
//

import SwiftUI

struct CartItemView: View {
    @ObservedObject var viewModel = CartViewModel()
    @State private var isPlaceOrder: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen,
             .font: UIFont.systemFont(ofSize: 28)]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue,
             .font: UIFont.systemFont(ofSize: 20)]
    }
    
    func placeOrder() {
        self.viewModel.isAlertDialog = true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Form {
                        Section(header: HStack {
                            Text("Order Catagory")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundColor(.green)
                        }) {
                            Picker(selection: $viewModel.type, label: Text("Select your item type")) {
                                ForEach(0 ..< CartViewModel.types.count) {
                                    Text(CartViewModel.types[$0]).tag($0)
                                }
                            }
                            
                            Stepper(value: $viewModel.quantity, in: 1...20) {
                                Text("Numbers of quantity: \(viewModel.quantity)")
                            }
                        }
                        
                        Section(header: HStack {
                            Text("Extra Order")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundColor(.green)
                        }) {
                            Toggle(isOn: $viewModel.extraItemOrder) {
                                Text("Add extra special item order")
                            }
                            
                            if viewModel.extraItemOrder {
                                Toggle(isOn: $viewModel.extraGiftItem) {
                                    Text("Add extra Gift Item")
                                }
                                Toggle(isOn: $viewModel.extraBookItem) {
                                    Text("Add extra Book Item")
                                }
                                Toggle(isOn: $viewModel.extraCandyItem) {
                                    Text("Add extra Candy Item")
                                }
                                Toggle(isOn: $viewModel.extraMedicineItem) {
                                    Text("Add extra Medicine Item")
                                }
                            }
                        }
                        //.textCase(nil)
                        
                        Section(header: HStack {
                            Text("Holder Information")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundColor(.green)
                        }) {
                            TextField("Name", text: $viewModel.name)
                            TextField("Address", text: $viewModel.address)
                        }
                        .textCase(nil)
                        
                        Section {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.placeOrder()
                                }, label: {
                                    Text("Place Order")
                                })
                                .disabled(!viewModel.isValid)
                                .alert(isPresented: $viewModel.isAlertDialog) {
                                    Alert(title: Text("Order Place!"), message: Text("Are you want to place order?"), primaryButton: .destructive(Text("Yes")) {
                                        self.isPlaceOrder = true
                                    }, secondaryButton: .cancel(Text("No")))
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                if self.isPlaceOrder {
                    let _ = print("order place: \(self.isPlaceOrder)")
                    SuccessToast(message: "Your order place successfully done!")
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    self.isPlaceOrder = false
                                }
                            }
                        }
                }
            }
            .navigationBarTitle(Text("Cart Item"))
        }
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView()
    }
}
