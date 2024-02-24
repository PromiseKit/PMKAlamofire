// swift-tools-version:5.1

import PackageDescription

let package = Package(
        name: "PMKAlamofire",
        platforms: [.macOS(.v10_12),
                    .iOS(.v10),
                    .tvOS(.v10),
                    .watchOS(.v3)],
        products: [
            .library(name: "PMKAlamofire", targets: ["PMKAlamofire"])
        ],
        dependencies: [
            .package(url: "https://github.com/mxcl/PromiseKit.git", from: "8.1.1"),
            .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.1"),
            .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", from: "9.1.0")
        ],
        targets: [
            .target(
                name: "PMKAlamofire",
                dependencies: [
                    .product(name: "PromiseKit", package: "PromiseKit"),
                    .product(name: "Alamofire", package: "Alamofire"),
                ],
                path: "Sources"
            ),
            .testTarget(
                name: "PMKAlamofireTests",
                dependencies: [
                    .target(name: "PMKAlamofire"),
                    .product(name: "OHHTTPStubs")
                ],
                path: "Tests"
            )
        ],
        swiftLanguageVersions: [.v5])
