//
//  MenuBarView.swift
//  iTranslation
//
//  Created by OSX on 2025/12/26.
//

import SwiftUI

struct MenuBarView:View{
    @Environment(\.openWindow) private var openWindow
    @Binding var sourceText:String
    
    let appVersion =
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        ?? "1.0"
    let appBuild =
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        ?? "1"
    
    var body: some View {
        Button("iTranslation") {
            sourceText = ""
//            openWindow(id: "main")
//            NSApplication.shared.keyWindow?.makeKeyAndOrderFront(nil)
//            NSApplication.shared.activate(ignoringOtherApps: true)
            CustomWindow.show(rootView: iTranslationView(sourceText: $sourceText))
        }.keyboardShortcut("E", modifiers: [.command, .shift])
        Divider()
        Button("About \(appVersion) (\(appBuild))"){
            NSApp.orderFrontStandardAboutPanel(nil)
        }
        Button("Quit") {
            NSApp.terminate(nil)
        }.keyboardShortcut("Q")
    }
    

    
}

