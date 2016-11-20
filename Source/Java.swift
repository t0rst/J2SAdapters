//
//  Java.swift
//  J2SAdapters
//
//  Created by Torsten Louland on 20/11/2016.
//  Copyright © 2016 Satisfying Structures BVBA. All rights reserved.
//

import Foundation



public protocol JavaCustomStringConvertible : CustomStringConvertible
{
	func toString() -> String
}

extension JavaCustomStringConvertible
{
    public var description: String { return toString() }
}



public protocol JavaComparable : Comparable
{
	func compareTo(_ another: Self) -> Int
}

extension JavaComparable
{
	public static func ==(lhs: Self, rhs: Self) -> Bool { return lhs.compareTo(rhs) == 0 }
	public static func < (lhs: Self, rhs: Self) -> Bool { return lhs.compareTo(rhs) <  0 }
	public static func <=(lhs: Self, rhs: Self) -> Bool { return lhs.compareTo(rhs) <= 0 }
	public static func > (lhs: Self, rhs: Self) -> Bool { return lhs.compareTo(rhs) >  0 }
	public static func >=(lhs: Self, rhs: Self) -> Bool { return lhs.compareTo(rhs) >= 0 }
}

