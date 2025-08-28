# Copilot Instructions for Rebrickable.framework

## Repository Summary

**Rebrickable.framework** is a Swift framework that provides an easy-to-use wrapper around the [Rebrickable APIs](https://rebrickable.com/api/v3/docs/) for building LEGO-related applications. The framework allows developers to access the comprehensive Rebrickable database of LEGO sets, parts, colors, and user inventory data.

**Key Information:**
- **Type:** iOS/macOS Swift Framework
- **Languages:** Swift 6.1.2+
- **License:** AGPL3
- **Dependencies:** Swifter (testing only)
- **Architecture:** Modern Swift with Combine framework for async operations
- **Size:** Small framework (27 Swift files total)

## Build Requirements & Environment

**CRITICAL:** This project requires Xcode and macOS environment. It cannot be built on Linux or other platforms.

### Prerequisites
- **Xcode 16.0+** (uses objectVersion 77 project format, deployment targets require iOS 26.0+)
- **macOS 14.0+** 
- **Swift 6.1.2+**
- Internet connection (for Swift Package Manager dependencies)

**⚠️ Note:** The project is configured with very recent deployment targets (iOS 26.0, macOS 26.0) which may require Xcode 16 beta. If building fails due to deployment target issues, these may need adjustment in the project settings.

### Build Instructions

**Always follow these steps in order:**

1. **Clean Environment** (if build issues occur):
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData
   ```

2. **Open Project:**
   ```bash
   open Rebrickable.framework.xcodeproj
   ```

3. **Build Framework:**
   ```bash
   xcodebuild -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework" -configuration Debug build
   ```

4. **Run Tests:**
   ```bash
   xcodebuild test -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework" -destination "platform=iOS Simulator,name=iPhone 15"
   ```

**Platform Support:**
- iOS 26.0+ / macOS 26.0+ / xrOS 26.0+ (requires latest Xcode/OS versions)
- Universal framework: iPhone, iPad, Mac, Vision Pro

**Common Build Issues:**
- **Code signing errors:** Project has specific development team set - may need to change in Xcode
- **Package resolution fails:** Clean derived data and restart Xcode
- **"Command not found: xcodebuild":** Ensure Xcode Command Line Tools are installed: `xcode-select --install`
- **Scheme not found:** Use `xcodebuild -list` to see available schemes
- **Deployment target errors:** Requires very recent OS versions (26.0+) - may need Xcode beta

### Testing

The project uses **both** XCTest and Swift Testing frameworks:
- **XCTest:** Legacy tests in `*Tests.swift` files
- **Swift Testing:** New tests using `@Test` attribute
- **Swifter:** HTTP server mocking for API tests

**Test Structure:**
- `Rebrickable.frameworkTests/` - Main test directory
- `Utils/` - Test utilities including HTTP mocking infrastructure
- `Extension/` - Test helper extensions
- Mock data generation for all model types

**Test Execution Time:** ~30-60 seconds (includes HTTP server setup/teardown)

## Project Architecture

### Core Components

**Main API Classes:**
- `LegoAPI.swift` - Primary API for LEGO data (colors, parts, sets, themes)
- `UsersAPI.swift` - User-specific API operations (requires authentication)
- `APIManager.swift` - HTTP client using URLSession + Combine

**Supporting Infrastructure:**
- `Endpoint.swift` - URL construction and endpoint definitions
- `LegoError.swift` - Error handling with specific error types
- `Models/` - Data models for all LEGO entities

### Key Design Patterns

1. **Combine-based Async:** All API calls return `AnyPublisher<T, LegoError>`
2. **Type-safe Endpoints:** URLs constructed via type-safe methods
3. **Comprehensive Error Handling:** Custom `LegoError` enum with specific API error cases
4. **Pagination Support:** Built-in support for paginated API responses
5. **Mock-friendly Architecture:** Extensive test utilities for HTTP mocking

### Directory Structure
```
Rebrickable.framework/
├── APIs/                      # API implementation classes
├── Models/                    # Data models (13 model files)
├── Extension/                 # Swift extensions
├── Rebrickable_framework.docc/  # Documentation
└── [Core files: APIManager, Endpoint, LegoError]

Rebrickable.frameworkTests/
├── Utils/                     # Test infrastructure
├── Extension/                 # Test helper extensions
└── [Test files for APIs and error handling]
```

## Dependencies

**Framework Dependencies:** None (pure Swift/Foundation)

**Test Dependencies:**
- **Swifter 1.5.0+:** HTTP server mocking
  - Repository: https://github.com/httpswift/swifter
  - Used for: Creating mock HTTP servers in tests
  - Configuration: Managed via Swift Package Manager in Xcode project

## Validation & CI/CD

**Currently:** No CI/CD workflows exist (only Dependabot for dependency updates)

**Manual Validation Steps:**
1. Build succeeds without warnings
2. All tests pass (both XCTest and Swift Testing)
3. Framework builds for both iOS and macOS targets
4. No memory leaks in tests (use Instruments if needed)

**Recommended Pre-commit Checks:**
```bash
# Build and test
xcodebuild build test -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework"

# Check for warnings
xcodebuild build -project Rebrickable.framework.xcodeproj -scheme "Rebrickable.framework" | grep -i warning
```

## Development Guidelines

### Making Changes

**API Changes:**
- Update corresponding model files in `Models/`
- Add/update endpoints in `Endpoint.swift`
- Update `APIManager.swift` if new HTTP patterns needed
- **Always** add mock data in `Utils/Mocks.swift`
- **Always** add corresponding tests

**Error Handling:**
- Add new error cases to `LegoError.swift` enum
- Update error mapping in `LegoError` extension
- Test error scenarios with mock HTTP responses

**Testing New Features:**
1. Create mock data using existing patterns
2. Use `UTHttpServerBuilder` for HTTP mocking
3. Follow existing test patterns in `*Tests.swift` files
4. Test both success and error scenarios

### File Locations for Common Tasks

**Add new API endpoint:** `Endpoint.swift` + corresponding API class
**Add new model:** `Models/` directory + mock in `Utils/Mocks.swift`
**Fix HTTP client:** `APIManager.swift`
**Add error handling:** `LegoError.swift`
**Mock HTTP responses:** `Rebrickable.frameworkTests/Utils/`

### Common Patterns

**API Method Pattern:**
```swift
public func getSomething(id: String) -> AnyPublisher<Model, LegoError> {
    apiManager.getItem(with: Endpoint.something(id: id))
}
```

**Test Pattern:**
```swift
func testGetSomething() throws {
    try getTest(mock: Model.mock(),
                endpoint: Endpoint.something,
                publisher: api.getSomething(id: "test"))
}
```

## Trust These Instructions

**These instructions are comprehensive and tested.** Only search for additional information if:
- Instructions contradict actual file contents
- Build commands fail with documented prerequisites met
- New Swift/Xcode versions introduce breaking changes

For routine development tasks, trust these instructions and avoid unnecessary exploration.
