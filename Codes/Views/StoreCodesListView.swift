//
//  StoreCodesListView.swift
//  Codes
//
//  Created by Musab Aljarba on 18/09/1442 AH.
//

import SwiftUI

struct StoreCodesListView: View {
    
    var store: StoreViewModel
    @StateObject private var storeCodeListVM = StoreCodeListViewModel()
    
    @State private var isPresented = false
    
    @ObservedObject private var regesterVM = CreateUserViewModel()
    
    @State private var isDisabled = false
    
    var body: some View {
        List {
            
            if storeCodeListVM.storeSpecialCode != [] {
                ForEach(storeCodeListVM.storeSpecialCode, id: \.storeCodeId) { specialCode in
                    VStack{
                    Text(specialCode.title)
                    Text(specialCode.Description)
                    }
                }
            }
            
            
            ForEach(Array(zip(storeCodeListVM.storeCodes, storeCodeListVM.enableVote)), id: \.0) { code, voteEnabled in
                HStack {
                    VStack{
                    Text(code.title)
                    Text(code.Description)
                    }
                    
                    Text("\(code.votes)")
                    
                    Spacer()
                    
                    HStack {
                        VStack {
                            Button(action: {
                                storeCodeListVM.updateCodeVotes(storeId: store.storeId, storeCodeId: code.storeCodeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "", upOrDown: .up)
                                storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                                storeCodeListVM.isDisabled = true
                            }, label: {
                                Image(systemName: "arrowtriangle.up.fill")
                            }).disabled(voteEnabled || storeCodeListVM.isDisabled)
                            
                            Spacer()
                            
                            Button(action: {
                                storeCodeListVM.updateCodeVotes(storeId: store.storeId, storeCodeId: code.storeCodeId, userId:regesterVM.defaults.string(forKey: "userId") ?? "", upOrDown: .down)
                                storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                                storeCodeListVM.isDisabled = true
                                                            }, label: {
                                Image(systemName: "arrowtriangle.down.fill")
                            }).disabled(voteEnabled || storeCodeListVM.isDisabled)
                            
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                
            }
            .onChange(of: storeCodeListVM.saved, perform: { value in
                if value {
                    storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                    
                }
                
            })
        }
        
        
        
        .sheet(isPresented: $isPresented, onDismiss: {
                storeCodeListVM.getStoreById(storeId: store.storeId
                )}, content: {
                    AddCodeView(store: store)
                })
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .onAppear(perform: {
            storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
            
            storeCodeListVM.getStoreSpecialCodeByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
            
        })
    }
    
    struct StoreCodesListView_Previews: PreviewProvider {
        static var previews: some View {
            StoreCodesListView(store: StoreViewModel(store: Store(id: "", name: "", picture: "", codes: nil)))
        }
    }
    
    
}
