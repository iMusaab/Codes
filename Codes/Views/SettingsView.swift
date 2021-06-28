//
//  SettingsView.swift
//  Codes
//
//  Created by Musab Aljarba on 13/10/1442 AH.
//

import SwiftUI
import StoreKit

func rateApp() {
    if #available(iOS 10.3, *) {
        SKStoreReviewController.requestReview()

    } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)

        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

struct SettingsCellModel: Hashable {
//    static func == (lhs: SettingsCellModel, rhs: SettingsCellModel) -> Bool {
//        return lhs.icon == rhs.icon && lhs.title == rhs.title
//    }
//    func hash(into hasher: inout Hasher) {
//            hasher.combine(self.title)
//            hasher.combine(self.icon)
//        }
//
    
    var title: String
    var icon: String
}

struct SettingsView: View {
    @State var selection: String? = nil
    
    var settingCells: [SettingsCellModel] = [
        SettingsCellModel(title: "قيم التطبيق", icon: "star.fill"),
        SettingsCellModel(title: "تفعيل الاشعارات", icon: "bell.fill"),
        SettingsCellModel(title: "الشروط والأحكام", icon: "text.book.closed.fill"),
        SettingsCellModel(title: "سياية الخصوصية", icon: "shield.fill"),
        SettingsCellModel(title: "تواصل معنا", icon: "phone.circle.fill")
    ]
    
    var body: some View {
        
        GeometryReader { outerGeometry in
            ScrollView {
                LazyVStack {
                    
                    Button(action: {
                        rateApp()
                    }, label: {
                        SettingsCell(title: settingCells[0].title, icon: settingCells[0].icon, outerGeometry: outerGeometry)
                    })
                    .padding(.top, 45)
                    
                    Button(action: {
                        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                           UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }, label: {
                        SettingsCell(title: settingCells[1].title, icon: settingCells[1].icon, outerGeometry: outerGeometry)
                    })
                    
                    Link(destination: URL(string: "https://wa.me/message/USVISPLKHZ6JA1")!) {
                        SettingsCell(title: settingCells[4].title, icon: settingCells[4].icon, outerGeometry: outerGeometry)
                    }
                    
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            SettingsCell(title: settingCells[2].title, icon: settingCells[2].icon, outerGeometry: outerGeometry)
                        })
                    
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            SettingsCell(title: settingCells[3].title, icon: settingCells[3].icon, outerGeometry: outerGeometry)
                        })
                    
                }
                
                
            }
            
            
            
        }
        .padding(.top, 5)
        .background(
            VStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9212613106, green: 0.9274845123, blue: 0.9214318395, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 300)
                    .ignoresSafeArea(.all)
                Spacer()
                    
            })
    }
    
}

        
//        VStack {
//            List {
//                Button(action: {
//
//                }, label: {
//                    HStack {
//                        Text("تواصل معنا")
//                        Spacer()
//
//                        Image("whatsAppPic")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    }
//
//                })
//
//                Text("تفعيل الاشعارات")
//                Text("الشروط والأحكام")
//                Text("قيم التطبيق")
//            }
//
//        }
        

struct SettingsCell: View {
//    @Binding var selection: String?
    var title: String
    var icon: String
    
    var outerGeometry: GeometryProxy
    
    var body: some View {
        
                    HStack {
                        Image(systemName: icon)
                            .font(.system(size: 26))
                            .foregroundColor(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
                            
                            
                            .padding(.horizontal, 5)
                        Text(title)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .padding(.trailing)
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                    }
                    .padding(.leading, 7)
                    //                        .padding(.top, 10)
                    .frame(width: outerGeometry.size.width - 30, height: 70)
                    .background(Color(#colorLiteral(red: 0.9212613106, green: 0.9274845123, blue: 0.9214318395, alpha: 1)).opacity(0.7))
                    .cornerRadius(30)
//                    .padding(.leading, 7.5)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical, 5)
                
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environment(\.layoutDirection, .rightToLeft)
    }
}


