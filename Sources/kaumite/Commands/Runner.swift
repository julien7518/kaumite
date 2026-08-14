//
//  Runner.swift
//  kaumite
//
//  Created by Julien Fernandes on 15/08/2026.
//

import Foundation

struct Runner {
    let options: CommonOptions

    func run(diffFunc: () throws -> String) async throws {
        let consoleOutput = ConsoleOutput(useColors: !options.noColor)
        let gitService = GitService()
        let generator = MessageGenerator()

        var loadingTask: Task<Void, Never>?

        do {
            let diff = try diffFunc()
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
