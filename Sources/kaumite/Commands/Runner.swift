//
//  Runner.swift
//  kaumite
//
//  Created by Julien Fernandes on 15/08/2026.
//

import Foundation

struct Runner {
    let options: CommonOptions
    let allCommand: Bool

    func run(diffFunc: () throws -> String) async throws {
        let consoleOutput = ConsoleOutput(useColors: !options.noColor)
        let verbose = options.verbose
        let gitService = GitService()
        let generator = MessageGenerator()

        var loadingTask: Task<Void, Never>?

        do {
            if verbose {
                print("Checking git repository...", terminator: "")
            }

            try gitService.checkGitReposirtory()

            if verbose {
                print("OK")
                print("Checking for changes...", terminator: "")
            }

            let diff = try diffFunc()

            if verbose {
                print("OK")
            }

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

            if allCommand {
                if verbose {
                    print("Adding all files...", terminator: "")
                }
                try gitService.addAll()
                if verbose {
                    print("OK")
                    print("Commiting...", terminator: "")
                }
            }
            try gitService.commit(message: message, amend: options.amend)
            
            if verbose {
                print("OK")
            }
            
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
