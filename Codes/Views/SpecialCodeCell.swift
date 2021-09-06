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
                    Button(action: shareButton) {
                        Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white)
                    }
//                    .padding(.trailing, 30)
                }
                
                Spacer()
                
                Text(specialCode.Description)
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: geometry.size.width - 120, alignment: .leading)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                
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
                            Image(systemName: specialCode.code.isEmpty ? "arrow.up.backward" : "doc.on.doc")
                                .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                .font(.system(size: specialCode.code.isEmpty ? 14 : 12))
                            
                            Text(specialCode.code.isEmpty ? "اذهب" : specialCode.code).lineLimit(1)
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
    
    func shareButton() {
        if specialCode.code.isEmpty {
            if !specialCode.url.isEmpty {
                let shareActivity = UIActivityViewController(activityItems: ["\(specialCode.Description)\n\n\(specialCode.url)"], applicationActivities: nil)
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
            let shareActivity = UIActivityViewController(activityItems: ["\(specialCode.Description)\n\n Code: \(specialCode.code)"], applicationActivities: nil)
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


struct SwiftUIView_Previews: PreviewProvider {
    @State static var showHUD = false
    
    static var previews: some View {
        SpecialStoreCell(specialCode: StoreCodeViewModel(storeCode: StoreCode(id: "", title: "خصم ١٠٪", Description: "هقتح قثختلحثقخل خحتثقلحختلقحخلقث لقخحتلقثحخقتلثلق ثحختحخلثقت لقلقحخثتلقث قلثخحتلقثح لق", code: "", url: "", votes: 2, votedBy: [], isEnabled: true, DateCreated: Date())), showHUD: $showHUD).environment(\.layoutDirection, .rightToLeft)
    }
}
