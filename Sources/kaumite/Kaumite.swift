// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser

@main
struct Kaumite: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "kaumite",
        abstract: "Generate Git commit messages with Apple Foundation Models.",
        version: "1.0.3",

        subcommands: [
            AllCommand.self,
            StagedCommand.self,
        ],

        helpNames: [.short, .long]
    )
}
