//
//  CodesView.swift
//  Codes
//
//  Created by Musab Aljarba on 05/10/1442 AH.
//

import SwiftUI
import MobileCoreServices

struct codes1: Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let code: String
}

struct CodesView: View {
//
//    func dismissHUDAfterTime() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.showHUD = false
//            }
//        }
    
    let code1 = codes1(id: UUID(), title: "10% Discount", description: "Discount on selected items on the store sites that includes a lot of good things trb fhifoihj rifjoirgj fdiojgdoij. ", code: "Aziz")
    
    
    
    var body: some View {
        var codes: [codes1] = [self.code1]
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                
                    
                    VStack{
                        HStack(alignment: .top) {
                            Text(codes[0].title)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Spacer ()
                        }
                       Spacer()
                        
                    Text(codes[0].description)
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom) {
                            
                            Text("مدعوم")
                                .font(.caption)
                                .foregroundColor(.white)
                            Spacer ()
                            
                            Button(action: {
                                UIPasteboard.general.string = codes[0].code
                                withAnimation {
//                                    dismissHUDAfterTime()
                                }
                            }, label: {
                                Text(codes[0].code)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
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
    //                .padding(.leading)
                    .background(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
                    .cornerRadius(35)
                    .shadow(color: Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    
                .padding(.leading, 15)
                
            }
        }
        
        
    }
}

struct CodesView_Previews: PreviewProvider {
    static var previews: some View {
        CodesView()
    }
}
