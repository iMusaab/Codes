//
//  ContentView.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import SwiftUI
import SDWebImageSwiftUI


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
    
    
    @StateObject private var storeListVM = StoreListViewMode()
    
    @StateObject private var regesterVM = CreateUserViewModel()
    
    @State var searchText = ""
    @State var isSearching = false
    
    @Binding var selectedCategory: String
    @State var category: String = "الأشهر"
    
    @State var selection: String? = nil
    
    //    init() {
    //
//            UINavigationBar.appearance().barTintColor = .clear
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
                
                CategoriesScrollView(selectedCategory: $selectedCategory)
                //                        .padding(.top, 10)
                
                GeometryReader { outerGeometry in
                    ScrollViewReader { value in
                        ScrollView {
                            
                            RefreshControl(coordinateSpace: .named("RefreshControl")) {
                                //refresh view here
                                storeListVM.getAll()
                                //                            selectedCategory = "الكل"
                            }
                            
                            LazyVStack(alignment: .leading) {
                                
                                if storeListVM.storesSaved {
                                    ForEach(storeListVM.stores.filter({
                                        if !searchText.isEmpty {
                                            return "\($0)".contains(searchText)
                                        }
                                        return "\($0.category)".contains(selectedCategory)
                                        //                                "\($0)".contains(searchText) || searchText.isEmpty
                                    }), id: \.id) { store in
                                        Button(action: {
                                            category = selectedCategory
                                        }, label: {
                                            NavigationLink(
                                                destination: StoreCodesListView(store: store), tag: store.id, selection: $selection) {
                                                
                                                
                                                GeometryReader { innerGeometry in
                                                    
                                                    if !store.picture.isEmpty {
                                                        HStack {
                                                            
                                                            
                                                            Image(store.picture)
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 50, height: 50)
                                                                .clipShape(Circle())
                                                                .padding(.horizontal, 5)
                                                            Text(store.name)
                                                                .font(.body).bold()
                                                            
                                                            Spacer()
                                                            
                                                            Image(systemName: "chevron.forward")
                                                                .padding(.trailing)
                                                                .foregroundColor(.secondary)
                                                        }
                                                        .padding(.leading, 7)
                                                        .padding(.top, 10)
                                                    } else {
                                                        HStack {
                                                            ZStack {
                                                                Image("SwarovskiPic")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 50, height: 50)
                                                                    .clipShape(Circle())
                                                                    .padding(.horizontal, 5)
                                                                WebImage(url: URL(string: store.onlinePicture))
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 50, height: 50)
                                                                    .clipShape(Circle())
                                                                    .padding(.horizontal, 5)
                                                                
                                                                
                                                            }
                                                            Text(store.name)
                                                                .font(.body).bold()
                                                            
                                                            Spacer()
                                                            
                                                            Image(systemName: "chevron.forward")
                                                                .padding(.trailing)
                                                                .foregroundColor(.secondary)
                                                        }
                                                        .padding(.leading, 7)
                                                        .padding(.top, 10)
                                                    }
                                                }
                                                .frame(width: outerGeometry.size.width - 30, height: 70)
                                                .background((selection == store.id) ?
                                                                Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)).opacity(0.5) : Color(#colorLiteral(red: 0.9212613106, green: 0.9274845123, blue: 0.9214318395, alpha: 1)).opacity(0.7))
                                                
                                                
                                                //                                                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)).opacity(0.5), Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)).opacity(0.5)]), startPoint: .trailing, endPoint: .leading) :
                                                //                                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9098039216, blue: 0.9019607843, alpha: 1)).opacity(0.8), Color(#colorLiteral(red: 0.9019607843, green: 0.9098039216, blue: 0.9019607843, alpha: 1)).opacity(0.5)]), startPoint: .trailing, endPoint: .leading))
                                                .cornerRadius(30)
                                                .padding(.leading, 15)
                                                //                                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1), radius: 10, x: 0, y: 10)
                                                
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                            .padding(.vertical, 5)
                                        })
                                        
                                        //                                .background((selection != nil) ? Color.red : Color.clear)
                                        
                                    }
                                } else {
                                    
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
                            }
                        }
//                        .id("SCROLL_TO_TOP")
                        .onChange(of: selectedCategory) { category in
                            if let store = storeListVM.stores.first( where: { "\($0.category)".contains(category)
                            }) {
//                                withAnimation {
                                    value.scrollTo(store.id, anchor: .top)
//                                }
                                
                        }
                            
                                }
                        .coordinateSpace(name: "RefreshControl")
//                        .animation(.default)
                        .navigationBarTitleDisplayMode(.large)
                        .navigationBarTitle("المتاجر")
                    }
                    
                }
                //                .navigationBarHidden(isSearching)
                
            }
            .background(
                VStack {
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 300)
                        .ignoresSafeArea(.all)
                    Spacer()

                })
//            .background(Color(#colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)).ignoresSafeArea(.all))
            //            .embedInNavigationView()
            .accentColor(Color(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)))
            
            
        }
        .onAppear {
            storeListVM.getAll()
//            selectedCategory = category
            print("onappear is accessed on contentview")
            regesterVM.CreateUser {_ in
                print("User created")
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    @State static var selectedCategory = "الأشهر"
    
    static var previews: some View {
        ContentView(selectedCategory: $selectedCategory).environment(\.layoutDirection, .rightToLeft)
    }
}





