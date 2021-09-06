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
    
    @State var isLiked = false
    @State var isDisLiked = false
    
    func updateVoteStatus() {
        
    }
    
    func dismissHUDAfterTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showHUD = false
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack{
                    HStack {
                        VStack {
                            Button(action: {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    isLiked = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        isLiked = false
                                    }
                                }
                                
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
                            
                            ZStack {
                                if !isLiked && !isDisLiked {
                                Text(code.votes > 99 ? "+99" : "\(code.votes)")
                                    .font(.body).bold()
                                    .foregroundColor(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
                                    .frame(width: 35, alignment: .center)
                                }
                                else if isLiked {
                                    LikeAnimation()
                                } else if isDisLiked {
                                    DisLikeAnimation()
                                }
                                
                            }
                            
                            Button(action: {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    isDisLiked = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        isDisLiked = false
                                    }
                                }
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
//                                shareButton(uiImage: UIImage(named: "AdidasPic")!)
//                                        .padding(.trailing, 30)
                                Button(action: shareButton) {
                                    Image(systemName: "square.and.arrow.up")
                                            .foregroundColor(.black)
                                }
                                .padding(.trailing, 30)

                                
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
                                        Text(code.code.isEmpty ? "اذهب" : code.code) .lineLimit(1)
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
    
    func shareButton() {
        if code.code.isEmpty {
            if !code.url.isEmpty {
                let shareActivity = UIActivityViewController(activityItems: ["\(code.Description)\n\n\(code.url)"], applicationActivities: nil)
                if let vc = UIApplication.shared.windows.first?.rootViewController{
                    shareActivity.popoverPresentationController?.sourceView = vc.view
                    //Setup share activity position on screen on bottom center
                    shareActivity.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height, width: 0, height: 0)
                    shareActivity.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
                    vc.present(shareActivity, animated: true, completion: nil)
                }
            }
        }
        else {
            let shareActivity = UIActivityViewController(activityItems: ["\(code.Description)\n\n Code: \(code.code)"], applicationActivities: nil)
            if let vc = UIApplication.shared.windows.first?.rootViewController{
                shareActivity.popoverPresentationController?.sourceView = vc.view
                //Setup share activity position on screen on bottom center
                shareActivity.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height, width: 0, height: 0)
                shareActivity.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
                vc.present(shareActivity, animated: true, completion: nil)
            }
        }
    }
}


struct normalCodeCell_Previews: PreviewProvider {
    @State static var isDisabled = false
    @State static var showHUD = false
    
    static var previews: some View {
        normalCodeCell(voteEnabled: true , code: StoreCodeViewModel(storeCode: StoreCode(id: "", title: "خصم ١٠٪", Description: "هقتح قثختلحثقخل خحتثقلحختلقحخلقث لقخحتلقثحخقتلثلق ثحختحخلثقت لقلقحخثتلقث قلثخحتلقثح لق", code: "", url: "", votes: 100, votedBy: [], isEnabled: true, DateCreated: Date())), showHUD: $showHUD, storeCodeListVM: StoreCodeListViewModel(), store: StoreViewModel(store: Store(id: "", name: "HungerStation", picture: "HungerPic", onlinePicture: "", codes: nil, category: [], timeAscending: Date()))).environment(\.layoutDirection, .rightToLeft)
    }
}
