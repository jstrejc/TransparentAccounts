//
//  JSONObject.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 22/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import XCTest
@testable import TransparentAccounts

class AccountTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateAccount() {
        let account: [String : Any] = [
            "accountNumber": "000000-2906478309",
            "bankCode": "0800",
            "transparencyFrom": "2016-08-18T11:33:24",
            "transparencyTo": "3000-01-01T00:00:00",
            "publicationTo": "3000-01-01T00:00:00",
            "actualizationDate": "2015-09-07T10:00:06",
            "balance": 1063961,
            "currency": "CZK",
            "iban": "CZ13 0800 0000 0029 0647 8309",
            "name": "accountWithName",
            "description": "accountWithDescription"
        ]
        
        let result: Account? = Account(account)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.accountNumber, "000000-2906478309")
        XCTAssertEqual(result?.bankCode, "0800")
        XCTAssertEqual(result?.transparencyFrom, DateConverter.dateFromString("2016-08-18T11:33:24"))
        XCTAssertEqual(result?.transparencyTo, DateConverter.dateFromString("3000-01-01T00:00:00"))
        XCTAssertEqual(result?.publicationTo, DateConverter.dateFromString("3000-01-01T00:00:00"))
        XCTAssertEqual(result?.actualizationDate, DateConverter.dateFromString("2015-09-07T10:00:06"))
        XCTAssertEqual(result?.balance, 1063961)
        XCTAssertEqual(result?.currency, "CZK")
        XCTAssertEqual(result?.iban, "CZ13 0800 0000 0029 0647 8309")
        XCTAssertEqual(result?.description, "accountWithDescription")
    }
    
    func testCreateAccountWithoutNameAndDescription() {
        let accountWithoutNameAndDescription: [String : Any] = [
            "accountNumber": "000000-2906478309",
            "bankCode": "0800",
            "transparencyFrom": "2016-08-18T00:00:00",
            "transparencyTo": "3000-01-01T00:00:00",
            "publicationTo": "3000-01-01T00:00:00",
            "actualizationDate": "2016-09-07T10:00:06",
            "balance": 1063961.87,
            "currency": "CZK",
            "iban": "CZ13 0800 0000 0029 0647 8309"
        ]
        
        let result: Account? = Account(accountWithoutNameAndDescription)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "")
        XCTAssertEqual(result?.description, "")
    }
    
    func testCreateaAcountWithoutDescription() {
        let accountWithoutDescription: [String : Any] = [
            "accountNumber": "000000-2906478309",
            "bankCode": "0800",
            "transparencyFrom": "2016-08-18T00:00:00",
            "transparencyTo": "3000-01-01T00:00:00",
            "publicationTo": "3000-01-01T00:00:00",
            "actualizationDate": "2016-09-07T10:00:06",
            "balance": 1063961.87,
            "currency": "CZK",
            "iban": "CZ13 0800 0000 0029 0647 8309",
            "name": "accountWithName"
        ]
        
        let result: Account? = Account(accountWithoutDescription)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "accountWithName")
        XCTAssertEqual(result?.description, "")
    }
    
    func testCreateAccountWithInvalidDate() {
        let accountWithInvalidDate: [String : Any] = [
            "accountNumber": "000000-2906478309",
            "bankCode": "0800",
            "transparencyFrom": "2016-08-18T00:00:00",
            "transparencyTo": "3000-01-01T00:00:00",
            "publicationTo": "3000-01-01T00:00:00",
            "actualizationDate": "2016-09-07Tasdf",
            "balance": 1063961.87,
            "currency": "CZK",
            "iban": "CZ13 0800 0000 0029 0647 8309",
            "name": "accountWithName",
            "description": "accountWithDescription"
        ]
        
        let result: Account? = Account(accountWithInvalidDate)
        XCTAssertNil(result)
    }
    
    func testCreateAccountWithMissingBalance() {
        let accountWithMissingBalance: [String : Any] = [
            "accountNumber": "000000-2906478309",
            "bankCode": "0800",
            "transparencyFrom": "2016-08-18T00:00:00",
            "transparencyTo": "3000-01-01T00:00:00",
            "publicationTo": "3000-01-01T00:00:00",
            "actualizationDate": "2016-09-07T10:00:06",
            "currency": "CZK",
            "iban": "CZ13 0800 0000 0029 0647 8309",
            "name": "accountWithName",
            "description": "accountWithDescription"
        ]
        
        let result: Account? = Account(accountWithMissingBalance)
        XCTAssertNil(result)
    }
}
