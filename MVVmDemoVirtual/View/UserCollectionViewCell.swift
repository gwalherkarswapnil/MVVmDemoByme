//
//  UserCollectionViewCell.swift
//  MVVmDemoVirtual
//
//  Created by Apple on 30/12/22.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    public static var cellID = "UserCollectionViewCell"
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        userImg.layer.cornerRadius = userImg.frame.height/2
        userImg.layer.masksToBounds = true
        // Initialization code
    }

    func setCellData(user: UserModel) {
        titleLbl.text = user.title ?? ""
        descriptionLbl.text  = user.descriptionStr ?? ""
        guard  (user.image_url != nil) else {
            return
        }
        UIImage.setImageFromURL(url: user.image_url ?? "", imageV: userImg)
    }

}
