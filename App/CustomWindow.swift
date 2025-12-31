//
//  CustomWindow.swift
//  iTranslation
//
//  Created by OSX on 2025/12/29.
//

import SwiftUI

class CustomWindow: NSWindowController {
    static var shared: CustomWindow?
    private convenience init(
        rootView: some View,
    ) {
        let hosting = NSHostingController(rootView: rootView)
        let window = NSWindow(contentViewController: hosting)
//        window.center()
        window.hidesOnDeactivate = true
        window.isReleasedWhenClosed = false
        window.collectionBehavior = [
            //            .canJoinAllSpaces,
            .moveToActiveSpace,
            .fullScreenAuxiliary,  // 全屏应用上也能显示
            .stationary,  //在 Mission Control 中保持不动
        ]

        //        window.level = .floating
        //        window.isOpaque = true
        //        window.makeKey()
        //        window.orderFrontRegardless()
//                window.makeKeyAndOrderFront(nil)
        self.init(window: window)
    }

    static func show(
        rootView: some View,
    ) {
        if let controller = shared {
            controller.window?.makeKeyAndOrderFront(nil)
        } else {
            let controller = CustomWindow(
                rootView: rootView,
            )
            shared = controller
            controller.window?.makeKeyAndOrderFront(nil)
        }
        NSApplication.shared.activate(ignoringOtherApps: true)
    }

}
