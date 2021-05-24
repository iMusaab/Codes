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
    
    @State private var isDisabled = false
    
    @State private var showHUD = false
    
    @Environment(\.openURL) var openURL
    
    let pasteboard = UIPasteboard.general
    
    func dismissHUDAfterTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showHUD = false
        }
    }
    
    
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
                           
                            GeometryReader { geometry in
                             VStack{
                                    HStack {
                                        VStack {
                                            Button(action: {
                                                storeCodeListVM.updateCodeVotes(storeId: store.storeId, storeCodeId: code.storeCodeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "", upOrDown: .up)
                                                storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                                                storeCodeListVM.isDisabled = true
                                            }, label: {
                                                Image(systemName: "chevron.up")
                                                    .font(.system(size: 18, weight: .black))
                                                    .foregroundColor(voteEnabled ? Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)).opacity(0.35) : Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                                    .frame(width: 30, height: 30, alignment: .center)
                                            })
                                            .disabled(voteEnabled || storeCodeListVM.isDisabled)
                                            .buttonStyle(BorderlessButtonStyle())
                                            
                                            Text("\(code.votes)")
                                                .font(.body).bold()
                                                .foregroundColor(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
                                                .frame(width: 30, alignment: .center)
                                            
                                            Button(action: {
                                                storeCodeListVM.updateCodeVotes(storeId: store.storeId, storeCodeId: code.storeCodeId, userId:regesterVM.defaults.string(forKey: "userId") ?? "", upOrDown: .down)
                                                storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                                                storeCodeListVM.isDisabled = true
                                            }, label: {
                                                Image(systemName: "chevron.down")
                                                    .font(.system(size: 18, weight: .black))
                                                    .foregroundColor(voteEnabled ? Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)).opacity(0.35) : Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                                    .frame(width: 30, height: 30, alignment: .center)
                                                
                                            })
                                            .disabled(voteEnabled || storeCodeListVM.isDisabled)
                                            .buttonStyle(BorderlessButtonStyle())
                                            
                                        }
                                        .frame(width: 20, height: 70, alignment: .center)
                                        .padding(.horizontal, 10)
                                        
                                        VStack {
                                            HStack(alignment: .top) {
                                                Text(code.title)
                                                    .font(.system(size: 20, weight: .bold))
                                                    .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                                Spacer ()
                                            }
                                            Spacer()
                                            HStack {
                                                
                                                Text(code.Description)
                                                    .font(.system(size: 16, weight: .regular))
                                                    .frame(width: geometry.size.width - 80, alignment: .leading)

                                            }
                                            
                                            Spacer()
                                            
                                            HStack(alignment: .bottom) {
                                                Spacer()
                                                Button(action: {
                                                    if code.code.isEmpty {
                                                        if !code.url.isEmpty {
                                                            openURL(URL(string: code.url)!)
                                                        }
                                                    }
                                                    else {
                                                        pasteboard.string = code.code
                                                        withAnimation {
                                                            self.showHUD = true
                                                            dismissHUDAfterTime()
                                                        }
                                                    }
                                                    
                                                }, label: {
                                                    HStack {
                                                        Image(systemName: "doc.on.doc.fill")
                                                            .foregroundColor(.black).opacity(code.code.isEmpty ? 0 : 0.5)
                                                            .font(.system(size: 14))
                                                        Text(code.code.isEmpty ? "اذهب" : code.code)
                                                            .font(.system(size: 18, weight: .bold))
                                                            .foregroundColor(.black)
                                                            .padding(.vertical, 8)
                                                            .padding(.horizontal, 5)
                                                            .frame(width: geometry.size.width / 3.5)
                                                            .background(Color.white)
                                                            .cornerRadius(35)
                                                            .shadow(color: Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 6)
                                                        
                                                    }
                                                }).padding(.trailing, 10)
                                            }
                                            .padding(.trailing, 30)
                                            
                                        }
                                        .padding(.vertical, 20)
                                    }
                                }
//                                .padding(.vertical, 20)
//                                .padding(.horizontal, 30)
                                .frame(width: geometry.size.width - 30, height: 180)
                                //                .padding(.leading)
                                .background(Color(#colorLiteral(red: 0.8078431373, green: 0.8156862745, blue: 0.8078431373, alpha: 1)))
                                .cornerRadius(35)
                                .shadow(color: Color(#colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)).opacity(0.25), radius: 20, x: 0, y: 20)
                                
                                .padding(.leading, 15)
                                
                            }
                            .frame(height: 200, alignment: .center)
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
                    
                    .navigationBarTitle(store.name).navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button(action: {
                        isPresented = true
                    }, label: {
                        AddButton()
                    }))
                    .onAppear(perform: {
                        
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
            StoreCodesListView(store: StoreViewModel(store: Store(id: "hrth", name: "thr", picture: "trh", codes: ["gter", "gerg"])))
        }
    }
    
    
}

