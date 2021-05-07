//
//  FireStoreManager.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirestoreManager {
    
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func updateCodeVotes(storeId: String, storeCodeId: String, userId: String, upOrDown: codeVote, completion: @escaping (Result<[StoreCode]?, Error>) -> Void) {
        
        let codeRef = db.collection("stores")
            .document(storeId)
            .collection("codes")
            .document(storeCodeId)

        switch upOrDown {
        case .up:
            codeRef.updateData(
                [
                    "votes": FieldValue.increment(Int64(1)),
                    "votedBy": FieldValue.arrayUnion([userId])
                ])
            self.getStoreCodesBy(storeId: storeId) { result in
                    switch result {
                    case .success(let codes):
                        if let codes = codes {
                            completion(.success(codes))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
            }
        case .down:
            codeRef.updateData(
                [
                    "votes": FieldValue.increment(Int64(-1)),
                    "votedBy": FieldValue.arrayUnion([userId])
                ])
        }
    
    }
    
    func getStoreCodesBy(storeId: String, completion: @escaping (Result<[StoreCode]?, Error>) -> Void) {
        
        db.collection("stores")
            .document(storeId)
            .collection("codes")
            .order(by: "votes", descending: true)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let codes: [StoreCode]? = snapshot.documents.compactMap { doc in
                            var storeCode = try? doc.data(as: StoreCode.self)
                            storeCode?.id = doc.documentID
                            return storeCode
                        }
                        completion(.success(codes))
                    }
                }
            }
    }
    
    func getStoreById(storeId: String, completion: @escaping (Result<Store?, Error>) -> Void) {
        
        let ref = db.collection("stores").document(storeId)
        
        ref.getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let snapshot = snapshot {
                    var store: Store? = try? snapshot.data(as: Store.self)
                    if store != nil {
                        store!.id = snapshot.documentID
                        completion(.success(store))
                    }
                }
            }
        }
    }
    
    func updateStore(storeId: String, storeCode: StoreCode, completion: @escaping (Result<Store?, Error>) -> Void) {
            do {
    
                let _ = try db.collection("stores").document(storeId).collection("codes").addDocument(from: storeCode)
    
                self.getStoreById(storeId: storeId) { result in
                    switch result {
                    case .success(let store):
                        completion(.success(store))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    
            } catch let error {
                completion(.failure(error))
            }
        }
    

    
    func getAllStores(completion: @escaping (Result<[Store]?, Error>) -> Void) {
        
        db.collection("stores").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let snapshot = snapshot {
                    let stores: [Store]? = snapshot.documents.compactMap { doc in
                        var store = try? doc.data(as: Store.self)
                        if store != nil {
                            store!.id = doc.documentID
                        }
                        return store
                    }
                    
                    completion(.success(stores))
                }
            }
        }
    }
    
//    func getStoreById(storeId: String, completion: @escaping (Result<Store?, Error>) -> Void) {
//
//        let ref = db.collection("stores").document(storeId)
//
//        ref.getDocument { (snapshot, error) in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                if let snapshot = snapshot {
//                    var store: Store? = try? snapshot.data(as: Store.self)
//                    if store != nil {
//                        store!.id = snapshot.documentID
//                        completion(.success(store))
//                    }
//                }
//            }
//        }
//    }
//
//    func updateStore(storeId: String, storeCode: StoreCode, completion: @escaping (Result<Store?, Error>) -> Void) {
//        do {
//
//            let _ = try db.collection("stores").document(storeId).collection("items").addDocument(from: storeCode)
//
//            self.getStoreById(storeId: storeId) { result in
//                switch result {
//                case .success(let store):
//                    completion(.success(store))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//
//    func updateStore(storeId: String, values: [AnyHashable: Any], completion: @escaping (Result<Store?, Error>) -> Void) {
//
//        let ref = db.collection("stores").document(storeId)
//
//        ref.updateData(
//            ["codes": FieldValue.arrayUnion((values["codes"] as? [String]) ?? [])]
//        ) { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//
//                self.getStoreById(storeId: storeId) { result in
//                    switch result {
//                    case .success(let store):
//                        completion(.success(store))
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                }
//            }
//        }
//    }
}
