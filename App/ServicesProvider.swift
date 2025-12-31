//
//  ServiceProvider.swift
//  iTranslation
//
//  Created by OSX on 2025/12/25.
//

import AppKit

class ServicesProvider: NSObject {

    @objc func handleSelectedText(
        _ pasteboard: NSPasteboard,
        userData: String?,
        error: AutoreleasingUnsafeMutablePointer<NSString>?
    ) {
        if let selectedText = pasteboard.string(forType: .string) {
            print("获取到的选中文本：\(selectedText)")
            NotificationCenter.default.post(
                name: .didReceiveSelectedText,
                object: selectedText
            )
        }
    }
}

// 自定义通知名称
extension Notification.Name {
    static let didReceiveSelectedText = Notification.Name(
        "didReceiveSelectedText"
    )
}
