//
//  FootView.swift
//  iTranslation
//
//  Created by OSX on 2025/12/26.
//

import SwiftUI

struct FootView: View {
    var vm: ViewModel
    @State private var isCopied = false

    var body: some View {
        HStack {
            Link("Blog", destination: URL(string: "https://ichochy.com")!)
                .font(.footnote)
            Link("Email", destination: URL(string: "mailto:it.osx@icloud.com")!)
                .font(.footnote)
            Link("Github", destination: URL(string: "https://github.com/ichochy/iTranslation")!)
                .font(.footnote)
            Spacer()
            Button {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(vm.targetText, forType: .string)
                isCopied = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isCopied = false
                }
            } label: {
                if isCopied {
                    Image(systemName: "checkmark").foregroundStyle(
                        Color.accentColor
                    )
                } else {
                    Text("Copy")
                }
            }.help("⌘ + ↩")
            .keyboardShortcut(.return, modifiers: .command)
            .frame(width: 60, height: 20)
            .padding(.horizontal,10)
            .disabled(vm.targetText.isEmpty)
        }
        
    }
}
