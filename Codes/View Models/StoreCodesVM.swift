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
        storeCode.votedBy
    }
    
    var code: String {
        storeCode.code
    }
    
    var url: String {
        storeCode.url
    }
}

class StoreCodeListViewModel: ObservableObject {
    
    private var firestoreManager: FirestoreManager = FirestoreManager()
    var storeCodeName: String = ""
    @Published var store: StoreViewModel?
    @Published var storeCodes: [StoreCodeViewModel] = []
    @Published var storeSpecialCode: [StoreCodeViewModel] = []
    @Published var voteSaved: Bool = false
    @Published var enableVote: [Bool] = []
    @Published var isDisabled : Bool = false
    
    @Published var specialCodeSaved = false
    @Published var normalCodeSaved = false
    
    @Published var codesLoaded = false
    
    
    
    
    func createSpecialCode(storeId: String) {
        firestoreManager.addStoreSpecialCode(storeId: storeId)
    }
    
    func updateCodeVotes(storeId: String, storeCodeId: String, userId: String, upOrDown: codeVote) {
        
        firestoreManager.updateCodeVotes(storeId: storeId, storeCodeId: storeCodeId, userId: userId, upOrDown: upOrDown) { result in
            switch result {
            case .success(_):
                self.voteSaved = true
                print("votes saved: \(self.isDisabled)")
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    func getStoreSpecialCodeByStoreId(storeId: String, userId: String) {
        firestoreManager.getStoreSpecialCodeBy(storeId: storeId) { result in
            switch result {
            case .success(let specialCode):
                
                
                if let specialCode = specialCode {
                    DispatchQueue.main.async {
                        self.storeSpecialCode = specialCode.map(StoreCodeViewModel.init)
                        self.specialCodeSaved = true
//                        print("Success in storeCodeVM file in getStoreSpecialCodesByStoreId", self.storeSpecialCode)
                        
                    }
                }
            case .failure(let error):
                print("Error in storeCodeVM file in getStoreSpecialCodesByStoreId: \(error.localizedDescription)")
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
                            if code.votedBy.contains(userId) {
                                enableVote.append(true)
                            } else {
                                enableVote.append(false)
                            }
                    }
                    DispatchQueue.main.async {
                        self.storeCodes = codes.map(StoreCodeViewModel.init)
                        self.enableVote = enableVote
                        self.isDisabled = false
                        self.normalCodeSaved = true
                        print("Got storeCodeVM file in getStoreCodesByStoreId")
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

