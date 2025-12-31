//
//  AppDelegate.swift
//  iTranslation
//
//  Created by OSX on 2025/12/25.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    let servicesProvider = ServicesProvider()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // 注册服务提供者
        NSApp.servicesProvider = servicesProvider
        // 强制更新系统服务（开发时有用）
//        NSUpdateDynamicServices()
    }
    
}
