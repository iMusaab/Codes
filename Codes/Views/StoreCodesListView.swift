//
//  StoreCodesListView.swift
//  Codes
//
//  Created by Musab Aljarba on 18/09/1442 AH.
//

import SwiftUI
import MobileCoreServices

struct StoreCodesListView: View {
    
    
    
    var store: StoreViewModel
    @StateObject private var storeCodeListVM = StoreCodeListViewModel()
    
    @State private var isPresented = false
    
    @ObservedObject private var regesterVM = CreateUserViewModel()
    
//    @StateObject private var isDisabled = false
    
    @State private var showHUD = false
    
    let pasteboard = UIPasteboard.general
    
    
    
    
    var body: some View {
        
        
        ZStack(alignment: .top) {
            
            
            
                ScrollView {
                    LazyVStack {
                        
                        if storeCodeListVM.storeSpecialCode != [] {
                            
                            ForEach(storeCodeListVM.storeSpecialCode, id: \.storeCodeId) { specialCode in
                                SpecialStoreCell(specialCode: specialCode, showHUD: $showHUD)
                            }
                            .padding(.top, 20)
                        }
                        
                        
                        ForEach(Array(zip(storeCodeListVM.storeCodes, storeCodeListVM.enableVote)), id: \.0) { code, voteEnabled in
                           
                            normalCodeCell(voteEnabled: voteEnabled, code: code, showHUD: $showHUD, storeCodeListVM: storeCodeListVM, store: store)
                        }
                        
                        .onChange(of: storeCodeListVM.voteSaved, perform: { value in
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
                    
                    .navigationBarTitle(store.name).navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button(action: {
                        isPresented = true
                    }, label: {
                        AddButton()
                    }))
                    .onAppear(perform: {
                        UITabBar.appearance().tintColor = .black
                        
                        storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                        
                        storeCodeListVM.getStoreSpecialCodeByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                        
                    })
                }
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9215686275, green: 0.9294117647, blue: 0.9215686275, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 300)
                            .ignoresSafeArea(.all)
                        Spacer()
                            
                    })
            HUD()
                .offset(y: showHUD ? -10: -150)
                .animation(.easeOut)
        }
    }
    
    struct StoreCodesListView_Previews: PreviewProvider {
        static var previews: some View {
            StoreCodesListView(store: StoreViewModel(store: Store(id: "", name: "thr", picture: "hungerPic", codes: nil)))
        }
    }
    
    
}


