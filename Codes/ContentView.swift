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
            .listStyle(PlainListStyle())
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
    
    @State var searchText = ""
    @State var isSearching = false
    
    @State var selection: String? = nil
    
    
    var body: some View {
        
        VStack {
            SearchBar(searchText: $searchText, isSearching: $isSearching)

            List(storeListVM.stores.filter({
                "\($0)".contains(searchText) || searchText.isEmpty
            }), id: \.storeId) { store in
                NavigationLink(
                    destination: StoreCodesListView(store: store), tag: store.storeId, selection: $selection) {
                    StoreCell(store: store)
                }
                .onDisappear {
                    self.selection = nil
                }
                
            }
            .noSeparators()
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitle("المتاجر")
        }
        
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
                .frame(width: 65, height: 65)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding(5)
            VStack(alignment: .leading, spacing: nil) {
                Text(store.name)
                    .font(.body).bold()
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



struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("بحث...", text: $searchText)
                    .padding(isSearching ? 10 : 7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
            }
            
            .onTapGesture {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .rotationEffect(.degrees(-90))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    if isSearching {
                        Button(action: {
                            searchText = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.trailing, 16)
                                .padding(.vertical)
                        })
                        
                        
                    }
                }
                .foregroundColor(.gray)
            ).transition(.move(edge: .trailing))
            .animation(.default)
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("إلغاء")
                        .padding(.trailing)
                        .padding(.leading, -5)
                })
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
