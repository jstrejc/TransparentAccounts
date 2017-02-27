//
//  AccountViewController.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 26/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var iban: UILabel!
    @IBOutlet weak var transparentFrom: UILabel!
    @IBOutlet weak var transparentTo: UILabel!
    @IBOutlet weak var publicationTo: UILabel!
    @IBOutlet weak var actualized: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    
    var account: Account? = nil {
        didSet {
            refreshUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshUI() {
        if let account = self.account {
            self.name?.text = account.name
            self.accountNumber?.text = "\(account.accountNumber)/\(account.bankCode)"
            self.balance?.text = "\(account.balance)"
            self.currency?.text = account.currency
            self.iban?.text = account.iban
            self.publicationTo?.text = formateDate(account.publicationTo)
            self.transparentFrom?.text = formateDate(account.transparencyFrom)
            self.transparentTo?.text = formateDate(account.transparencyTo)
            self.actualized?.text = formateDate(account.actualizationDate)
            self.descriptionText?.text = account.description
        }
    }
    
    func formateDate(_ date: Date) -> String {
        return "\(DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short))"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
