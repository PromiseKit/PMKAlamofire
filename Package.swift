import PackageDescription

let package = Package(
    name: "PMKAlamofire",
    dependencies: [
        .Package(url: "https://github.com/mxcl/PromiseKit.git", majorVersion: 6),
        .Package(url: "https://github.com/Alamofire/Alamofire.git", majorVersion: 5)
    ],
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    exclude: ["Tests"]
)
