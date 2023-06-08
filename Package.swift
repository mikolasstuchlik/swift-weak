// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "WeakMacro",
    platforms: [ .iOS("13.0"), .macOS("10.15")],
    products: [
        .library(name: "WeakMacro", targets: ["WeakMacro"]),
    ],
    dependencies: [
          .package(url: "https://github.com/apple/swift-syntax.git",branch: "main"),
        ],
    targets: [
        .macro(
            name: "WeakMacroPlugin",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftOperators", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
                .product(name: "SwiftParserDiagnostics", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .target(name: "WeakMacro"),
        .testTarget(name: "WeakTests", dependencies: ["WeakMacroPlugin"]),
    ]
)
