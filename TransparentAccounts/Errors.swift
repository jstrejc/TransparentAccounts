//
//  Errors.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 26/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import Foundation

enum ParsingError: Error {
    case invalidFormat(message: String)
}
