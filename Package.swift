// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-rfc-2388",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(
            name: "RFC 2388",
            targets: ["RFC 2388"]
        )
    ],
    dependencies: [
        .package(path: "../swift-ieee-754"),
        .package(path: "../swift-whatwg-url")
    ],
    targets: [
        .target(
            name: "RFC 2388",
            dependencies: [
                .product(name: "IEEE 754", package: "swift-ieee-754"),
                .product(name: "WHATWG Form URL Encoded", package: "swift-whatwg-url")
    ]
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
    var foundation: Self { self + " Foundation" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility")
    ]
}
