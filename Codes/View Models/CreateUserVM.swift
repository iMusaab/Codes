//
//  CreateUserVM.swift
//  Codes
//
//  Created by Musab Aljarba on 21/09/1442 AH.
//

import Foundation
import Firebase

class CreateUserViewModel: ObservableObject {
    
    @Published var defaults = UserDefaults.standard
    
    func CreateUser(completion: @escaping (Result<User?, Error>) -> Void) {
        
        Auth.auth().signInAnonymously() { (authResult, error) in
          // ...
          
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let user = authResult?.user else { return }
                let isAnonymous = user.isAnonymous  // true
                self.defaults.setValue(user.uid, forKey: "userId")
            }
        }
        
    }
}
