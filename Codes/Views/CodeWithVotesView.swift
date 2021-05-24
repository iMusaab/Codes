//
//  CodeWithVotesView.swift
//  Codes
//
//  Created by Musab Aljarba on 06/10/1442 AH.
//

import SwiftUI

struct codes2: Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let code: String
}

struct CodeWithVotesView: View {
//
//    func dismissHUDAfterTime() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.showHUD = false
//            }
//        }
    
    let code1 = codes2(id: UUID(), title: "10% Discount", description: "Discount on selected items on the store sites that includes a lot of good things trb fhifoihjdfvvfv. ", code: "Aziz")
    
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        var codes: [codes2] = [self.code1]
        
            GeometryReader { geometry in
                                VStack{
                                    HStack {
                                        
                                        VStack {
                                            Button(action: {
            //                                    storeCodeListVM.updateCodeVotes(storeId: store.storeId, storeCodeId: code.storeCodeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "", upOrDown: .up)
            //                                    storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
            //                                    storeCodeListVM.isDisabled = true
                                            }, label: {
                                                Image(systemName: "chevron.up")
                                                    .font(.system(size: 18, weight: .black))
                                                    .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                                    .frame(width: 30, height: 30, alignment: .center)
                                            })
            //                                .disabled(voteEnabled || storeCodeListVM.isDisabled)
                                            
                                            Text("120")
                                                .font(.body).bold()
                                                .foregroundColor(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
                                                .frame(width: 30, alignment: .center)
                                            
                                            Button(action: {
            //                                    storeCodeListVM.updateCodeVotes(storeId: store.storeId, storeCodeId: code.storeCodeId, userId:regesterVM.defaults.string(forKey: "userId") ?? "", upOrDown: .down)
            //                                    storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
            //                                    storeCodeListVM.isDisabled = true
                                                                            }, label: {
                                                Image(systemName: "chevron.down")
                                                    .font(.system(size: 18, weight: .black))
                                                    .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                                    .frame(width: 30, height: 30, alignment: .center)
                                                    
                                            })
            //                                .disabled(voteEnabled || storeCodeListVM.isDisabled)
                                            
                                        }
                                        .frame(width: 20, height: 70, alignment: .center)
                                        .padding(.horizontal, 10)
                                        
                                        VStack {
                                        HStack(alignment: .top) {
                                            Text(codes[0].title)
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                            Spacer ()
                                        }
//                                        .padding(.bottom, 5)
                                            Spacer()
                                        HStack {
                                            
                                            Text(codes[0].description)
                                                .font(.system(size: 16, weight: .regular))
                                            .frame(width: geometry.size.width - 80, alignment: .leading)
//                                                .padding(.bottom, 10)
//                                                .padding(.trailing, 10)
                                        }
                                        
                                    
                                            Spacer()
                                    HStack(alignment: .bottom) {
                                        Spacer()
                                        Button(action: {
                                            if codes[0].code.isEmpty {
                                                openURL(URL(string: "https://www.apple.com")!)
                                            }
                                            else {
                                                UIPasteboard.general.string = codes[0].code
                                                withAnimation {
                //                                    dismissHUDAfterTime()
                                                }
                                            }
                                            
                                        }, label: {
                                            
                                            HStack {
                                                
                                                Text(codes[0].code.isEmpty ? "Visit" : "\(codes[0].code)"  )
                                                
                                                    
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(.black)
                                                    .padding(.vertical, 8)
                                                    .padding(.horizontal, 5)
                                                    
                                                    .frame(width: geometry.size.width / 3.5)
                                                    
                                                    .background(Color.white)
                                                    
                                                    .cornerRadius(35)
                                                    .shadow(color: Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 6)
                                                
                                            }
                                            
                                        })
                                    }
                                    .padding(.trailing, 38)
                                    }
                                        .padding(.vertical, 20)
                                                                            }
                                }
//                            .padding(.vertical, 20)
//                            .padding(.horizontal, )
                            .frame(width: geometry.size.width - 30, height: 180)
            //                .padding(.leading)
                            .background(Color(#colorLiteral(red: 0.8078431373, green: 0.8156862745, blue: 0.8078431373, alpha: 1)))
                            .cornerRadius(35)
                            .shadow(color: Color(#colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)).opacity(0.25), radius: 20, x: 0, y: 20)
                            
                        .padding(.leading, 15)
                            
            }
        
        }
        
        
    }


struct CodeWithVotesView_Previews: PreviewProvider {
    static var previews: some View {
        CodeWithVotesView()
    }
}
