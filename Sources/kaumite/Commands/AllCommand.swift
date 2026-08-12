//
//  AllCommand.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import ArgumentParser

struct AllCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "all",
        abstract: "Add all changes and create a commit."
    )

    @OptionGroup
    var options: CommonOptions

    func run() async throws {
        let consoleOutput = ConsoleOutput(useColors: !options.noColor)
        let gitService = GitService()
        
        let message = "chore: update project files"
        consoleOutput.printCommitMessage(message, options.lang)
        
        if options.dryRun {
            return
        }

        do {
            try gitService.addAll()
            try gitService.commit(message: message)
        } catch {
            consoleOutput.printError(error.localizedDescription)
        }
    }
}
