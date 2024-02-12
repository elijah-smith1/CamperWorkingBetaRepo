//
//  searchViewModel.swift
//  OnCampApp
//
//  Created by Elijah Smith on 11/18/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class searchViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init(){
        fetchUsers()
    }
    func fetchUsers(){
        
        
        Userdb.getDocuments {snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            print(documents)
            self.users = documents.compactMap({ try? $0.data(as: User.self)})
            print("Debug:: \(self.users)")
            
        }
    }
    
}
