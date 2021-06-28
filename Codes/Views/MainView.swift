//
//  MainView.swift
//  Codes
//
//  Created by Musab Aljarba on 27/09/1442 AH.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var storeListVM = StoreListViewMode()
    
    @State private var selectedTab = 1
    
    var shownTitle: String {
        if selectedTab == 2 {
            return "الاعدادات"
        }
    return "المتاجر"
    }
    
    init() {
        UITabBar.appearance().barTintColor = .white
            UITabBar.appearance().tintColor = .black
//            UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
            UITabBar.appearance().clipsToBounds = true
        
        UINavigationBar.appearance().barTintColor = UIColor(Color.white.opacity(0.1))
    //        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            UINavigationBar.appearance().isTranslucent = true
            UINavigationBar.appearance().shadowImage = UIImage()
        }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    Image(systemName: "house").font(.system(size: 26))
                }
                .tag(1)
                .onTapGesture {
                    self.selectedTab = 1
                }
            SettingsView()
                
                .onTapGesture {
                        self.selectedTab = 2
                }
                .tabItem {
                    Image(systemName: "gear").font(.system(size: 26))
                }
                .tag(2)
        }
        
        .navigationBarTitle(shownTitle)
        .accentColor(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
        .embedInNavigationView()
        .accentColor(Color(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.layoutDirection, .rightToLeft)
    }
}
