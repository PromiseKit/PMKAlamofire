// swift-tools-version:5.0

import PackageDescription

let pkg = Package(name: "PMKAlamofire")
pkg.products = [
    .library(name: "PMKAlamofire", targets: ["PMKAlamofire"]),
]
pkg.dependencies = [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.8.2"),
    .package(url: "https://github.com/mxcl/PromiseKit.git", from: "6.0.0")
]
pkg.swiftLanguageVersions = [.v3, .v4, .v4_2, .v5]

let target: Target = .target(name: "PMKAlamofire")
target.path = "Sources"
target.exclude = ["Tests"]
target.dependencies = [
    "PromiseKit",
    "Alamofire"
]

pkg.targets = [target]
