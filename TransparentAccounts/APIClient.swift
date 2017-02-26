//
//  APIClient.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 26/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import Foundation

protocol APIClient : class {
    func loadAccounts(callback: @escaping (_ accounts: [Account]?, _ error: String?) -> ())
    func loadAccount(accountId: String, callback: @escaping (_ account: Account?, _ error: String?) -> ())
}
