//
//  StagedCommand.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import ArgumentParser
import Foundation

struct StagedCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "staged",
        abstract: "Create a commit from staged changes."
    )

    @OptionGroup
    var options: CommonOptions

    func run() async throws {
        let message = "feat: update staged files"

        ConsoleOutput.printCommitMessage(message, options.lang)

        if options.dryRun {
            return
        }

        print("Creating commit... (staged)")
    }
}
