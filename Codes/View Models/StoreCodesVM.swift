//
//  StoreCodesVM.swift
//  Codes
//
//  Created by Musab Aljarba on 18/09/1442 AH.
//

import Foundation


struct StoreCodeViewModel: Hashable {
    static func == (lhs: StoreCodeViewModel, rhs: StoreCodeViewModel) -> Bool {
        return lhs.storeCodeId == rhs.storeCodeId
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(storeCodeId)
    }
    
    
    let storeCode: StoreCode
    
    var storeCodeId: String {
        storeCode.id ?? ""
    }
    
    var title: String {
        storeCode.title
    }
    
    var Description: String {
        storeCode.Description
    }
    
    var votes: Int {
        storeCode.votes
    }
    
    var votedBy: [String] {
        storeCode.votedBy ?? []
    }
}

class StoreCodeListViewModel: ObservableObject {
    
    private var firestoreManager: FirestoreManager = FirestoreManager()
    var storeCodeName: String = ""
    @Published var store: StoreViewModel?
    @Published var storeCodes: [StoreCodeViewModel] = []
    @Published var saved: Bool = false
    @Published var enableVote: [Bool] = []
    
    
    
    
    
    func updateCodeVotes(storeId: String, storeCodeId: String, userId: String, upOrDown: codeVote) {
        
        firestoreManager.updateCodeVotes(storeId: storeId, storeCodeId: storeCodeId, userId: userId, upOrDown: upOrDown) { result in
            switch result {
            case .success(_):
                self.saved = true
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    func getStoreCodesByStoreId(storeId: String, userId: String) {
        var enableVote: [Bool] = []
        firestoreManager.getStoreCodesBy(storeId: storeId) { result in
            switch result {
            case .success(let codes):
                
                
                if let codes = codes {
                    for code in codes {
                        if let votedBy = code.votedBy {
                            if votedBy.contains(userId) {
                                enableVote.append(true)
                            } else {
                                enableVote.append(false)
                            }
                            
                        }
                    }
                    DispatchQueue.main.async {
                        self.storeCodes = codes.map(StoreCodeViewModel.init)
                        self.enableVote = enableVote
                    }
                }
            case .failure(let error):
                print("Error in storeCodeVM file in getStoreCodesByStoreId: \(error.localizedDescription)")
            }
        }
    }
    
    
    func getStoreById(storeId: String) {
        
        firestoreManager.getStoreById(storeId: storeId) { result in
            switch result {
            case . success(let store):
                if let store = store {
                    DispatchQueue.main.async {
                        self.store = StoreViewModel(store: store)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func addCodesToStore(storeId: String) {
//        
//        firestoreManager.updateStore(storeId: storeId, values: ["codes" : [storeCodeName]]) { result in
//            
//            switch result {
//                case .success(let storeModel):
//                if let model = storeModel {
//                    DispatchQueue.main.async {
//                        self.store = StoreViewModel(store: model)
//                    }
//                }
//                case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
}

