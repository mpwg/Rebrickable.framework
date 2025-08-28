import Foundation

/// Test configuration for API keys and test data
enum TestConfig {
    /// Test API key - either from environment variable or a safe test placeholder
    static let testApiKey: String = {
        // Try to get from environment variable first
        if let envKey = ProcessInfo.processInfo.environment["REBRICKABLE_TEST_API_KEY"] {
            return envKey
        }
        
        // Fallback to a safe test placeholder that won't work with real API
        // but allows tests to run with mocked responses
        return "test-api-key-placeholder-for-mocked-tests"
    }()
}