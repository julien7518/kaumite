//
//  AllCommand.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import ArgumentParser
import Foundation

struct AllCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "all",
        abstract: "Add all changes and create a commit."
    )

    @OptionGroup
    var options: CommonOptions

    func run() async throws {
        let message = "chore: update project files"

        let output = ConsoleOutput(useColors: !options.noColor)
        
        output.printCommitMessage(message, options.lang)

        if options.dryRun {
            return
        }

        print("Creating commit... (all)")
    }
}
