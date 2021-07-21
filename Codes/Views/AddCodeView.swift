//
//  AddCodeView.swift
//  Codes
//
//  Created by Musab Aljarba on 18/09/1442 AH.
//

import SwiftUI
import Combine

struct AddCodeView: View {
    @Environment(\.presentationMode) var presentaionMode
    @StateObject private var addCodeVM = AddCodeViewModel()
    @StateObject private var storeCodeListVM = StoreCodeListViewModel()
    @Environment(\.layoutDirection) var layoutDirection
    
    @State private var storeCodeVS = StoreCodesViewState()
    
    @ObservedObject private var regesterVM = CreateUserViewModel()
    
    @Binding var newCodeSaved: Bool
    
//    @State private var showingAlert: Bool = false
    
    
    
    
    
    private var addButtonDisabled: Bool {
        return storeCodeVS.title.isEmpty || storeCodeVS.Description.isEmpty || storeCodeVS.code.isEmpty || storeCodeVS.title.count > 12 || storeCodeVS.Description.count > 50 || storeCodeVS.code.count > 6
    }
    
    init(store: StoreViewModel, newCodeSaved: Binding<Bool>) {
        self.store = store
//        UITableView.appearance().backgroundColor = .clear
        
        self._newCodeSaved = newCodeSaved
    }
    
    
    let store: StoreViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading , spacing: 34) {
                    VStack(alignment: .leading) {
                        Text("العنوان").font(.headline).foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                        
                            TextField("مثال: خصم ١٠٪ ", text: $storeCodeVS.title)
                                .font(.callout)
                                .padding(.leading, 10)
                                .frame(width: geometry.size.width * 0.9, height: 50, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(storeCodeVS.title.count > 12 ? Color.red : Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)), lineWidth: 0.8))
//                                .disabled(storeCodeVS.title.count > 12)
                        
                        Text("بحد اقصى ١٢ حرف")
                            .font(.caption)
                            .foregroundColor(storeCodeVS.title.count > 12 ? Color.red : .secondary)
                        
                    }
                    
                    
                        VStack(alignment: .leading) {
                            Text("الوصف").font(.headline).foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                            
                                TextField("وصف مختصر للخصم", text: $storeCodeVS.Description)
                                    .font(.callout)
                                    .padding(.leading, 10)
                                    .padding(.top, 10)
                                    .frame(width: geometry.size.width * 0.9, height: 50, alignment: .top)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(storeCodeVS.Description.count > 50 ? Color.red : Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)), lineWidth: 0.8))
                            
                            Text("بحد اقصى ٥٠ حرف")
                                .font(.caption)
                                .foregroundColor(storeCodeVS.Description.count > 50 ? Color.red : .secondary)
                        }
                    
                    VStack(alignment: .leading) {
                        Text("كود الخصم").font(.headline).foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                        
                            TextField("الكود", text: $storeCodeVS.code)
                                .font(.callout)
                                .padding(.leading, 10)
                                .frame(width: geometry.size.width * 0.9, height: 50, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(storeCodeVS.code.count > 6 ? Color.red : Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)), lineWidth: 0.8))
                        
                        Text("بحد اقصى ٦ أحرف")
                            .font(.caption)
                            .foregroundColor(storeCodeVS.code.count > 6 ? Color.red : .secondary)
                    }
                    
                        
                } .padding(.top, 60)
                .modifier(DismissingKeyboard())
                Button(action: {
                    
                    addCodeVM.addCodeToStore(storeId: store.id, storeCodeVS: storeCodeVS) { error in
                                            if error == nil {
                                                storeCodeVS = StoreCodesViewState()
                                                storeCodeListVM.getStoreCodesByStoreId(storeId: store.id, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
                                            }
                                        }
                    
//                                        Text(addCodeVM.message)
                }, label: {
                    HStack {
                        Text("أضف")
                            .font(.system(size: 20)).bold()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width * 0.5, height: 50)
                            .background(addButtonDisabled ? Color(#colorLiteral(red: 0.8078431373, green: 0.8156862745, blue: 0.8078431373, alpha: 1)) : Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
                            .cornerRadius(10)
                            .shadow(color:addButtonDisabled ? Color(.clear) : Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)).opacity(0.25), radius: 10, x: 0, y: 5)
                    }
                })
                .padding(.top, 60)
                .disabled(addButtonDisabled)
            }
            .alert(isPresented: $addCodeVM.showErrorMessage) {
                        Alert(title: Text("لم تتم الإضافة 💔"), message: Text("يمكنك إضافة كوبون واحد فقط في الساعة!"), dismissButton: .default(Text("موافق")))
                    }
            .onChange(of: addCodeVM.showErrorMessage) { value in
                if value {
                    storeCodeVS.title = ""
                    storeCodeVS.Description = ""
                    storeCodeVS.code = ""
                }
            }
                    .onChange(of: addCodeVM.saved) { value in
                        if value {
                            newCodeSaved = true
                            presentaionMode.wrappedValue.dismiss()
                            
                        }
                    }
                    .navigationBarItems(leading: Button(action: {
                        presentaionMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                    }))
                    .navigationBarTitle("أضف كود خصم", displayMode: .inline)
            
            
                    .embedInNavigationView()
                .environment(\.layoutDirection, .rightToLeft)
            
            
            
        }
        
    }
}

struct AddCodeView_Previews: PreviewProvider {
    @State static var newCodeSaved = false
    
    static var previews: some View {
        AddCodeView(store: StoreViewModel(store: Store(id: "", name: "", picture: "", onlinePicture: "", codes: nil, category: [], timeAscending: Date())), newCodeSaved: $newCodeSaved)
    }
}

//                TextField("Enter Description", text: $storeCodeVS.Description)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
//
//                Button("Save") {
//                    addCodeVM.addCodeToStore(storeId: store.storeId, storeCodeVS: storeCodeVS) { error in
//                        if error == nil {
//                            storeCodeVS = StoreCodesViewState()
//                            storeCodeListVM.getStoreCodesByStoreId(storeId: store.storeId, userId: regesterVM.defaults.string(forKey: "userId") ?? "")
//                        }
//                    }
//
//                    Text(addCodeVM.message)
//                }
//                .disabled(storeCodeVS.title.isEmpty || storeCodeVS.Description.isEmpty)
