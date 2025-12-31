//
//  iTranslationView.swift
//  iTranslation
//
//  Created by OSX on 2025/12/23.
//

import SwiftUI
import Translation

struct iTranslationView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.appearsActive) private var appearsActive
    @Environment(\.scenePhase) private var scenePhase

    @Binding var sourceText: String

    @State private var vm = ViewModel()

    var body: some View {
        VStack {
            HeadView(vm: vm)
            BodyView(vm: vm)
            FootView(vm: vm)
        }
        .textSelection(.enabled)
        .padding(.horizontal)
        .padding(.bottom)
        .font(.title)
        .frame(minWidth: 400, minHeight: 300)
        .navigationTitle("iTranslation")
        .task(
            id: sourceText,
            {
                vm.inputText = sourceText
                vm.prepareSupportedLanguages()
            }
        )
        .onKeyPress(
            .escape,
            action: {
                dismiss()
                return .handled
            }
        )
    }

    
    

}
