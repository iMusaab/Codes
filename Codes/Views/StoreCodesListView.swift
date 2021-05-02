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
    
    
    
    var body: some View {
        
        List {
            ForEach(storeCodeListVM.storeCodes, id: \.storeCodeId) { code in
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
                                storeCodeListVM.updateCodeVotes(storeId: store.storeId, storeCodeId: code.storeCodeId, upOrDown: .up)
                            }, label: {
                                Image(systemName: "arrowtriangle.up.fill")
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                storeCodeListVM.updateCodeVotes(storeId: store.storeId, storeCodeId: code.storeCodeId, upOrDown: .down)
                            }, label: {
                                Image(systemName: "arrowtriangle.down.fill")
                            })
                            
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                
            }
            .onChange(of: storeCodeListVM.saved, perform: { value in
                if value {
                    storeCodeListVM.getStoreById(storeId: store.storeId)
                }
                
                })
        }
        
        
        
        .sheet(isPresented: $isPresented, onDismiss: {
                storeCodeListVM.getStoreById(storeId: store.storeId
                )}, content: {
                    AddCodeView(store: store)
                })
        
        .embedInNavigationView()
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .onAppear(perform: {
                    storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId)
            
        })
        
    }
    
    struct StoreCodesListView_Previews: PreviewProvider {
        static var previews: some View {
            StoreCodesListView(store: StoreViewModel(store: Store(id: "", name: "", picture: "", codes: nil)))
        }
    }
}
