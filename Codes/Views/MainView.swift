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
    
    @State private var selectedCategory = "الأشهر"
    
    var shownTitle: String {
        if selectedTab == 2 {
            return "الاعدادات"
        }
    return "المتاجر"
    }
    
    
    
    init() {
//        UITabBar.appearance().barTintColor = UIColor(Color(#colorLiteral(red: 0.9212613106, green: 0.9274845123, blue: 0.9214318395, alpha: 0)))
//            UITabBar.appearance().tintColor = .black
            UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
//            UITabBar.appearance().clipsToBounds = true
        
        
//        UINavigationBar.appearance().barTintColor = UIColor(Color.white.opacity(0.1))
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            UINavigationBar.appearance().isTranslucent = true
//            UINavigationBar.appearance().shadowImage = UIImage()
        }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView(selectedCategory: $selectedCategory)
                
                .tabItem {
//                    Image(systemName: "house")
                    Label("الرئيسية", systemImage: "house")
                }
                .tag(1)
                .onTapGesture {
                    self.selectedTab = 1
//                    selectedCategory = "صحة"
                }
            SettingsView()
                
                .onTapGesture {
                        self.selectedTab = 2
//                    selectedCategory = "صحة"
                }
                .tabItem {
                    Label("الإعدادات", systemImage: "gear")
                }
                .tag(2)
        }
        .onChange(of: selectedTab, perform: { selectedTab in
            if selectedTab == 2 {
                selectedCategory = "الأشهر"
            }
        })
        
        .navigationBarTitle(shownTitle)
        .accentColor(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
        .embedInNavigationView()
//        .modifier(DismissingKeyboard())
        .accentColor(Color(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.layoutDirection, .rightToLeft)
    }
}
