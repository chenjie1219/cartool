//
//  ServiceHelper.swift
//  cartool
//
//  Created by Jason on 2019/1/14.
//  Copyright © 2019 Jason. All rights reserved.
//

import Cocoa

class ServiceHelper: NSObject {
    
    @objc public func cartoolUnzip(_ pboard: NSPasteboard!, userData: String!, error: AutoreleasingUnsafeMutablePointer<NSString?>) {
        
         guard let fileURLs = pboard.readObjects(forClasses: [NSURL.self]) as? [URL] else { return assertionFailure() }
        
        let str = fileURLs.first?.absoluteString ?? ""
        
        let index = str.index(str.startIndex, offsetBy: 7)
        
        let filePath = String(str[index..<str.endIndex])
        
        if filePath.hasSuffix(".car") {
            
            let vc = ViewController()
            
            vc.executeCartool(filePath)
            
        }else{
            
            let alert = NSAlert()
            
            alert.messageText = "只支持.car文件"
            
            alert.runModal()
            
            return
        }
        
    }

    
    
}
