# Kaumite

**A local-first AI-powered Git commit message generator for macOS, built with Swift and Apple Foundation Models.**

Kaumite analyzes your Git changes (staged or unstaged) and automatically generates **Conventional Commits**-compliant messages using Apple's on-device machine learning models. No model downloads required - everything runs locally on your machine.

## Features

- **Local-first**: No model downloads required - uses Apple's on-device Foundation Models
- **AI-generated commit messages**: Analyzes your diff and creates meaningful commit messages
- **Conventional Commits support**: Follows [Conventional Commits](https://www.conventionalcommits.org/) specification
- **Flexible workflows**:
  - Generate messages for **staged changes only** (`staged` command)
  - Generate messages for **all changes** (staged + unstaged) (`all` command)
- **Multi-language support**: English, French, German
- **Dry run mode**: Preview the commit message without actually committing
- **No-color mode**: For CI/CD environments or personal preference

## Requirements

- macOS 26+ (Sequoia)
- Xcode 16+
- Swift 6.4+
- Git repository

## Installation

### Using Swift Package Manager (Recommended)

```bash
git clone https://github.com/your-username/kaumite.git
cd kaumite
swift build -c release
sudo cp .build/release/kaumite /usr/local/bin/kaumite
```

## Usage

```bash
kaumite [command] [options]

Commands:
  all       Generate commit message for all changes
  staged    Generate commit message for staged changes

Options:
  --lang <language>    Commit message language (en, fr, de)
  --dry-run            Preview commit message without committing
  --no-color           Disable colored output
  -h, --help           Show help message
  -v, --version        Show version
```

## How It Works

1. **Diff Analysis**: Kaumite collects the Git diff (staged, unstaged, or both)
2. **AI Processing**: The diff is sent to Apple's Foundation Model with a specialized prompt
3. **Message Generation**: The AI generates a commit message following Conventional Commits rules
4. **Output**: The message is displayed and optionally committed

## License

[MIT License](LICENSE.md)
