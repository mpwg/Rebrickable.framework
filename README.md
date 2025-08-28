# Rebrickable.framework

[![CI](https://github.com/mpwg/Rebrickable.framework/actions/workflows/ci.yml/badge.svg)](https://github.com/mpwg/Rebrickable.framework/actions/workflows/ci.yml)
[![Security](https://github.com/mpwg/Rebrickable.framework/actions/workflows/security.yml/badge.svg)](https://github.com/mpwg/Rebrickable.framework/actions/workflows/security.yml)
[![Documentation](https://github.com/mpwg/Rebrickable.framework/actions/workflows/documentation.yml/badge.svg)](https://github.com/mpwg/Rebrickable.framework/actions/workflows/documentation.yml)
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![Swift 6.1.2](https://img.shields.io/badge/Swift-6.1.2-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com)

**Rebrickable.framework** is a Swift framework that provides an easy-to-use wrapper around the [Rebrickable APIs](https://rebrickable.com/api/v3/docs/) for building LEGO-related applications. Access the comprehensive Rebrickable database of LEGO sets, parts, colors, and user inventory data.

## 🚀 Features

- **Complete API Coverage**: Support for all Rebrickable API endpoints
- **Type-Safe**: Strongly typed models for all LEGO data
- **Async/Await Ready**: Built with Combine framework for modern Swift async programming
- **Comprehensive Testing**: Extensive test suite with mock data
- **Documentation**: Full DocC documentation with examples
- **CI/CD Ready**: Automated testing, code quality, and security scanning

## 📋 Requirements

- iOS 26.0+ / macOS 26.0+ / xrOS 26.0+
- Xcode 16.0+
- Swift 5.9+

## 📦 Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/mpwg/Rebrickable.framework.git", from: "1.0.0")
]
```

Or in Xcode:
1. Go to **File** → **Add Package Dependencies**
2. Enter: `https://github.com/mpwg/Rebrickable.framework.git`
3. Select your desired version

### Manual Installation

```bash
git clone https://github.com/mpwg/Rebrickable.framework.git
```

## 🔧 Usage

### Basic Setup

First, generate your [API Key](https://rebrickable.com/api/) from Rebrickable:

```swift
import Rebrickable_framework

let legoApi = LegoAPI(apiKey: "your-api-key-here")
```

### Fetching LEGO Data

```swift
import Combine

// Get all LEGO colors
legoApi.getColors()
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Completed successfully")
            case .failure(let error):
                print("Error: \(error)")
            }
        },
        receiveValue: { colors in
            print("Found \(colors.count) colors")
            for color in colors {
                print("- \(color.name)")
            }
        }
    )
    .store(in: &cancellables)

// Get specific LEGO set
legoApi.getSetDetails(with: "75192-1")
    .sink(
        receiveCompletion: { _ in },
        receiveValue: { set in
            print("Set: \(set.name)")
            print("Year: \(set.year)")
            print("Pieces: \(set.numParts)")
        }
    )
    .store(in: &cancellables)
```

### Error Handling

```swift
legoApi.getSetDetails(with: "invalid-set")
    .sink(
        receiveCompletion: { completion in
            if case .failure(let error) = completion {
                switch error {
                case .notFound:
                    print("Set not found")
                case .networkError(let underlying):
                    print("Network error: \(underlying)")
                case .decodingError(let underlying):
                    print("Failed to decode response: \(underlying)")
                default:
                    print("Unknown error: \(error)")
                }
            }
        },
        receiveValue: { _ in }
    )
    .store(in: &cancellables)
```

## 📖 Documentation

- **[API Documentation](https://mpwg.github.io/Rebrickable.framework/)** - Complete framework documentation
- **[Contributing Guide](CONTRIBUTING.md)** - How to contribute to the project
- **[Changelog](CHANGELOG.md)** - Version history and changes

## 🏗️ Development

### Prerequisites

- Xcode 16.0+
- macOS 14.0+
- SwiftLint and SwiftFormat (installed via Homebrew)

### Setup

```bash
# Clone the repository
git clone https://github.com/mpwg/Rebrickable.framework.git
cd Rebrickable.framework

# Install development tools
brew install swiftlint swiftformat

# Open in Xcode
open Rebrickable.framework.xcodeproj
```

### Running Tests

```bash
# Run all tests
xcodebuild test -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework"

# Run specific test class
xcodebuild test -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework" -only-testing:Rebrickable_frameworkTests.LegoAPITests
```

### Code Quality

```bash
# Format code
swiftformat .

# Lint code
swiftlint

# Auto-fix linting issues
swiftlint --fix
```

## 🔒 Security

This project includes comprehensive security measures:

- **CodeQL Analysis**: Automated security scanning
- **Dependency Review**: Monitor dependencies for vulnerabilities
- **Secret Scanning**: Prevent accidental secret commits
- **Regular Updates**: Automated dependency updates via Dependabot

Report security vulnerabilities privately through GitHub's security advisory system.

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details on:

- Code of conduct
- Development setup
- Pull request process
- Coding standards
- Testing requirements

## 📊 CI/CD Pipeline

This project includes a comprehensive CI/CD pipeline:

- **✅ Continuous Integration**: Automated testing on multiple iOS/macOS versions
- **🔍 Code Quality**: SwiftLint, SwiftFormat, and complexity analysis
- **🛡️ Security Scanning**: CodeQL, dependency review, and secret detection
- **📚 Documentation**: Automated documentation generation and deployment
- **🚀 Release Automation**: Automated releases with changelog generation
- **📈 Performance Monitoring**: Build time analysis and memory leak detection
- **🏥 Repository Health**: Weekly health checks and monitoring

## 🙏 Acknowledgments

Thank you to [renTramontano/RebrickableSDK](https://github.com/renTramontano/RebrickableSDK) for the original SDK implementation. This framework builds upon that foundation with modern Swift features and comprehensive tooling.

## 📄 License

Rebrickable.framework is licensed under the **AGPL-3.0 License**. See the [LICENSE](LICENSE) file for more information.

## 🔗 Links

- **[Rebrickable Website](https://rebrickable.com)** - Official Rebrickable website
- **[Rebrickable API Documentation](https://rebrickable.com/api/v3/docs/)** - Official API documentation
- **[GitHub Repository](https://github.com/mpwg/Rebrickable.framework)** - Source code and issues
- **[GitHub Releases](https://github.com/mpwg/Rebrickable.framework/releases)** - Release history and downloads
