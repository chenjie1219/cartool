//
//  CustomView.swift
//  cartool
//
//  Created by Jason on 2019/1/8.
//  Copyright © 2019 Jason. All rights reserved.
//

import Cocoa

class CustomView: NSView {
    
    var dragEndBlock:((String)->())?
    
    lazy var dragExited = false
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
    }
    
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        dragExited = false
        
        let pb = sender.draggingPasteboard
        
        let types = pb.types
        
        if types?.contains(NSPasteboard.PasteboardType.fileURL) ?? false {
            
            let items = pb.pasteboardItems
            
            for item in items!{
                
                let path = item.string(forType: NSPasteboard.PasteboardType.fileURL)
                
                let str = URL(string: path!)?.absoluteString
                
                if str?.hasSuffix(".car") ?? false{
                    
                    return NSDragOperation.copy
                    
                }
                
            }
            
            
        }
        
        return []
        
    }
    
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        dragExited = true
    }
    
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        
        if dragExited {
            return
        }
        
        let pb = sender.draggingPasteboard
        
        let types = pb.types
        
        if types?.contains(NSPasteboard.PasteboardType.fileURL) ?? false {
            
            let items = pb.pasteboardItems
            
            if items?.count == 1{
                
                let item = items?.first
                
                let path = item?.string(forType: NSPasteboard.PasteboardType.fileURL)
                
                guard let str = URL(string: path!)?.absoluteString else{
                    return
                }
                
                let index = str.index(str.startIndex, offsetBy: 7)
                
                let filePath = String(str[index..<str.endIndex])
                
                dragEndBlock?(filePath)
                
            }else {
                
                let alert = NSAlert()
                
                alert.messageText = "别拖太多的文件，只拖一个.car文件"
                
                alert.runModal()
                
            }
            
        }
        
    }
    
    
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }
    
    
    
    
}
