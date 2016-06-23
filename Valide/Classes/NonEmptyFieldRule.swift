//
//  NonEmptyFieldRule.swift
//  Valide
//
//  Created by Sidney De Koning on 18-08-15.
//  Copyright (c) 2015 Sidney De Koning. All rights reserved.
//

import Foundation

class NonEmptyFieldRule: Enforceable {

    var error: String = "Field can not be empty"

    func enforce(input: String) -> Bool {
        return !input.isEmpty
    }
}
