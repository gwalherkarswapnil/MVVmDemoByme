//
//  TaskViewModel.swift
//  MVVmDemoVirtual
//
//  Created by Apple on 30/12/22.
//

import Foundation
import UIKit
 let urlForApi = "http://44.209.224.33/testhobbyist/index.php/api/getImageGallery"
class TaskViewModel: NSObject {
    var listOfUser = [UserModel]()
    
    override init(){
        super.init()
    }
    
    func getUserDataList(completion:@escaping ((Bool)-> () )){
        guard let urlForData = URL(string: urlForApi) else { return }
        // Create the network manager
        let networkManager = NetworkManager()

        // Request data from the backend
        networkManager.request(fromURL: urlForData) { (result: Result<DataModel, Error>) in
            switch result {
            case .success(let users):
                debugPrint("We got a successful result with \(users.data.count) users.")
                self.listOfUser = users.data
                completion(true)
            case .failure(let error):
                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
            }
         }


    }
    
  
}
