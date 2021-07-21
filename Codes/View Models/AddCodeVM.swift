//
//  AddStoreVM.swift
//  Codes
//
//  Created by Musab Aljarba on 18/09/1442 AH.
//

import Foundation
import Firebase

struct StoreCodesViewState {
    var title: String = ""
    var Description: String = ""
    var votes: Int = 0
    var votedBy: [String] = []
    var isEnabled: Bool = false
    var DateCreated: Date = Date()
    var code: String = ""
}



class AddCodeViewModel: ObservableObject {
    
    private var fireStoreManager: FirestoreManager = FirestoreManager()
    @Published var saved: Bool = false
    @Published var message = ""
    @Published var store: StoreViewModel?
    @Published var defaults = UserDefaults.standard
    @Published var showErrorMessage = false
    
    var storeCodeVS = StoreCodesViewState()
    
    
    func addCodeToStore(storeId: String, storeCodeVS: StoreCodesViewState, completion: @escaping (Error?) -> Void) {
        
        let storeCode = StoreCode.from(storeCodeVS)
        fireStoreManager.updateStore(storeId: storeId, storeCode: storeCode) { result in
            switch result {
            case .success(_):
                completion(nil)
                self.fireStoreManager.updateUserTimeStamp(userId: Auth.auth().currentUser?.uid ?? self.defaults.string(forKey: "userId") ?? "") { result in
                    
                }
                self.saved = true
            case .failure(let error):
                print("Error Adding a code to firestore", error)
                self.showErrorMessage = true
                completion(error)
                
            }
        }
    }
//    func addCodesToStore(storeId: String) {
//
//        fireStoreManager.updateStore(storeId: storeId, values: ["codes" : [storeCodeName]]) { result in
//
//            switch result {
//                case .success(let storeModel):
//                if let model = storeModel {
//                    DispatchQueue.main.async {
//                        self.store = StoreViewModel(store: model)
//                        self.saved = storeModel == nil ? false : true
//                    }
//                }
//                case .failure(let error):
//                print(error.localizedDescription)
//                    self.message = "Unable to save your code"
//            }
//        }
//    }

}
