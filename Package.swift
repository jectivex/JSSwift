// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "JSSwift",
    products: [
        .library(
            name: "JSSwift",
            targets: ["JSSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jectivex/JXKit.git", .branch("main")),
        .package(url: "https://github.com/glimpseio/BricBrac.git", .branch("main")),
    ],
    targets: [
        .target(
            name: "JSSwift",
            dependencies: ["JXKit", "BricBrac"],
            resources: [.copy("Resources")]),
        .testTarget(
            name: "JSSwiftTests",
            dependencies: ["JSSwift"],
            resources: [.copy("TestResources")]),
    ]
)
