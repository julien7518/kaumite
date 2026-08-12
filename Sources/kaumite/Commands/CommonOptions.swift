//
//  CommonOptions.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import ArgumentParser
import Foundation

enum CommitLanguage: String, ExpressibleByArgument, CaseIterable {
    case english = "en"
    case french = "fr"
    case german = "de"

    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .french:
            return "Français"
        case .german:
            return "Deutsch"
        }
    }
}

struct CommonOptions: ParsableArguments {
    @Flag(
        name: .long,
        help: "Display the generated commit message without creating a commit."
    )
    var dryRun = false

    @Option(
        name: [.long, .customShort("l")],
        help: "Language used to generate the commit message."
    )
    var lang: CommitLanguage = .english
}
