//
//  NSView+.swift
//  cartool
//
//  Created by Jason on 2019/1/10.
//  Copyright © 2019 Jason. All rights reserved.
//

import Cocoa

extension NSView{
    
    func insertVisualEffectView(mode:NSVisualEffectView.BlendingMode){
        
        let vibrant = NSVisualEffectView(frame: bounds)
        
        vibrant.autoresizingMask = [AutoresizingMask.width,AutoresizingMask.height]
        
        vibrant.blendingMode = mode
        
        vibrant.material = .ultraDark
        
        vibrant.state = .active
        
        addSubview(vibrant, positioned: .below, relativeTo: nil)
        
    }
    
    
}
