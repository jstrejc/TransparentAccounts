//
//  Account.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 22/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import Foundation

struct Account {
    let accountNumber: String
    let bankCode: String
    let transparencyFrom: Date
    let transparencyTo: Date
    let publicationTo: Date
    let actualizationDate: Date
    let balance: Double
    let currency: String
    let iban: String
    let name: String
    let description: String
    
    init?(_ json: [String: Any]) {
        guard let accountNumber   = json["accountNumber"] as? String,
            let bankCode          = json["bankCode"] as? String,
            let transparencyFrom  = DateConverter.dateFromString(json["transparencyFrom"] as? String),
            let transparencyTo    = DateConverter.dateFromString(json["transparencyTo"] as? String),
            let publicationTo     = DateConverter.dateFromString(json["publicationTo"] as? String),
            let actualizationDate = DateConverter.dateFromString(json["actualizationDate"] as? String),
            let balance           = json["balance"] as? NSNumber,
            let currency          = json["currency"] as? String,
            let iban              = json["iban"] as? String
        else {
            return nil
        }
        
        self.accountNumber     = accountNumber
        self.bankCode          = bankCode
        self.transparencyFrom  = transparencyFrom
        self.transparencyTo    = transparencyTo
        self.publicationTo     = publicationTo
        self.actualizationDate = actualizationDate
        self.balance           = Double(balance)
        self.currency          = currency
        self.iban              = iban
        self.name              = json["name"] as? String ?? ""
        self.description       = json["description"] as? String ?? ""
    }
    
    
}
