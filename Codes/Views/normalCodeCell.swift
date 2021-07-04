//
//  normalCodeCell.swift
//  Codes
//
//  Created by Musab Aljarba on 12/10/1442 AH.
//

import SwiftUI

struct normalCodeCell: View {
    var voteEnabled: Bool
//    @Binding var isDisabled: Bool
    var code: StoreCodeViewModel
    @Binding var showHUD: Bool
    let pasteboard = UIPasteboard.general
    
    @StateObject var storeCodeListVM: StoreCodeListViewModel
    
    var store: StoreViewModel
    
    @ObservedObject private var regesterVM = CreateUserViewModel()

    @Environment(\.openURL) var openURL
    
    func updateVoteStatus() {
        
    }
    
    func dismissHUDAfterTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showHUD = false
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack {
                    VStack {
                        Button(action: {
                            
                            storeCodeListVM.updateCodeVotes(storeId: store.id, storeCodeId: code.storeCodeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "", upOrDown: .up)
                            storeCodeListVM.getStoreCodesByStoreId(storeId: store.id, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                            
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
                            storeCodeListVM.updateCodeVotes(storeId: store.id, storeCodeId: code.storeCodeId, userId:regesterVM.defaults.string(forKey: "userId") ?? "", upOrDown: .down)
                            storeCodeListVM.getStoreCodesByStoreId(storeId: store.id, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
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
                                .frame(width: abs(geometry.size.width - 80), alignment: .leading)
                            
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
                                    Image(systemName: code.code.isEmpty ? "arrow.up.backward" : "doc.on.doc")
                                        .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                        .font(.system(size: code.code.isEmpty ? 14 : 12))
                                    Text(code.code.isEmpty ? "اذهب" : code.code)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 5)
                                        .frame(width: geometry.size.width / 3.5)
                                        .background(Color.white)
                                        .cornerRadius(35)
                                        .shadow(color: Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 6)
                                    
                                
                            }).padding(.trailing, 10)
                        }
                        .padding(.trailing, 30)
                        
                    }
                    .padding(.vertical, 20)
                }
            }
            //                                .padding(.vertical, 20)
            //                                .padding(.horizontal, 30)
            .frame(width: abs(geometry.size.width - 30), height: 180)
            //                .padding(.leading)
            .background(Color(#colorLiteral(red: 0.8078431373, green: 0.8156862745, blue: 0.8078431373, alpha: 1)))
            .cornerRadius(35)
            .shadow(color: Color(#colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)).opacity(0.25), radius: 20, x: 0, y: 20)
            
            .padding(.leading, 15)
            
        }
        
        .frame(height: 200, alignment: .center)
    }
    
}


struct normalCodeCell_Previews: PreviewProvider {
    @State static var isDisabled = false
    @State static var showHUD = false
    
    static var previews: some View {
        normalCodeCell(voteEnabled: true , code: StoreCodeViewModel(storeCode: StoreCode(id: "", title: "خصم ١٠٪", Description: "هقتح قثختلحثقخل خحتثقلحختلقحخلقث لقخحتلقثحخقتلثلق ثحختحخلثقت لقلقحخثتلقث قلثخحتلقثح لق", code: "", url: "", votes: 2, votedBy: [], isEnabled: true, DateCreated: Date())), showHUD: $showHUD, storeCodeListVM: StoreCodeListViewModel(), store: StoreViewModel(store: Store(id: "", name: "HungerStation", picture: "HungerPic", onlinePicture: "", codes: nil, category: [], timeAscending: Date()))).environment(\.layoutDirection, .rightToLeft)
    }
}
