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
        print("--- Commit message ---\n\(message)\n----------------------")
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

    func startLoading(_ message: String) -> Task<Void, Never>{
        let symbols = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"]
        
        return Task {
            var index = 0
            
            while !Task.isCancelled {
                let symbol = symbols[index % symbols.count]
                
                writeToStandardError("\r\(symbol) \(message)")
                
                index += 1
                
                try? await Task.sleep(nanoseconds: 100_000_000)
            }
        }
    }
    
    func stopLoading() {
        writeToStandardError("\r\u{001B}[K")
    }
    
    private func formatLabel(label: String, message: String, color: String)
        -> String
    {
        if useColors {
            return "\(color)\(label)\(Color.reset): \(message)"
        } else {
            return "\(label): \(message)"
        }
    }

    private func printToStandardError(_ message: String) {
        writeToStandardError(message + "\n")
    }

    private func writeToStandardError(_ message: String) {
        FileHandle.standardError.write(
            Data(message.utf8)
        )
    }
}
