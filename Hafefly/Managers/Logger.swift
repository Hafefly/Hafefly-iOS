//
//  Logger.swift
//  Hafefly
//
//  Created by Samy Mehdid on 16/3/2023.
//

import Foundation
import os.log

class MyLogger {
    let logger = Logger(subsystem: "com.github.furkankaplan", category: "bispy")
    
    func error(_ message: String?) {
        logger.error("error: \(message ?? "something went wrong")")
    }
    
    func log(_ message: String) {
        logger.log("\(message)")
    }
    
    func fault(_ message: String?){
        logger.fault("fault: \(message ?? "something went wrong")")
    }
    
    func info(_ message: String){
        logger.info("\(message)")
    }
    
    func warning(_ message: String?) {
        logger.warning("warning \(message ?? "something went wrong")")
    }
}
