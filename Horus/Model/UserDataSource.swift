//
//  UserDataSource.swift
//  Horus
//
//  Created by Kerem Girenes on 9.01.2023.
//
//  This Data Source reads from and writes
//  to username-password table in DB
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class UserDataSource: ObservableObject {
    
    private let ref = Database.database(url: "https://horus-weather-app-8eb89-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    
    func pushUsernamePasswordToDB(username: String, password: String){
        self.ref.child("username-password").child(username).setValue(password)
    }
    
    func checkUsernamePasswordExists(username: String, password: String, completion: @escaping (Bool) -> Void) {
        ref.child("username-password").child(username).observe(.value) { snapshot in
            if snapshot.exists() {
                if password == snapshot.value as! String {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
}
