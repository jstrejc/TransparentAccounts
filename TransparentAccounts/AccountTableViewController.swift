//
//  AccountTableViewController.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 26/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import UIKit

protocol AccountSelectedDelegate : class {
    func accountSelected(account: Account)
}

class AccountTableViewController: UITableViewController {
    @IBOutlet weak var accountsTable: UITableView!
    
    var accountsApi: APIClient = CSAPIClient()
    var accounts: [Account] = []

    weak var accountSelectedDelegate: AccountSelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accounts.count
    }

    @IBAction func doRefresh(_ sender: UIBarButtonItem) {
        reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! AccountCell
        let account = accounts[indexPath.row]
        
        cell.name.text = account.name
        cell.number.text = "\(account.accountNumber)/\(account.bankCode)"
        cell.balance.text = "\(account.balance.rounded()) \(account.currency)"

        return cell
    }
 
    func reloadData() {
        accountsApi.loadAccounts { accounts, error in
            if let accounts = accounts {
                self.accounts = accounts
            }
            else {
                self.accounts = []
            }
            DispatchQueue.main.async {
                self.accountsTable.reloadData()
                if !self.accounts.isEmpty {
                    self.accountSelectedDelegate?.accountSelected(account: self.accounts[0])
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let accountSelectedDelegate = self.accountSelectedDelegate {
            if let detailViewController = accountSelectedDelegate as? AccountTabBarViewController {
                splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
            }
            accountSelectedDelegate.accountSelected(account: self.accounts[accountsTable.indexPathForSelectedRow!.row])
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // let destination = segue.destination
        // Pass the selected object to the new view controller.
    }
    */

}
