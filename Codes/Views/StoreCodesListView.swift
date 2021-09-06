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
    
    @State private var showingAlert = false
    
    let pasteboard = UIPasteboard.general
    
    @State var newCodeSaved = false
    
    @Binding var isSearching: Bool
    
    var codesArraysAreEmpty: Bool {
//        return false
        if storeCodeListVM.normalCodeSaved && storeCodeListVM.specialCodeSaved {
            return storeCodeListVM.storeSpecialCode.isEmpty && storeCodeListVM.storeCodes.isEmpty
        }
            
        return false
    }
    
    
    
    
    
    var body: some View {
        
        
        ZStack(alignment: .top) {
            
            
            
                ScrollView {
                    
                    LazyVStack {
                        
                        
                        if !storeCodeListVM.normalCodeSaved || !storeCodeListVM.specialCodeSaved {
                            
                            VStack {
                                HStack(alignment: .center) {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                }
                            }
                        }
                        
                        if codesArraysAreEmpty {
                            Text("لم يتم إضافة اي كوبونات لهذا المتجر")
                                .padding(.top, 100)
                        }
                        
                        if storeCodeListVM.storeSpecialCode != [] {
                            
                            ForEach(storeCodeListVM.storeSpecialCode, id: \.storeCodeId) { specialCode in
                                SpecialStoreCell(specialCode: specialCode, showHUD: $showHUD)
                            }
//                            .padding(.top, 20)
                        }
                        
                        
                        ForEach(Array(zip(storeCodeListVM.storeCodes, storeCodeListVM.enableVote)), id: \.0) { code, voteEnabled in
                           
                            normalCodeCell(voteEnabled: voteEnabled, code: code, showHUD: $showHUD, storeCodeListVM: storeCodeListVM, store: store)
                        }
//                        .padding(.top, storeCodeListVM.storeSpecialCode != [] ? 0 : 20)
                        .onChange(of: storeCodeListVM.voteSaved, perform: { value in
                            if value {
                                storeCodeListVM.getStoreCodesByStoreId(storeId: store.id, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                            }
                        })
                        .animation(.default)
                        
                    }
                    .padding(.top, 20)
                    .sheet(isPresented: $isPresented, onDismiss: {
                            storeCodeListVM.getStoreById(storeId: store.id)
                        if newCodeSaved {
                                                         showingAlert = true
                            newCodeSaved = false
                        }
                                                         
                            }, content: {
                                AddCodeView(store: store, newCodeSaved: $newCodeSaved)
                            })
                    .alert(isPresented: $showingAlert) {
                                Alert(title: Text("شكرا لك ❤️"), message: Text("تم إرسال الكوبون بنجاح .. يتم مراجعة الكوبونات قبل إضافتها."), dismissButton: .default(Text("موافق")))
                            }
//                    .accentColor(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
                    
                    .navigationBarTitle(store.name).navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing:
                                            HStack {
                                                Button(action: {
                            isPresented = true
                        }, label: {
                            AddButton()
                    })
                                                
//                                                Button(action: {
//                                                    
//                                                }, label: {
//                                                    Text("Add Special Code")
//                                                })
                                            })
                    .onAppear(perform: {
                        UITabBar.appearance().tintColor = .black
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        isSearching = false
                        storeCodeListVM.getStoreCodesByStoreId(storeId: store.id, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                        
                        storeCodeListVM.getStoreSpecialCodeByStoreId(storeId: store.id, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                        
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
                .offset(y: showHUD ? 15: -150)
                .animation(.easeOut)
        }
    }
    
    struct StoreCodesListView_Previews: PreviewProvider {
        @State static var isSearching = false
        static var previews: some View {
            StoreCodesListView(store: StoreViewModel(store: Store(id: "", name: "thr", picture: "hungerPic", onlinePicture: "", codes: nil, category: [], timeAscending: Date())), isSearching: $isSearching)
        }
    }
    
    
}


