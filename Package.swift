// swift-tools-version:5.6

import PackageDescription

var package = Package(
  name: "Lighter",

  platforms: [ .macOS(.v10_15), .iOS(.v13) ],
  
  products: [
    .library(name: "Lighter", targets: [ "Lighter" ])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  ],
  targets: [
    .target(name: "Lighter")
  ]
)
