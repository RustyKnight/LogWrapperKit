//
//  LogWrapperService.swift
//  LogWrapperKit
//
//  Created by Shane Whitehead on 17/10/17.
//  Copyright © 2017 Shane Whitehead. All rights reserved.
//

import Foundation

public struct LogServiceManager {
	public static var shared: LogService = DefaultLogService()
}

/// Delegates the output to what ever underlying implementation is been used
public protocol LogServiceDelegate {
	func log(verbose: String, file: StaticString, function: StaticString, line: UInt)
	func log(
		verbose: CustomStringConvertible,
		file: StaticString,
		function: StaticString,
		line: UInt)
	
	func log(info: String, file: StaticString, function: StaticString, line: UInt)
	func log(
		info: CustomStringConvertible,
		file: StaticString,
		function: StaticString,
		line: UInt)
	
	func log(warning: String, file: StaticString, function: StaticString, line: UInt)
	func log(warning: Error, file: StaticString, function: StaticString, line: UInt)
	func log(
		warning: CustomStringConvertible,
		file: StaticString,
		function: StaticString,
		line: UInt)
	
	func log(error: String, file: StaticString, function: StaticString, line: UInt)
	func log(error: Error, file: StaticString, function: StaticString, line: UInt)
	func log(
		error: CustomStringConvertible,
		file: StaticString,
		function: StaticString,
		line: UInt)
	
	func log(debug: String, file: StaticString, function: StaticString, line: UInt)
	func log(
		debug: CustomStringConvertible,
		file: StaticString,
		function: StaticString,
		line: UInt)
}

public struct DefaultLogServiceDelegate: LogServiceDelegate {
	
	func log(prefix: String, message: String, file: StaticString, function: StaticString, line: UInt) {
		let components = file.description.components(separatedBy: "/")
		guard let name = components.last else {
			print("[\(prefix) \(file):\(function)@\(line)]: \(message)")
			return
		}
		print("[\(prefix) \(name):\(function)@\(line)]: \(message)")
	}
	
	public func log(verbose: String, file: StaticString, function: StaticString, line: UInt) {
		log(prefix: "📢", message: verbose, file: file, function: function, line: line)
	}
	
	public func log(verbose: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt) {
		log(verbose: verbose.description, file: file, function: function, line: line)
	}
	
	public func log(info: String, file: StaticString, function: StaticString, line: UInt) {
		log(prefix: "💡", message: info, file: file, function: function, line: line)
	}
	
	public func log(info: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt) {
		log(info: info.description, file: file, function: function, line: line)
	}
	
	public func log(warning: String, file: StaticString, function: StaticString, line: UInt) {
		log(prefix: "☢", message: warning, file: file, function: function, line: line)
	}
	
	public func log(warning: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt) {
		log(warning: warning.description, file: file, function: function, line: line)
	}
	
	public func log(warning: Error, file: StaticString, function: StaticString, line: UInt) {
		log(warning: "\(warning)", file: file, function: function, line: line)
	}
	
	public func log(error: String, file: StaticString, function: StaticString, line: UInt) {
		log(prefix: "🔥", message: error, file: file, function: function, line: line)
	}
	
	public func log(error: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt) {
		log(error: error.description, file: file, function: function, line: line)
	}
	
	public func log(error: Error, file: StaticString, function: StaticString, line: UInt) {
		log(error: "\(error)", file: file, function: function, line: line)
	}
	
	public func log(debug: String, file: StaticString, function: StaticString, line: UInt) {
		log(prefix: "🐞", message: debug, file: file, function: function, line: line)
	}
	
	public func log(debug: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt) {
		log(debug: debug.description, file: file, function: function, line: line)
	}
}

public protocol LogService {
	var delegate: LogServiceDelegate { get set }
	
	func log(verbose: String, file: StaticString, function: StaticString, line: UInt)
	func log(
		verbose: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt)
	
	func log(info: String, file: StaticString, function: StaticString, line: UInt)
	func log(
		info: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt)
	
	func log(warning: String, file: StaticString, function: StaticString, line: UInt)
	func log(warning: Error, file: StaticString, function: StaticString, line: UInt)
	func log(
		warning: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt)
	
	func log(error: String, file: StaticString, function: StaticString, line: UInt)
	func log(error: Error, file: StaticString, function: StaticString, line: UInt)
	func log(
		error: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt)
	
	func log(debug: String, file: StaticString, function: StaticString, line: UInt)
	func log(
		debug: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt)
}

class DefaultLogService: LogService {
	
	var delegate: LogServiceDelegate = DefaultLogServiceDelegate()
	
	public func log(verbose: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
		delegate.log(verbose: verbose, file: file, function: function, line: line)
	}
	
	public func log(
		verbose: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line) {
		delegate.log(verbose: verbose.description, file: file, function: function, line: line)
	}
	
	public func log(info: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
		delegate.log(info: info, file: file, function: function, line: line)
	}
	
	public func log(
		info: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line) {
		delegate.log(info: info.description, file: file, function: function, line: line)
	}
	
	public func log(warning: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
		delegate.log(warning: warning, file: file, function: function, line: line)
	}
	
	public func log(warning: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
		delegate.log(warning: "\(warning)", file: file, function: function, line: line)
	}
	
	public func log(
		warning: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line) {
		delegate.log(warning: warning.description, file: file, function: function, line: line)
	}
	
	public func log(error: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
		delegate.log(error: error, file: file, function: function, line: line)
	}
	
	public func log(error: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
		delegate.log(error: "\(error)", file: file, function: function, line: line)
	}
	
	public func log(
		error: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line) {
		delegate.log(error: error.description, file: file, function: function, line: line)
	}
	
	public func log(debug: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
		delegate.log(debug: debug, file: file, function: function, line: line)
	}
	
	public func log(
		debug: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line) {
		delegate.log(debug: debug.description, file: file, function: function, line: line)
	}
}

public func log(verbose: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
	LogServiceManager.shared.log(verbose: verbose, file: file, function: function, line: line)
}

public func log(
	verbose: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line) {
	LogServiceManager.shared.log(verbose: verbose.description, file: file, function: function, line: line)
}

public func log(info: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
	LogServiceManager.shared.log(info: info, file: file, function: function, line: line)
}

public func log(
	info: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line) {
	LogServiceManager.shared.log(info: info.description, file: file, function: function, line: line)
}

public func log(warning: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
	LogServiceManager.shared.log(warning: warning, file: file, function: function, line: line)
}

public func log(warning: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
	LogServiceManager.shared.log(warning: "\(warning)", file: file, function: function, line: line)
}

public func log(
	warning: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line) {
	LogServiceManager.shared.log(warning: warning.description, file: file, function: function, line: line)
}

public func log(error: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
	LogServiceManager.shared.log(error: error, file: file, function: function, line: line)
}

public func log(error: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
	LogServiceManager.shared.log(error: "\(error)", file: file, function: function, line: line)
}

public func log(
	error: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line) {
	LogServiceManager.shared.log(error: error.description, file: file, function: function, line: line)
}

public func log(debug: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
	LogServiceManager.shared.log(debug: debug, file: file, function: function, line: line)
}

public func log(
	debug: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line) {
	LogServiceManager.shared.log(debug: debug.description, file: file, function: function, line: line)
}
