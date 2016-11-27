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



/*	Replacing 'synchronized'

	-	Copy the follwing function into a file within your app, to get synchronized statements to build until you have time to replace them with more efficient equivalents - the deprecated warning is there to remind you to do this. The reason for copying the function is to allow the compiler the possibility of inlining block; if it cannot do this (as would be the case if defined in an external framework such as this) then a big time penalty is incurred making heap allocations for any the variables that are captured by the block from the enclosing scopes. If this is avoided by inlining, there can still be a penalty if a return value is captured prior to escaping the block. Hence this approach is non-optimal.
	-	For a comprehensive discussion, see https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html , and make use of the efficient implementations in CwlMutex in https://github.com/mattgallagher/CwlUtils .

@available(*, deprecated, message: "consider more optimal alternatives")
public func synchronized(_ obj: AnyObject!, _ block: () -> ())
{
	objc_sync_enter(obj)
	block()
	objc_sync_exit(obj)
}

*/



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
