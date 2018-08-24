import PackageDescription

let package = Package(
    name: "PMKAlamofire",
    dependencies: [
        .Package(url: "https://github.com/mxcl/PromiseKit.git", majorVersion: 4),
        .Package(url: "https://github.com/Alamofire/Alamofire.git", majorVersion: 4),
//      .Package(url: "https://github.com/PromiseKit/Cancel.git", majorVersion: 1),
        .Package(url: "https://github.com/dougzilla32/Cancel.git", majorVersion: 1)
    ],
    exclude: ["Tests"]
)
