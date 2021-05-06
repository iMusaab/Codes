//
//  AddCodeView.swift
//  Codes
//
//  Created by Musab Aljarba on 18/09/1442 AH.
//

import SwiftUI

struct AddCodeView: View {
    @Environment(\.presentationMode) var presentaionMode
    @StateObject private var addCodeVM = AddCodeViewModel()
    @StateObject private var storeCodeListVM = StoreCodeListViewModel()
    
    @State private var storeCodeVS = StoreCodesViewState()
    
    @ObservedObject private var regesterVM = CreateUserViewModel()
    
    let store: StoreViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("Enter your code", text: $storeCodeVS.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter Description", text: $storeCodeVS.Description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                
                Button("Save") {
                    addCodeVM.addCodeToStore(storeId: store.storeId, storeCodeVS: storeCodeVS) { error in
                        if error == nil {
                            storeCodeVS = StoreCodesViewState()
                            storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                        }
                    }
                    
                    Text(addCodeVM.message)
                }
            }
        }
        .onChange(of: addCodeVM.saved) { value in
            if value {
                presentaionMode.wrappedValue.dismiss()
            }
        }
        .navigationBarItems(leading: Button(action: {
            presentaionMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        }))
        .navigationTitle("Add New Code")
        .embedInNavigationView()
    }
}

struct AddCodeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCodeView(store: StoreViewModel(store: Store(id: "", name: "", picture: "", codes: nil)))
    }
}

