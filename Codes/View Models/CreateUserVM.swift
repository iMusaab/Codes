//
//  CreateUserVM.swift
//  Codes
//
//  Created by Musab Aljarba on 21/09/1442 AH.
//

import Foundation
import Firebase

class CreateUserViewModel: ObservableObject {
    var db = Firestore.firestore()
    @Published var defaults = UserDefaults.standard
    var signedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    var newUser: User?
    
    func checkUserAgainstDatabase(completion: @escaping (Result<User?, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUser.getIDTokenForcingRefresh(true, completion:  { (idToken, error) in
          if let error = error {
            completion(.failure(error))
            print(error.localizedDescription)
          } else {
            completion(.success(nil))
          }
        })
      }
    
    func CreateUser(completion: @escaping (Result<User?, Error>) -> Void) {
        
        
        
        Auth.auth().signInAnonymously() { [self] (authResult, error) in
            // ...
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                guard let user = authResult?.user else { return }
                let id = user.uid
                let isAnonymous = user.isAnonymous  // true
                self.defaults.setValue(user.uid, forKey: "userId")
                let calendar = Calendar.current
                let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: Date())
                self.newUser = User(userID: id, timeStamp: twoDaysAgo ?? Date(timeIntervalSinceReferenceDate: -123456789.0))
                
                completion(.success(self.newUser))
                if self.newUser != nil {
                    do {
                        try self.db.collection("users").document(id).setData(from: self.newUser)
                    } catch let error {
                        print("Error writing user to Firestore: \(error)")
                    }
                }
                
                
            }
        }
    }
}
