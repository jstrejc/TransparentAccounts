//
//  DateConverterTest.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 26/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import Foundation

import XCTest
@testable import TransparentAccounts

class DateConverterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidDateConverion() {
        let date = DateConverter.dateFromString("2016-08-18T11:33:24")
        XCTAssertNotNil(date)
        XCTAssertEqual(date, Date(timeIntervalSince1970: 1471520004))
    }
    
    func testValidISODateConverion() {
        let date = DateConverter.dateFromString("2016-08-18T11:33:24+00:00")
        XCTAssertNotNil(date)
        XCTAssertEqual(date, Date(timeIntervalSince1970: 1471520004))
    }
    
    func testInvalidDateConverion() {
        let date = DateConverter.dateFromString("2016-08-18T11:33:asd")
        XCTAssertNil(date)
    }
    
    func testNilConverion() {
        let date = DateConverter.dateFromString(nil)
        XCTAssertNil(date)
    }
}
