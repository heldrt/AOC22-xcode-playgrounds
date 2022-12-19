// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swifties",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
//        .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", from: "5.3.0")
        //.package(url: "https://github.com/SwiftGen/SwiftGen.git", from: "6.6.2")
//        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.2"),
        //             https://github.com/SwiftGen/SwiftGen.git
        .package(url: "https://github.com/davecom/SwiftGraph", .upToNextMajor(from: "3.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "swifties",
            dependencies: []
//                  plugins: [
//                    .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
//                  ]
//            ,resources: [.copy("Resources"), .process("test69")]
        ),
    ]
)
