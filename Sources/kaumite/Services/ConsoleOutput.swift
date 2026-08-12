//
//  ConsoleOutput.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import Foundation

enum ConsoleOutput {
    private enum Color {
        static let yellow = "\u{001B}[33m"
        static let red = "\u{001B}[31m"
        static let reset = "\u{001B}[0m"
    }

    static func printCommitMessage(
        _ message: String,
        _ language: CommitLanguage
    ) {
        print("Commit language: \(language.displayName)\n")
        print("--- Commit message ---\n\(message)\n")
    }

    static func printWarning(_ message: String) {
        printToStandardError(
            "\(Color.yellow)WARNING\(Color.reset): \(message)"
        )
    }

    static func printError(_ message: String) {
        printToStandardError(
            "\(Color.red)ERROR\(Color.reset): \(message)"
        )
    }

    private static func printToStandardError(_ message: String) {
        FileHandle.standardError.write(
            Data("\(message)\n".utf8)
        )
    }
}
