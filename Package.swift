// swift-tools-version:5.1
import PackageDescription

let package = Package(name: "PMKAlamofire",
                      platforms: [.macOS(.v10_12),
                                  .iOS(.v10),
                                  .tvOS(.v10),
                                  .watchOS(.v3)],
                      products: [.library(name: "PMKAlamofire",
                                          targets: ["PMKAlamofire"])],
                      targets: [.target(name: "PMKAlamofire",
                                        path: "Source"],
                      dependencies: [.Package(url: "https://github.com/mxcl/PromiseKit.git", majorVersion: 6),
                                     .Package(url: "https://github.com/Alamofire/Alamofire.git", majorVersion: 5)],
                      swiftLanguageVersions: [.v5],
                      exclude: ["Tests"])
