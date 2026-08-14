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
        let gitService = GitService()
        let runner = Runner(options: options)
        
        try await runner.run(diffFunc: gitService.stagedAndUnstagedDiff)
    }
}
