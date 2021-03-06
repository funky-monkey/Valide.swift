//
//  NonEmptyFieldRule.swift
//  Valide
//
//  Created by Sidney De Koning on 18-08-15.
//  Copyright (c) 2015 Sidney De Koning. All rights reserved.
//

import Foundation

public class NonEmptyFieldRule: Enforceable {

    public var error: String = "Field can not be empty"

    public func enforce(_ input: String) -> Bool {
        return !input.isEmpty
    }
}
