//
//  ViewController.swift
//  cartool
//
//  Created by Jason on 2019/1/8.
//  Copyright © 2019 Jason. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var mainView: NSView!
    
    @IBOutlet weak var titleLbl: NSTextField!
    
    @IBOutlet weak var dragView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.insertVisualEffectView(mode: .behindWindow)
        
        dragView.dragEndBlock = {[weak self] path in
            
            guard let self = self else {
                return
            }
            
            self.executeCartool(path)
            
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func executeCartool(_ path:String) {
        
        let dir = mkdir(filePath: path)
        
        if dir.isEmpty{
            return
        }
        
        let decodePath = path.removingPercentEncoding ?? ""
        
        Shell.execmd(carToolPath(), arguments: [decodePath,dir]) { (str) in
            
        }
        
    }
    
    
    // cartool路径
    func carToolPath() -> String {
        
        let path = Bundle.main.bundlePath + "/Contents/Resources/cartool"
        
        return path
    }
    
    
    func mkdir(filePath:String) -> String {
        
        guard let url = URL(string: filePath)?.deletingLastPathComponent() else{
            return ""
        }
        
        let dir = (url.absoluteString.removingPercentEncoding ?? "") + "Assets"
        
        if FileManager.default.fileExists(atPath: dir) {
            return dir
        }
        
        Shell.execmd("/bin/mkdir", arguments: [dir]) { (str) in
            
        }
        
        return dir
    }
    
}

