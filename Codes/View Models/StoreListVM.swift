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
    
    func getAll() {
        
        fireStoreManager.getAllStores { result in
            switch result {
            case .success(let stores):
                if let stores = stores {
                    DispatchQueue.main.async {
                        self.stores = stores.map(StoreViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

struct StoreViewModel {
    let store: Store
    
    var storeId: String {
        store.id ?? ""
    }
    
    var name: String {
        store.name
    }
    
    var picture: String {
        store.picture
    }
    
    var codes: [String] {
        store.codes ?? []
    }
}
