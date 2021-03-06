//
//  LogManager.swift
//  TINU
//
//  Created by ITzTravelInTime on 19/09/17.
//  Copyright © 2017 Pietro Caruso. All rights reserved.
//

import Foundation

//this code manages the log system and the log window
fileprivate var logs = [String]()
fileprivate var hasBeenUpdated = false

#if usedate
	let calendar = Calendar.current
#endif

//function you need to call if you want to log something
public func log(_ log: Any){
    print("\(log)")
	
	#if usedate
		let date = Date()
		
		var timeItems = [
			"\(calendar.component(.year, from: date))",    //0 YEAR
			"\(calendar.component(.month, from: date))",   //1 MONTH
			"\(calendar.component(.day, from: date))",     //2 DAY
			"\(calendar.component(.hour, from: date))",    //3 HOUR
			"\(calendar.component(.minute, from: date))",  //4 MINUTE
			"\(calendar.component(.second, from: date))"   //5 SECOND
		]
		
		for i in 0...(timeItems.count - 1){
			if timeItems[i].characters.count == 1{
				timeItems[i] = "0" + timeItems[i]
			}
		}
	
		logs.append("\(timeItems[1])/\(timeItems[2])/\(timeItems[0]) \(timeItems[3]):\(timeItems[4]):\(timeItems[5])     \(log)")
	#else
		logs.append("\(log)")
	#endif
    
    hasBeenUpdated = true
}

//returs the whole log, if you do not have alreay read it, it's better to not use it
public func readLog() -> String!{
    if !hasBeenUpdated{
        return nil
    }else{
        return readAllLog()
    }
}

//returs the whole log, but it will always return the log
public func readAllLog() -> String{
        var ret = ""
        for i in logs{
            ret += i + "\n"
        }
        hasBeenUpdated = false
        return ret
}

//returns the latest log line
public func readAllLatestLog() -> String!{
    return logs.last
}


//returs the latest log line only if you don't have alreay read it, it's better to not use it because it's used by the log window thaty will not work without
public func readLatestLog() -> String!{
    if !logs.isEmpty{
        return readAllLatestLog()
    }
    return nil
}

//resets the initial state of the log control
public func clearLog(){
    logs = []
    hasBeenUpdated = false
    if let lw = logWindow{
        if (lw.window?.isVisible)!{
            hasBeenUpdated = true
        }
    }
}
