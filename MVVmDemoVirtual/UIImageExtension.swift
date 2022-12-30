//
//  UIImageExtension.swift
//  MVVmDemoVirtual
//
//  Created by Apple on 30/12/22.
//

import Foundation
import  UIKit
extension UIImage {
    
    static func setImageFromURL (url: String, imageV: UIImageView)  {
        let url = URL(string: url)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                imageV.image = UIImage(data: data!)!
            }
        }
    }
 
}
