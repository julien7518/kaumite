//
//  StagedCommand.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import ArgumentParser

struct StagedCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "staged",
        abstract: "Create a commit from staged changes."
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
            try gitService.commit(message: message)
        } catch {
            consoleOutput.printError(error.localizedDescription)
        }
    }
}
