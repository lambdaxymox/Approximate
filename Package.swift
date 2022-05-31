// swift-tools-version: 5.6
import PackageDescription


let package = Package(
    name: "Approximate",
    products: [
        .library(
            name: "Approximate",
            targets: ["Approximate"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Approximate",
            dependencies: [],
            path: ".",
            exclude: ["README.md", "Tests", "LICENSE-APACHE", "LICENSE-MIT"],
            sources: ["Sources"]),
        .testTarget(
            name: "ApproximateTests",
            dependencies: ["Approximate"]),
    ]
)

