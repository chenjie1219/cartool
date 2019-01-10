//
//  CustomWindow.swift
//  ProcessDemo
//
//  Created by Jason on 2018/11/6.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class CustomWindow: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.isMovableByWindowBackground = true
        
        window?.isOpaque = false

        window?.backgroundColor = .clear
        
        window?.center()
    }

}
