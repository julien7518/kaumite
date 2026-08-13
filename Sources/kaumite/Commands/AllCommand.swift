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
        let generator = MessageGenerator()

        do {
            let diff = try gitService.stagedAndUnstagedDiff()
            let message = try await generator.generateCommitMessage(diff: diff, lang: options.lang)
            
            consoleOutput.printCommitMessage(message, options.lang)

            if options.dryRun {
                return
            }

            try gitService.addAll()
            try gitService.commit(message: message)
            let commitID = try gitService.currentCommitID()
            let currentBranch = try gitService.currentBranch()
            print("Commit \(commitID) created on \(currentBranch)")
        } catch {
            consoleOutput.printError(error.localizedDescription)
        }
    }
}
