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



open class Log
{
	public static var logger = Log()

	public enum Category {
		case verbose, info, debug, warning, error, assert
		func description() -> String { switch self {
			case .verbose:	return "verbose"
			case .info:		return "info"
			case .debug:	return "debug"
			case .warning:	return "warning"
			case .error:	return "error"
			case .assert:	return "assert"
		} }
	}

	open func log(_ tag: String, _ msg: String, _ cat: Category, _ any: Any? = nil)
	{
		debugPrint("\(cat.description().characters.first): ", tag, " " , msg)
	}

	public class func v(_ tag: String, _ msg: String, _ any: Any? = nil) { logger.log(tag, msg, .verbose, any) }
	public class func d(_ tag: String, _ msg: String, _ any: Any? = nil) { logger.log(tag, msg, .debug, any) }
	public class func i(_ tag: String, _ msg: String, _ any: Any? = nil) { logger.log(tag, msg, .info, any) }
	public class func w(_ tag: String, _ msg: String, _ any: Any? = nil) { logger.log(tag, msg, .warning, any) }
	public class func e(_ tag: String, _ msg: String, _ any: Any? = nil) { logger.log(tag, msg, .error, any) }
}

