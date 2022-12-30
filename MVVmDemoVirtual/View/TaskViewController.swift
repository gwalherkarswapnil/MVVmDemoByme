//
//  TaskViewController.swift
//  MVVmDemoVirtual
//
//  Created by Apple on 30/12/22.
//

import UIKit
class TaskViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let taskViewModel = TaskViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        taskViewModel.getUserDataList { success in
            if success {
                self.reloadTableView()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }


}

extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : taskViewModel.listOfUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCollectionTableViewCell") as? UserListCollectionTableViewCell else { return UITableViewCell()}
            cell.setData(data: taskViewModel.listOfUser)
            return cell
        }
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.cellID) as? UserListTableViewCell else { return UITableViewCell()}
        let user = taskViewModel.listOfUser[indexPath.row]
        cell.setCellData(user: user)
        return cell
    }
}
