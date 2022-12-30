//
//  UserListCollectionTableViewCell.swift
//  MVVmDemoVirtual
//
//  Created by Apple on 31/12/22.
//

import UIKit

class UserListCollectionTableViewCell: UITableViewCell {
    var listOfUser = [UserModel]()
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(data: [UserModel])  {
        listOfUser = data
        collectionView.reloadData()
    }

}


extension UserListCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout   , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listOfUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.cellID, for: indexPath) as? UserCollectionViewCell else { return UICollectionViewCell()}
        let user = self.listOfUser[indexPath.row]
        cell.setCellData(user: user)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 100)
    }
    
    
}
