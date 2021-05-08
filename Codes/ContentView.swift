//
//  ContentView.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import SwiftUI


extension List {
    @ViewBuilder func noSeparators() -> some View {
        #if swift(>=5.3) // Xcode 12
        if #available(iOS 14.0, *) { // iOS 14
            self
            .accentColor(Color.secondary)
            .listStyle(SidebarListStyle())
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.systemBackground
            }
        } else { // iOS 13
            self
                        .listStyle(PlainListStyle())
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
        }
        #else // Xcode 11.5
        self
                .listStyle(PlainListStyle())
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
        #endif
    }
}

struct ContentView: View {
    
    @ObservedObject private var storeListVM = StoreListViewMode()
    
    @StateObject private var regesterVM = CreateUserViewModel()
    
    var body: some View {
        
            List(storeListVM.stores, id: \.storeId) { store in
                NavigationLink(
                    destination: StoreCodesListView(store: store),
                    label: {
                    StoreCell(store: store)
                    })
            }
            .noSeparators()
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitle("المتاجر")
            .embedInNavigationView()
        
        
        .onAppear {
            storeListVM.getAll()
            regesterVM.CreateUser {_ in
                print("User created")
                
            }
        }
    }
}

struct StoreCell: View {
    
    let store: StoreViewModel
    
    var body: some View {
        HStack {
            Image(store.picture)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height:75)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding(5)
            VStack(alignment: .leading, spacing: nil) {
                Text(store.name)
                    .font(.title3).bold()
                    .padding(1)
                Text("عدد الاكواد")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.layoutDirection, .rightToLeft)
    }
}


