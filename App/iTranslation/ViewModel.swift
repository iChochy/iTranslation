//
//  ViewModel.swift
//  iTranslation
//
//  Created by OSX on 2025/12/26.
//

import SwiftUI
import Translation

@Observable
class ViewModel {
    var configuration: TranslationSession.Configuration?
    var availableLanguages: [AvailableLanguage] = []
    var selectedFrom: Locale.Language? =
        .init(
            languageCode: .english,
            region: .unitedStates
        )
        
    var selectedTo: Locale.Language? =
        .init(
        languageCode: .chinese,
        region: .chinaMainland
    )

    var inputText = ""
    var targetText = ""
    var isExchange = false
    
    
    func triggerTranslation() {
        if configuration == nil {
            configuration = .init(
                source: selectedFrom,
                target: selectedTo
            )
        } else {
            configuration?.invalidate()
        }
    }
    
    
    func prepareSupportedLanguages() {
        if inputText.isEmpty, !isExchange {
            swap(&selectedFrom, &selectedTo)
//            (selectedFrom, selectedTo) = (selectedTo, selectedFrom)
            isExchange.toggle()
        }else if !inputText.isEmpty,isExchange {
            swap(&selectedFrom, &selectedTo)
//            (selectedFrom, selectedTo) = (selectedTo, selectedFrom)
            isExchange.toggle()
        }
        Task { @MainActor in
            let supportedLanguages = await LanguageAvailability()
                .supportedLanguages
            availableLanguages = supportedLanguages.map {
                AvailableLanguage(locale: $0)
            }.sorted()
        }
    }
    
}
