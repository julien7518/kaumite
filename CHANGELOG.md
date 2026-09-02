# Changelog

## v1.0.3

**🔧 Kaumite v1.0.3 - Verbose Mode & Context Validation**

This release adds debugging capabilities and smarter diff handling.

**What's new:**
✅ Added `--verbose` flag for detailed step-by-step output
✅ Context size validation — rejects diffs too large for the model
✅ Added `--amend` support for the `all` command
✅ Improved separation between staged and all-changes command logic

## v1.0.2

**🛠️ Kaumite v1.0.2 - Improved Git Repository Error Handling**

This patch release improves error handling when running Kaumite outside a Git repository.

**What's fixed:**
✅ Detects when the current directory is not a Git repository
✅ Displays a clear and user-friendly error message
✅ Prevents invalid git diff commands from being executed
✅ Avoids exposing confusing Git --no-index errors

## v1.0.1

**✨ Kaumite v1.0.1 - Smoother Command Experience**

This release improves the command-line experience and simplifies the internal command architecture.

**What's new:**
✅ Added a loading spinner while generating commit messages
✅ Refactored command execution into a shared runner
✅ Reduced duplicated code between staged and all-change commands
✅ Improved code organization and maintainability

## v1.0.0

**🚀 Kaumite v1.0.0 - Local-First AI Commit Messages**

Kaumite is now available as a **local-first** AI-powered Git commit message generator for macOS. No model downloads, no cloud dependencies — everything runs on-device using Apple Foundation Models.

**What's new:**
✅ Local-first architecture — no external model downloads required
✅ AI-generated Conventional Commits compliant messages
✅ Support for staged and unstaged changes
✅ Multi-language support (EN/FR/DE)
✅ Dry run and no-color modes

Built with Swift for macOS 26+ (Sequoia). Your code stays yours.
