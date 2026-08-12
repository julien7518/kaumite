//
//  CommonOptions.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import ArgumentParser

enum CommitLanguage: String, ExpressibleByArgument, CaseIterable {
    case english = "en"
    case french = "fr"
    case german = "de"

    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .french:
            return "French"
        case .german:
            return "German"
        }
    }
}

struct CommonOptions: ParsableArguments {
    @Flag(
        name: .long,
        help: "Display the generated commit message without creating a commit."
    )
    var dryRun: Bool = false

    @Option(
        name: [.long, .customShort("l")],
        help: "Language used to generate the commit message."
    )
    var lang: CommitLanguage = .english

    @Flag(
        name: .long,
        help: "Amend the latest Git commit instead of creating a new one."
    )
    var amend: Bool = false

    @Flag(
        name: .long,
        help: "Disable colored terminal output."
    )
    var noColor = false
}
