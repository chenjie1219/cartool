//
//  ViewController.swift
//  cartool
//
//  Created by Jason on 2019/1/8.
//  Copyright © 2019 Jason. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var titleLbl: NSTextField!
    
    lazy var isDrag = false
    
    @IBOutlet weak var dragView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dragView.dragEndBlock = {path in
            
            self.titleLbl.stringValue = path
            
            self.isDrag = true
            
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func okBtnClick(_ sender: Any) {
        
        if isDrag {
            
            let dir = mkdir(filePath: titleLbl.stringValue)
            
            if dir.isEmpty{
                return
            }
            
            Shell.execmd(carToolPath(), arguments: [titleLbl.stringValue,dir]) { (str) in
                
            }
            
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
        
        let dir = url.absoluteString + "生成car图片的目录"
        
        if FileManager.default.fileExists(atPath: dir) {
            return dir
        }
        
        Shell.execmd("/bin/mkdir", arguments: [dir]) { (str) in
            
        }
        
        return dir
    }
    
}

