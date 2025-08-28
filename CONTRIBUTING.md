# Contributing to Rebrickable.framework

Thank you for your interest in contributing to Rebrickable.framework! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally
3. Create a new branch for your changes
4. Make your changes and test them
5. Submit a pull request

## Development Setup

### Prerequisites

- **Swift 6.1.2+**

### Setup Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/mpwg/Rebrickable.framework.git
   cd Rebrickable.framework
   ```

2. **Open in Xcode:**
   ```bash
   open Rebrickable.framework.xcodeproj
   ```

3. **Install development tools:**
   ```bash
   brew install swiftlint swiftformat
   ```

4. **Run initial build and tests:**
   ```bash
   xcodebuild build test -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework"
   ```

## Making Changes

### Branch Naming

Use descriptive branch names that reflect the type of work:

- `feature/add-new-api-endpoint`
- `fix/memory-leak-in-caching`
- `docs/update-readme`
- `refactor/simplify-error-handling`

### Commit Messages

Follow conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

Examples:
- `feat(api): add support for minifigure search`
- `fix(cache): resolve memory leak in image caching`
- `docs(readme): update installation instructions`
- `test(api): add tests for error handling`

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks
- `ci`: CI/CD changes

## Pull Request Process

1. **Ensure your branch is up to date:**
   ```bash
   git checkout main
   git pull upstream main
   git checkout your-branch
   git rebase main
   ```

2. **Run all checks locally:**
   ```bash
   # Format code
   swiftformat .
   
   # Lint code
   swiftlint
   
   # Build and test
   xcodebuild build test -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework"
   ```

3. **Create a pull request** with:
   - Clear title and description
   - Link to related issues
   - Screenshots if UI changes are involved
   - Test results if applicable

4. **Address review feedback** promptly and professionally

5. **Ensure CI passes** before requesting final review

## Coding Standards

### Swift Style

We use SwiftLint and SwiftFormat to enforce consistent code style. Key guidelines:

- **Indentation:** 4 spaces
- **Line Length:** Maximum 120 characters
- **Naming:** Use clear, descriptive names
- **Access Control:** Use the most restrictive access level possible
- **Comments:** Write meaningful comments for complex logic

### Code Organization

- **Files:** One type per file when possible
- **Extensions:** Use extensions to organize code by functionality
- **MARK comments:** Use `// MARK: -` to organize code sections
- **Imports:** Group and sort imports

### Error Handling

- Use `Result` types for operations that can fail
- Create specific error types for different failure scenarios
- Provide meaningful error messages
- Never force unwrap unless absolutely certain

### Async Operations

- Use Combine framework for async operations
- Return `AnyPublisher` for public APIs
- Handle cancellation properly
- Use appropriate schedulers

## Testing

### Test Requirements

- **Unit tests** for all new functionality
- **Integration tests** for API interactions
- **Mock data** for external dependencies
- **Error scenarios** must be tested

### Test Structure

```swift
// Arrange
let expectedResult = ExpectedData()
let mockService = MockService()

// Act
let result = try service.performOperation()

// Assert
XCTAssertEqual(result, expectedResult)
```

### Running Tests

```bash
# Run all tests
xcodebuild test -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework"

# Run specific test class
xcodebuild test -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework" -only-testing:Rebrickable_frameworkTests.LegoAPITests
```

### Coverage

- Maintain minimum 80% code coverage
- Focus on testing business logic and error paths
- Use code coverage reports to identify gaps

## Documentation

### Code Documentation

- Document all public APIs using Swift DocC format
- Include usage examples in documentation
- Document complex algorithms or business logic
- Keep documentation up to date with code changes

### README Updates

Update the README.md when adding:
- New features
- Installation instructions
- Usage examples
- Breaking changes

### DocC Documentation

```swift
/// Brief description of the method
/// 
/// Detailed description with usage information.
///
/// - Parameters:
///   - parameter1: Description of parameter1
///   - parameter2: Description of parameter2
/// - Returns: Description of return value
/// - Throws: Description of possible errors
///
/// ## Example
/// ```swift
/// let result = try method(parameter1: "value1", parameter2: "value2")
/// ```
public func method(parameter1: String, parameter2: String) throws -> Result {
    // Implementation
}
```

## Release Process

1. **Version Bumping:** Follow semantic versioning (MAJOR.MINOR.PATCH)
2. **Changelog:** Update CHANGELOG.md with new features and fixes
3. **Testing:** Ensure all tests pass and CI is green
4. **Tagging:** Create a git tag with the version number
5. **GitHub Release:** Create a GitHub release with release notes

## Getting Help

- **Issues:** Use GitHub issues for bugs and feature requests
- **Discussions:** Use GitHub discussions for questions and ideas
- **Documentation:** Check the project documentation first

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes for significant contributions
- Project documentation when appropriate

Thank you for contributing to Rebrickable.framework!