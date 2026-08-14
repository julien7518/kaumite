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
        let generator = MessageGenerator()

        var loadingTask: Task<Void, Never>?
        
        do {
            let diff = try gitService.stagedDiff()
            loadingTask = consoleOutput.startLoading(
                "Generating"
            )
            let message = try await generator.generateCommitMessage(
                diff: diff,
                lang: options.lang
            )

            if let loadingTask {
                loadingTask.cancel()
                await loadingTask.value
                consoleOutput.stopLoading()
            }

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
            if let loadingTask {
                loadingTask.cancel()
                await loadingTask.value
                consoleOutput.stopLoading()
            }

            consoleOutput.printError(error.localizedDescription)
        }
    }
}
