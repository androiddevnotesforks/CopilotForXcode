// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Service",
            targets: [
                "Service",
                "SuggestionInjector",
                "FileChangeChecker",
                "LaunchAgentManager",
                "UpdateChecker",
                "Logger",
            ]
        ),
        .library(
            name: "Client",
            targets: [
                "SuggestionModel",
                "Client",
                "XPCShared",
                "Preferences",
                "LaunchAgentManager",
                "Logger",
                "UpdateChecker",
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/LanguageClient", from: "0.3.1"),
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.1.0"),
        .package(url: "https://github.com/raspu/Highlightr", from: "2.1.0"),
        .package(url: "https://github.com/JohnSundell/Splash", branch: "master"),
        .package(url: "https://github.com/nmdias/FeedKit", from: "9.1.2"),
        .package(url: "https://github.com/gonzalezreal/swift-markdown-ui", from: "2.1.0"),
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.0.0"),
        .package(url: "https://github.com/alfianlosari/GPTEncoder", from: "1.0.4"),
    ],
    targets: [
        .target(name: "CGEventObserver"),
        .target(
            name: "GitHubCopilotService",
            dependencies: ["LanguageClient", "SuggestionModel", "XPCShared", "Preferences"]
        ),
        .testTarget(
            name: "GitHubCopilotServiceTests",
            dependencies: ["GitHubCopilotService"]
        ),
        .target(
            name: "SuggestionModel",
            dependencies: ["LanguageClient"]
        ),
        .testTarget(
            name: "SuggestionModelTests",
            dependencies: ["SuggestionModel"]
        ),
        .target(
            name: "SuggestionInjector",
            dependencies: ["SuggestionModel"]
        ),
        .testTarget(
            name: "SuggestionInjectorTests",
            dependencies: ["SuggestionInjector"]
        ),
        .target(
            name: "Client",
            dependencies: ["SuggestionModel", "Preferences", "XPCShared", "Logger"]
        ),
        .target(
            name: "Service",
            dependencies: [
                "SuggestionModel",
                "GitHubCopilotService",
                "OpenAIService",
                "Preferences",
                "XPCShared",
                "CGEventObserver",
                "DisplayLink",
                "ActiveApplicationMonitor",
                "AXNotificationStream",
                "Environment",
                "SuggestionWidget",
                "AXExtension",
                "Logger",
                "ChatService",
                "PromptToCodeService",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ]
        ),
        .target(
            name: "XPCShared",
            dependencies: ["SuggestionModel"]
        ),
        .testTarget(
            name: "ServiceTests",
            dependencies: [
                "Service",
                "Client",
                "GitHubCopilotService",
                "SuggestionInjector",
                "Preferences",
                "XPCShared",
                "Environment",
            ]
        ),
        .target(name: "FileChangeChecker"),
        .target(name: "LaunchAgentManager"),
        .target(name: "DisplayLink"),
        .target(name: "ActiveApplicationMonitor"),
        .target(name: "AXNotificationStream"),
        .target(
            name: "Environment",
            dependencies: ["ActiveApplicationMonitor", "GitHubCopilotService", "AXExtension"]
        ),
        .target(
            name: "SuggestionWidget",
            dependencies: [
                "ActiveApplicationMonitor",
                "AXNotificationStream",
                "Environment",
                "Highlightr",
                "Splash",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
                .product(name: "MarkdownUI", package: "swift-markdown-ui"),
            ]
        ),
        .testTarget(name: "SuggestionWidgetTests", dependencies: ["SuggestionWidget"]),
        .target(
            name: "UpdateChecker",
            dependencies: [
                "Logger",
                "Sparkle",
                .product(name: "FeedKit", package: "FeedKit"),
            ]
        ),
        .target(name: "AXExtension"),
        .target(name: "Logger"),
        .target(
            name: "OpenAIService",
            dependencies: [
                "Logger",
                "Preferences",
                "GPTEncoder",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ]
        ),
        .testTarget(
            name: "OpenAIServiceTests",
            dependencies: ["OpenAIService"]
        ),
        .target(name: "Preferences"),
        .target(name: "ChatPlugins", dependencies: ["OpenAIService", "Environment", "Terminal"]),
        .target(name: "Terminal"),
        .target(name: "ChatService", dependencies: ["OpenAIService", "ChatPlugins", "Environment"]),
        .target(
            name: "PromptToCodeService",
            dependencies: ["OpenAIService", "Environment", "GitHubCopilotService", "SuggestionModel"]
        ),
        .testTarget(name: "PromptToCodeServiceTests", dependencies: ["PromptToCodeService"]),
        .target(name: "SuggestionService", dependencies: [
            "GitHubCopilotService",
        ])
    ]
)
