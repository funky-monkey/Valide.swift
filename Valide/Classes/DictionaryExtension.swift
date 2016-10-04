//
//  Dictionary.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation
import Swift

extension Dictionary {
    
    
    /**
    Checks if a key exists in the dictionary.
    
    - parameter key: Key to check
    - returns: true if the key exists
    */
    func has (_ key: Key) -> Bool {
        return self.index(forKey: key) != nil
    }
    
    /**
    Creates an Array with values generated by running
    each [key: value] of self through the mapFunction.
    
    - parameter mapFunction:
    - returns: Mapped array
    */
    public func toArray <V> (_ map: (Key, Value) -> V) -> [V] {
        
        var mapped = [V]()
        
        each {
            mapped.append(map($0, $1))
        }
        
        return mapped
        
    }
    
    /**
    Creates a Dictionary with the same keys as self and values generated by running
    each [key: value] of self through the mapFunction.
    
    - parameter mapFunction:
    - returns: Mapped dictionary
    */
    public func mapValues <V> (_ map: (Key, Value) -> V) -> [Key: V] {
        
        var mapped = [Key: V]()
        
        each {
            mapped[$0] = map($0, $1)
        }
        
        return mapped
        
    }
    
    /**
    Creates a Dictionary with the same keys as self and values generated by running
    each [key: value] of self through the mapFunction discarding nil return values.
    
    - parameter mapFunction:
    - returns: Mapped dictionary
    */
    public func mapFilterValues <V> (_ map: (Key, Value) -> V?) -> [Key: V] {
        
        var mapped = [Key: V]()
        
        each {
            if let value = map($0, $1) {
                mapped[$0] = value
            }
        }
        
        return mapped
        
    }
    
    /**
    Creates a Dictionary with keys and values generated by running
    each [key: value] of self through the mapFunction discarding nil return values.
    
    - parameter mapFunction:
    - returns: Mapped dictionary
    */
    public func mapFilter <K, V> (_ map: (Key, Value) -> (K, V)?) -> [K: V] {
        
        var mapped = [K: V]()
        
        each {
            if let value = map($0, $1) {
                mapped[value.0] = value.1
            }
        }
        
        return mapped
        
    }
    
    /**
    Creates a Dictionary with keys and values generated by running
    each [key: value] of self through the mapFunction.
    
    - parameter mapFunction:
    - returns: Mapped dictionary
    */
    public func map <K, V> (_ map: (Key, Value) -> (K, V)) -> [K: V] {
        
        var mapped = [K: V]()
        
        self.each({
            let (_key, _value) = map($0, $1)
            mapped[_key] = _value
        })
        
        return mapped
        
    }
    
    /**
    Loops trough each [key: value] pair in self.
    
    - parameter eachFunction: Function to inovke on each loop
    */
    public func each (_ each: (Key, Value) -> ()) {
        
        for (key, value) in self {
            each(key, value)
        }
        
    }
    
    /**
    Constructs a dictionary containing every [key: value] pair from self
    for which testFunction evaluates to true.
    
    - parameter testFunction: Function called to test each key, value
    - returns: Filtered dictionary
    */
    public func filter (_ test: (Key, Value) -> Bool) -> Dictionary {
        
        var result = Dictionary()
        
        for (key, value) in self {
            if test(key, value) {
                result[key] = value
            }
        }
        
        return result
        
    }
    
    /**
    Creates a dictionary composed of keys generated from the results of
    running each element of self through groupingFunction. The corresponding
    value of each key is an array of the elements responsible for generating the key.
    
    - parameter groupingFunction:
    - returns: Grouped dictionary
    */
    public func groupBy <T> (_ group: (Key, Value) -> T) -> [T: [Value]] {
        
        var result = [T: [Value]]()
        
        for (key, value) in self {
            
            let groupKey = group(key, value)
            
            // If element has already been added to dictionary, append to it. If not, create one.
            if result.has(groupKey) {
                result[groupKey]! += [value]
            } else {
                result[groupKey] = [value]
            }
            
        }
        
        return result
    }
    
    /**
    Similar to groupBy. Doesn't return a list of values, but the number of values for each group.
    
    - parameter groupingFunction: Function called to define the grouping key
    - returns: Grouped dictionary
    */
    public func countBy <T> (_ group: (Key, Value) -> (T)) -> [T: Int] {
        
        var result = [T: Int]()
        
        for (key, value) in self {
            
            let groupKey = group(key, value)
            
            // If element has already been added to dictionary, append to it. If not, create one.
            if result.has(groupKey) {
                result[groupKey]! += 1
            } else {
                result[groupKey] = 1
            }
        }
        
        return result
    }
    
    /**
    Checks if test evaluates true for all the elements in self.
    
    - parameter test: Function to call for each element
    - returns: true if test returns true for all the elements in self
    */
    public func all (_ test: (Key, Value) -> (Bool)) -> Bool {
        
        for (key, value) in self {
            if !test(key, value) {
                return false
            }
        }
        
        return true
        
    }
    
    /**
    Checks if test evaluates true for any element of self.
    
    - parameter test: Function to call for each element
    - returns: true if test returns true for any element of self
    */
    public func any (_ test: (Key, Value) -> (Bool)) -> Bool {
        
        for (key, value) in self {
            if test(key, value) {
                return true
            }
        }
        
        return false
        
    }
    
    
    /**
    Returns the number of elements which meet the condition
    
    - parameter test: Function to call for each element
    - returns: the number of elements meeting the condition
    */
    public func countWhere (_ test: (Key, Value) -> (Bool)) -> Int {
        
        var result = 0
        
        for (key, value) in self {
            if test(key, value) {
                result += 1
            }
        }
        
        return result
    }
    
    
    /**
    Recombines the [key: value] couples in self trough combine using initial as initial value.
    
    - parameter initial: Initial value
    - parameter combine: Function that reduces the dictionary
    - returns: Resulting value
    */
    public func reduce <U> (_ initial: U, combine: (U, Element) -> U) -> U {
        return self.reduce(initial, combine: combine)
    }
    
    /**
    Returns a copy of self, filtered to only have values for the whitelisted keys.
    
    - parameter keys: Whitelisted keys
    - returns: Filtered dictionary
    */
    public func pick (_ keys: [Key]) -> Dictionary {
        return filter { (key: Key, _) -> Bool in
            return keys.contains(key)
        }
    }
    
    /**
    Returns a copy of self, filtered to only have values for the whitelisted keys.
    
    - parameter keys: Whitelisted keys
    - returns: Filtered dictionary
    */
    public func pick (_ keys: Key...) -> Dictionary {
        return pick(unsafeBitCast(keys, to: [Key].self))
    }
    
    /**
    Returns a copy of self, filtered to only have values for the whitelisted keys.
    
    - parameter keys: Keys to get
    - returns: Dictionary with the given keys
    */
    public func at (_ keys: Key...) -> Dictionary {
        return pick(keys)
    }
    
    /**
    Removes a (key, value) pair from self and returns it as tuple.
    If the dictionary is empty returns nil.
    
    - returns: (key, value) tuple
    */
    public mutating func shift () -> (Key, Value)? {
        if let key = keys.first {
            return (key, removeValue(forKey: key)!)
        }
        
        return nil
    }
}
