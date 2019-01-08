//
//  Shell.swift
//  Process
//
//  Created by Jason on 2018/11/6.
//  Copyright © 2018 Jason. All rights reserved.
//  用来执行cmd 指令的模块

import Foundation

struct Shell {
    
    var outputPipe = Pipe()
    
    /* 用于执行指令操作的封装
     * cmd : 需要执行的命令
     * arguments : 执行命令的参数
     * return : 命令执行后的结果字符串
     */
    static func execmd(_ cmd: String, arguments:[String], completion:@escaping ((_ result:String)->())) {
        
        let task = Process()
        
        // 1. 设置命令的参数
        task.arguments = arguments
        // 2. 设置执行命令
        task.launchPath = cmd
        
        // 3.  设置标准输出管道
        let outputPipe = Pipe()
        
        task.standardOutput = outputPipe
        
        // 在后台线程等待数据和通知
        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: outputPipe.fileHandleForReading, queue: nil) { (noti) in
            
            //获取管道数据 转为字符串
            let output = outputPipe.fileHandleForReading.availableData
            
            let outputStr = String(data: output, encoding: .utf8) ?? ""
            
            //在主线程处理UI
            DispatchQueue.main.async {
                
                completion(outputStr)
                
            }
            
            
        }
        
        // 开始执行
        task.launch()
        
        // 等待直到执行结束
        //        task.waitUntilExit()
        
    }
    
}
