//
//  BodyView.swift
//  iTranslation
//
//  Created by OSX on 2025/12/26.
//

import SwiftUI
import Translation

struct BodyView: View {
    var vm: ViewModel
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                if proxy.size.width > 400 {
                    HStack {
                        SourceTextView
                        TargetTextView
                    }
                } else {
                    VStack {
                        SourceTextView
                        TargetTextView
                    }
                }
            }
        }
    }
    private var TargetTextView: some View {
        TextEditor(text: .constant(vm.targetText))
    }

    private var SourceTextView: some View {
        @Bindable var vm = vm
        return VStack {
            TextEditor(text: $vm.inputText)
                .foregroundColor(Color.primary)
                .onChange(of: vm.inputText) { oldValue, newValue in
                    guard !newValue.isEmpty else {
                        vm.targetText = ""
                        return
                    }
                    vm.triggerTranslation()
                }
        }
        .translationTask(vm.configuration) { session in
            guard !vm.inputText.isEmpty else {
                return
            }
            do {
                let response = try await session.translate(vm.inputText)
                vm.targetText = response.targetText
            } catch {
                print(error.localizedDescription)
                vm.targetText = error.localizedDescription
            }
        }
    }

}

