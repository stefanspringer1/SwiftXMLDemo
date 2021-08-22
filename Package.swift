// swift-tools-version:5.4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftXMLDemo",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/stefanspringer1/SwiftXML.git", from: "0.1.6"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "SwiftXMLDemo",
            dependencies: ["SwiftXML"]),
        .testTarget(
            name: "SwiftXMLDemoTests",
            dependencies: ["SwiftXMLDemo"]),
    ]
)
