//
//  SwiftUIView.swift
//  Codes
//
//  Created by Musab Aljarba on 12/10/1442 AH.
//

import SwiftUI

struct SpecialStoreCell: View {
    var specialCode: StoreCodeViewModel
    @Binding var showHUD: Bool
    let pasteboard = UIPasteboard.general
    
    @Environment(\.openURL) var openURL
    
    func dismissHUDAfterTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showHUD = false
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            
            VStack{
                HStack(alignment: .top) {
                    Text(specialCode.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Spacer ()
                }
                
                Spacer()
                
                Text(specialCode.Description)
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: geometry.size.width - 120, alignment: .leading)
                    .padding(.bottom, 10)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    
                    Text("مدعوم")
                        .font(.caption)
                        .foregroundColor(.white)
                    Spacer ()
                    
                    Button(action: {
                        if specialCode.code.isEmpty {
                            if !specialCode.url.isEmpty {
                            openURL(URL(string: specialCode.url)!)
                            }
                        }
                        else {
                            pasteboard.string = specialCode.code
                            withAnimation {
                                self.showHUD = true
                                dismissHUDAfterTime()
                            }
                        }
                    }, label: {
                        HStack {
                            Image(systemName: specialCode.code.isEmpty ? "arrow.up.forward.app.fill" : "doc.on.doc.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                .font(.system(size: specialCode.code.isEmpty ? 16 : 12))
                                .padding(.leading, 4)
                            
                            Spacer()
                            
                            Text(specialCode.code.isEmpty ? "اذهب" : specialCode.code)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
//                                .padding(.trailing, specialCode.code.isEmpty)
                            
                            Spacer()
                        }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 5)
                                .frame(width: geometry.size.width / 3.5)
                                .background(Color.white)
                                .cornerRadius(35)
                                .shadow(color: Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 6)
                        
                    }).padding(.trailing, 10)
                }
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
            .frame(width: geometry.size.width - 30, height: 200)
            .background(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
            .cornerRadius(35)
            .shadow(color: Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            
            .padding(.leading, 15)
            
        }
        
        .frame(height: 220, alignment: .center)
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    @State static var showHUD = false
    
    static var previews: some View {
        SpecialStoreCell(specialCode: StoreCodeViewModel(storeCode: StoreCode(id: "", title: "خصم ١٠٪", Description: "هقتح قثختلحثقخل خحتثقلحختلقحخلقث لقخحتلقثحخقتلثلق ثحختحخلثقت لقلقحخثتلقث قلثخحتلقثح لق", code: "thtrhr", url: "", votes: 2, votedBy: [], isEnabled: true, DateCreated: Date())), showHUD: $showHUD).environment(\.layoutDirection, .rightToLeft)
    }
}
