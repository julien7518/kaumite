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
        let gitService = GitService()
        let runner = Runner(options: options)

        try await runner.run(diffFunc: gitService.stagedDiff)
    }
}
