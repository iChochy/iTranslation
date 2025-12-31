//
//  HeadView.swift
//  iTranslation
//
//  Created by OSX on 2025/12/26.
//

import SwiftUI
import Translation

struct HeadView: View {
    var vm: ViewModel
    
    var body: some View {
        
        HStack {
            
            @Bindable var vm = vm
            
            Picker(selection: $vm.selectedFrom) {
                ForEach(vm.availableLanguages) { language in
                    Text(language.localizedName())
                        .tag(Optional(language.locale))
                }
            } label: {
            }.onChange(of: vm.selectedFrom) { oldValue, newValue in
                vm.configuration?.invalidate()
                vm.configuration = nil
                vm.triggerTranslation()
            }
            Button {
                (vm.selectedFrom, vm.selectedTo) = (vm.selectedTo, vm.selectedFrom)
            } label: {
                Image(systemName: "repeat").foregroundStyle(
                    Color.accentColor
                )
            }

            
            Picker(selection: $vm.selectedTo) {
                ForEach(vm.availableLanguages) { language in
                    Text(language.localizedName())
                        .tag(Optional(language.locale))
                }
            } label: {
            }
            .onChange(of: vm.selectedTo) { oldValue, newValue in
                vm.configuration?.invalidate()
                vm.configuration = nil
                vm.triggerTranslation()
            }
        }
    }
    

    
    
}

