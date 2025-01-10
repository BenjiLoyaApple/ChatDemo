// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "GossipPackage",
    platforms: [.iOS(.v17)],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.12.0")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/SwiftfulThinking/SwiftfulUI", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/SwiftfulThinking/SwiftfulRouting", .upToNextMajor(from: "5.3.6"))
    ]
)
