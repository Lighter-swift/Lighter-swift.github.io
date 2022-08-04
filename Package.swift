// swift-tools-version:5.6

import PackageDescription

var package = Package(
  name: "Lighter",

  platforms: [ .macOS(.v10_15), .iOS(.v13) ],
  
  products: [
    .library(name: "Lighter",         targets: [ "Lighter"       ]),
    .library(name: "SQLite3Schema",   targets: [ "SQLite3Schema" ])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  ],
  targets: [
    .target(name: "SQLite3Schema", exclude: [ "README.md" ]),
    .target(name: "Lighter")
  ]
)

#if !(os(macOS) || os(iOS) || os(watchOS) || os(tvOS))
package.products += [ .library(name: "SQLite3", targets: [ "SQLite3" ]) ]
package.targets += [
  .systemLibrary(name: "SQLite3",
                 path: "Sources/SQLite3-Linux",
                 providers: [ .apt(["libsqlite3-dev"]) ])
]
package.targets
  .first(where: { $0.name == "SQLite3Schema" })?
  .dependencies.append("SQLite3")
package.targets
  .first(where: { $0.name == "Lighter" })?
  .dependencies.append("SQLite3")
#endif // not-Darwin