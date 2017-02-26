//
//  CSAPIClient.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 26/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import Foundation

class CSAPIClient : APIClient {
    private static let API_KEY = "9ec4648f-0b1a-468d-8d65-e457536de903"
    
    func loadAccounts(callback: @escaping (_ accounts: [Account]?, _ error: String?) -> ()) {
        let url = URL(string: "https://api.csas.cz/sandbox/webapi/api/v2/transparentAccounts")!
        var request = URLRequest(url: url)
        request.addValue(CSAPIClient.API_KEY, forHTTPHeaderField: "WEB-API-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, communicationError in
            if let _ = response, let data = data {
                do {
                    let accounts = try self.parseAccountsFromJSON(data: data)
                    callback(accounts, nil)
                }
                catch ParsingError.invalidFormat(let message) {
                    callback(nil, message)
                }
                catch {
                    callback(nil, error.localizedDescription)
                }
            }
            else {
                callback(nil, "Failed to get response from server: \(communicationError)")
            }
        }
        task.resume()
    }
    
    func loadAccount(accountId: String, callback: @escaping (_ account: Account?, _ error: String?) -> ()) {
        let url = URL(string: "https://api.csas.cz/sandbox/webapi/api/v2/transparentAccounts/\(accountId)")!
        var request = URLRequest(url: url)
        request.addValue(CSAPIClient.API_KEY, forHTTPHeaderField: "WEB-API-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, communicationError in
            if let _ = response, let data = data {
                do {
                    let account = try self.parseAccountFromJSON(data: data)
                    callback(account, nil)
                }
                catch ParsingError.invalidFormat(let message) {
                    callback(nil, message)
                }
                catch {
                    callback(nil, error.localizedDescription)
                }
            }
            else {
                callback(nil, "Failed to get response from server: \(communicationError)")
            }
        }
        task.resume()
    }
    
    func parseAccountsFromJSON(data: Data) throws -> [Account] {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let jsonRoot = json as? [String: Any]
        else {
            throw ParsingError.invalidFormat(message: "Failed to parse root JSONObject from data")
        }
        guard let accounts = jsonRoot["accounts"] as? [[String:Any]]
        else {
            throw ParsingError.invalidFormat(message: "Failed to parse accounts array from data")
        }
        return accounts.flatMap { (account) in
            return Account(account)
        }
    }
    
    func parseAccountFromJSON(data: Data) throws -> Account? {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let account = json as? [String: Any]
        else {
            throw ParsingError.invalidFormat(message: "Failed to parse root JSONObject from data")
        }
        return Account(account)
    }
}
