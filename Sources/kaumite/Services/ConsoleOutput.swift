//
//  ConsoleOutput.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import Foundation

struct ConsoleOutput {
    let useColors: Bool

    private enum Color {
        static let yellow = "\u{001B}[33m"
        static let red = "\u{001B}[31m"
        static let reset = "\u{001B}[0m"
    }

    func printCommitMessage(
        _ message: String,
        _ language: CommitLanguage
    ) {
        print("Commit language: \(language.displayName)\n")
        print("--- Commit message ---\n\(message)\n")
    }

    func printWarning(_ message: String) {
        printToStandardError(
            formatLabel(
                label: "WARNING",
                message: message,
                color: Color.yellow
            )
        )
    }

    func printError(_ message: String) {
        printToStandardError(
            formatLabel(
                label: "ERROR",
                message: message,
                color: Color.red
            )
        )
    }

    private func formatLabel(label: String, message: String, color: String)
        -> String
    {
        if useColors {
            return "\(color)\(label)\(Color.reset): \(message)"
        }
        else {
            return "\(label): \(message)"
        }
    }

    private func printToStandardError(_ message: String) {
        FileHandle.standardError.write(
            Data("\(message)\n".utf8)
        )
    }
}
