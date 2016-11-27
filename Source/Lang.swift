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



/// This function is for use as a temporary runtime check to catch places where a an abstract function has not been overriden. This replaces the compiletime check available in Java but not supported in Swift 3. For all abstract function declarations, add a simple body with a call to this function, pending class refcatoring into protocols and base classes. A return statement in the block is not necessary as this function never returns.
public func abstract(line: Int = #line, file: String = #file) -> Never
{
	var msg = "Fatal: call to abstract function at \(file) : \(line)\nCall stack:"
	msg = Thread.callStackSymbols.dropFirst().reduce(msg) { $0 + "\n" + $1 }
	fatalError(msg)
}


