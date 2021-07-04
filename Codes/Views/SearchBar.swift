//
//  SearchBar.swift
//  Codes
//
//  Created by Musab Aljarba on 17/11/1442 AH.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @Binding var selectedCategory: String
//    @StateObject var storeListVM: StoreListViewMode
    
    var body: some View {
        
            HStack {
                HStack {
                    TextField("بحث...", text: $searchText)
                        .padding(isSearching ? 8 : 7)
                        .padding(.horizontal, 20)
                        .background(Color(.white))
                        .cornerRadius(20)
                        .padding(.horizontal, 15)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.06), radius: 2, x: 0, y: 1)
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
//                        selectedCategory = "الكل"
//                        storeListVM.getAll()
                        
                        
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

struct SearchBar_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var selectedCategory = "الكل"
    @State static var isSearching = false
    
    
    static var previews: some View {
        SearchBar(searchText: $searchText, isSearching: $isSearching, selectedCategory: $selectedCategory)
    }
}
