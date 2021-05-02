//
//  ContentView.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var storeListVM = StoreListViewMode()
    
    var body: some View {
        VStack {
            List(storeListVM.stores, id: \.storeId) { store in
                
                NavigationLink(
                    destination: StoreCodesListView(store: store),
                    label: {
                    StoreCell(store: store)
                    })
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Stores")
        .embedInNavigationView()
        
        .onAppear {
            storeListVM.getAll()
        }
    }
}

struct StoreCell: View {
    
    let store: StoreViewModel
    
    var body: some View {
        HStack {
            Text(store.name)
                .font(.headline)
            Image(store.picture)
                .resizable()
                .scaledToFit()
                .frame(width: 50,height:100)
                .clipShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


