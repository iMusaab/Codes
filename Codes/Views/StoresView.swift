//
//  ContentView.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftUIRefresh


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

struct StoresView: View {
    
    
    @StateObject private var storeListVM = StoreListViewMode()
    
    @StateObject private var regesterVM = CreateUserViewModel()
    
    @State var searchText = ""
    @State var isSearching = false
    
    @State var selectedCategory = "الكل"
    
    @State var selection: String? = nil
    
    @State private var isShowing = false
    
//    init() {
//
//        UINavigationBar.appearance().barTintColor = .clear
////        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
////        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().shadowImage = UIImage()
//
//         }
    var body: some View {
        
        
        
        ZStack {
            VStack {
                
//                Button(action: {
//                    storeListVM.addDocumentToFirestore()
//                }, label: {
//                    Text("Add Store")
//                })
                
                SearchBar(searchText: $searchText, isSearching: $isSearching, selectedCategory: $selectedCategory)
//                    .padding(.bottom, 5)
                
//                if !isSearching {
                    CategoriesScrollView(selectedCategory: $selectedCategory)
//                        .padding(.top, 10)
                    
//                }
                
                GeometryReader { outerGeometry in
//                    ScrollView {

                        
                        
                            
                            if storeListVM.storesSaved {

                                
                                List() {

                                ForEach(storeListVM.stores.filter({
                                    if !searchText.isEmpty {
                                        return "\($0)".contains(searchText)
                                    }
                                    return "\($0.category)".contains(selectedCategory)
    //                                "\($0)".contains(searchText) || searchText.isEmpty
                                }), id: \.id) { store in
                                    NavigationLink(
                                        destination: StoreCodesListView(store: store), tag: store.id, selection: $selection) {
                                            
                                            if !store.picture.isEmpty {
                                            HStack {
                                                
                                                
                                                    Image(store.picture)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 60, height: 60)
                                                    .cornerRadius(9)
                                                        
                                                    .padding(.horizontal, 9)
//                                                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0.0, y: 2)
                                                
                                                Text(store.name)
                                                    .font(.body).bold()

                                            }

                                            } else {
                                                HStack {
                                                    ZStack {
                                                        Image("SwarovskiPic")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 60, height: 60)
                                                            .cornerRadius(9)
                                                            .padding(.horizontal, 9)
                                                        WebImage(url: URL(string: store.onlinePicture))
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 60, height: 60)
                                                            .cornerRadius(9)
                                                            .padding(.horizontal, 5)
                                                        
                                                        
                                                    }
                                                    Text(store.name)
                                                        .font(.body).bold()
                                                    

                                                }

                                            }

                                        
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.vertical, 5)
                                    //                                .background((selection != nil) ? Color.red : Color.clear)
                                    
                                }
                                }
                                
                                .pullToRefresh(isShowing: $isShowing) {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        storeListVM.getAll()
                                        self.isShowing = false
                                        
                                    }
                                }
                                .id(UUID())
                                }
                            else {
                                
                                VStack {
                                    HStack(alignment: .center) {
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
//                                            .scaleEffect(1.5, anchor: .center)
                                        Spacer()
                                    }
                                }.frame(height: outerGeometry.size.height / 2, alignment: .center)
                                
                                
                            }
                        
//                    }

                }
//                .navigationBarHidden(isSearching)
                
            }
            .background(
                VStack {
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9212613106, green: 0.9274845123, blue: 0.9214318395, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 200)
                        .ignoresSafeArea(.all)
                    Spacer()
                        
                })
//            .embedInNavigationView()
            .accentColor(Color(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)))
            
            
        }
        .onAppear {
            storeListVM.getAll()
            selectedCategory = "الكل"
            print("onappear is accessed on contentview")
            regesterVM.CreateUser {_ in
                print("User created")
                
            }
    }
    }
}


struct StoresView_Previews: PreviewProvider {
    @State static var selectedCategory = "الكل"
    
    static var previews: some View {
        ContentView(selectedCategory: $selectedCategory).environment(\.layoutDirection, .rightToLeft)
    }
}





