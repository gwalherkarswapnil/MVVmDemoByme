//
//  UserModel.swift
//  MVVmDemoVirtual
//
//  Created by Apple on 30/12/22.
//

import Foundation
import UIKit
struct UserModel: Codable {
    let title: String?
    let descriptionStr: String?
    let image_url: String?
    private enum CodingKeys : String, CodingKey {
        case  title = "title"
        case descriptionStr = "description"
        case image_url = "image_url"
    }
}


