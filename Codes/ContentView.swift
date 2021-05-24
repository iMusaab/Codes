//
//  ContentView.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import SwiftUI


//extension List {
//    @ViewBuilder func noSeparators() -> some View {
//        #if swift(>=5.3) // Xcode 12
//        if #available(iOS 14.0, *) { // iOS 14
//            self
//            .accentColor(Color.secondary)
//            .listStyle(PlainListStyle())
//            .onAppear {
//                UITableView.appearance().backgroundColor = UIColor.systemBackground
//            }
//        } else { // iOS 13
//            self
//                        .listStyle(PlainListStyle())
//            .onAppear {
//                UITableView.appearance().separatorStyle = .none
//            }
//        }
//        #else // Xcode 11.5
//        self
//                .listStyle(PlainListStyle())
//        .onAppear {
//            UITableView.appearance().separatorStyle = .none
//        }
//        #endif
//    }
//}

struct ContentView: View {
    
    
    @ObservedObject private var storeListVM = StoreListViewMode()
    
    @StateObject private var regesterVM = CreateUserViewModel()
    
    @State var searchText = ""
    @State var isSearching = false
    
    @State var selection: String? = nil
    
    init() {

        UINavigationBar.appearance().barTintColor = .clear
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()

         }
    var body: some View {
        
        
        
        ZStack {
            VStack {
                SearchBar(searchText: $searchText, isSearching: $isSearching)
                Spacer(minLength: 20)
                
                GeometryReader { outerGeometry in
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(storeListVM.stores.filter({
                                "\($0)".contains(searchText) || searchText.isEmpty
                            }), id: \.storeId) { store in
                                NavigationLink(
                                    destination: StoreCodesListView(store: store), tag: store.storeId, selection: $selection) {
                                    
                                    
                                    GeometryReader { innerGeometry in
                                        HStack {
                                            Image(store.picture)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60, height: 60)
                                                .clipShape(Circle())
                                                .padding(.horizontal, 5)
                                            Text(store.name)
                                                .font(.headline)
                                        }
                                        .padding(.leading, 7)
                                        .padding(.top, 10)
                                    }
                                    .frame(width: outerGeometry.size.width - 30, height: 80)
                                    .background((selection == store.storeId) ? LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)).opacity(0.5), Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)).opacity(0.5)]), startPoint: .trailing, endPoint: .leading) :
                                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9098039216, blue: 0.9019607843, alpha: 1)).opacity(0.8), Color(#colorLiteral(red: 0.9019607843, green: 0.9098039216, blue: 0.9019607843, alpha: 1)).opacity(0.5)]), startPoint: .trailing, endPoint: .leading)
                                    )
                                    .cornerRadius(30)
                                    .padding(.leading, 15)
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.vertical, 5)
//                                .background((selection != nil) ? Color.red : Color.clear)
                                
                            }
                        }
                    }
                    .animation(.default)
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarTitle("المتاجر")
                }
//                .navigationBarHidden(isSearching)
                
            }
            .background(
                VStack {
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9212613106, green: 0.9274845123, blue: 0.9214318395, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 300)
                        .ignoresSafeArea(.all)
                    Spacer()
                        
                })
            .embedInNavigationView()
            .accentColor(Color(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)))
            
            .onAppear {
                storeListVM.getAll()
                regesterVM.CreateUser {_ in
                    print("User created")
                    
                }
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
                        .padding(isSearching ? 8 : 7)
                        .padding(.horizontal, 20)
                        .background(Color(.white))
                        .cornerRadius(20)
                        .padding(.horizontal, 15)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.06), radius: 10, x: 0, y: 20)
                }
                
                .onTapGesture {
                    isSearching = true
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        
                        if isSearching {
                            Button(action: {
                                searchText = ""
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .padding(.trailing, 20)
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
                            .padding(.leading, -4)
                    })
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
        }
    }

