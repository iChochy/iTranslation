//
//  Main.swift
//  iTranslation
//
//  Created by OSX on 2025/12/23.
//

import AppKit
import SwiftData
import SwiftUI

@main
struct Main: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.openWindow) private var openWindow
    @State private var sourceText: String = ""

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([

            ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            cloudKitDatabase: .automatic
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        MenuBarExtra {
            MenuBarView(sourceText: $sourceText)
        } label: {
            Image("Bar")
                .renderingMode(.original)
                .onAppear {
                    //                    openWindow(id: "main")
                    //                                NSApplication.shared.keyWindow?.makeKeyAndOrderFront(nil)
                    //                    NSApplication.shared.activate(ignoringOtherApps: true)
                    CustomWindow.show(
                        rootView: iTranslationView(sourceText: $sourceText)
                    )
                }
                .onReceive(
                    NotificationCenter.default.publisher(
                        for: .didReceiveSelectedText
                    )
                ) { notification in
                    if let text = notification.object as? String {
                        sourceText = text
                        //                        openWindow(id: "main")
                        //                                    NSApplication.shared.keyWindow?.makeKeyAndOrderFront(nil)
                        //                        NSApplication.shared.activate(ignoringOtherApps: true)
                        CustomWindow.show(
                            rootView: iTranslationView(sourceText: $sourceText)
                        )
                        print("SwiftUI 收到文本：\(text)")
                    }
                }
        }

        //        Window("Main", id: "main") {
        //            iTranslationView(sourceText: $sourceText)
        //        }
        //        .defaultSize(width: 400, height: 300)
        //        .windowStyle(.automatic)

    }
}
