//
//  GitService.swift
//  kaumite
//
//  Created by Julien Fernandes on 12/08/2026.
//

import Foundation

struct GitService {
    enum GitError: LocalizedError {
        case commandFailed(command: String, exitCode: Int32, message: String)
        case notARepository
        case noChanges

        var errorDescription: String? {
            switch self {
            case .commandFailed(let command, let exitCode, let message):
                return
                    "Git command failed: \(command). Exit code: \(exitCode). Message: \(message)"
            case .notARepository:
                return "The current directory is not a Git repository"

            case .noChanges:
                return "There are no staged or unstaged changes."
            }
        }
    }

    private func run(_ arguments: [String]) throws -> String {
        let process = Process()
        let outputPipe = Pipe()
        let errorPipe = Pipe()

        process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
        process.arguments = arguments
        process.standardOutput = outputPipe
        process.standardError = errorPipe

        do {
            try process.run()
        } catch {
            throw GitError.commandFailed(
                command: commandDescription(arguments),
                exitCode: -1,
                message: error.localizedDescription
            )
        }

        process.waitUntilExit()

        let outputData = outputPipe.fileHandleForReading
            .readDataToEndOfFile()
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()

        let output = String(decoding: outputData, as: UTF8.self)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let errorOutput = String(decoding: errorData, as: UTF8.self)
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard process.terminationStatus == 0 else {
            if isNotARepository(errorOutput) {
                throw GitError.notARepository
            }

            throw GitError.commandFailed(
                command: commandDescription(arguments),
                exitCode: process.terminationStatus,
                message: errorOutput
            )
        }

        return output
    }

    private func commandDescription(_ arguments: [String]) -> String {
        "git \(arguments.joined(separator: " "))"
    }

    private func isNotARepository(_ message: String) -> Bool {
        message.localizedCaseInsensitiveContains(
            "not a git repository"
        )
    }

    func stagedDiff() throws -> String {
        try run(["diff", "--cached", "--no-ext-diff"])
    }

    func stagedAndUnstagedDiff() throws -> String {
        let staged = try run(["diff", "--cached", "--no-ext-diff"])
        let unstaged = try run(["diff", "--no-ext-diff"])

        if staged.isEmpty && unstaged.isEmpty {
            throw GitError.noChanges
        }

        return """
            STAGED CHANGES:
            \(staged)

            UNSTAGED CHANGES:
            \(unstaged)
            """
    }

    func addAll() throws {
        _ = try run(["add", "."])
    }
    
    func commit(message: String, amend: Bool = false) throws {
        var arguments = ["commit"]
        if amend {
            arguments.append("--amend")
        }
        arguments += ["-m", message]

        _ = try run(arguments)
    }
}
