//
//  StoreListVM.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import Foundation

class StoreListViewMode: ObservableObject {
    
    private var fireStoreManager: FirestoreManager = FirestoreManager()
    @Published var stores: [StoreViewModel] = []
    
    @Published var storesSaved = false
    
    func getStoreImageFromFirebase() {
        fireStoreManager.loadImageFromFirebase()
    }
    
    func addDocumentToFirestore() {
        fireStoreManager.addDocumentToFirestore()
    }
    
    func getAll() {
        
        fireStoreManager.getAllStores { result in
            switch result {
            case .success(let stores):
                if let stores = stores {
                    DispatchQueue.main.async {
                        self.stores = stores.map(StoreViewModel.init)
                        print("stores saved successfully")
                        self.storesSaved = true
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

struct StoreViewModel: Identifiable {
    
    
    let store: Store
    
    var id: String { // has been named id instead of storeid in order to conform to identifible
        store.id ?? ""
    }
    
    var name: String {
        store.name
    }
    
    var picture: String {
        store.picture
    }
    
    var onlinePicture: String {
        store.onlinePicture
    }
    
    var codes: [String] {
        store.codes ?? []
    }
    
    var category: [String] {
        store.category
    }
    
    var timeAscending: Date {
        store.timeAscending
    }
}
