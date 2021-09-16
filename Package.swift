// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "ZoomCollectionView",
    platforms: [
        .iOS(.v10_1),
    ],
    products: [
        .library(
            name: "ZoomCollectionView",
            targets: ["ZoomCollectionView"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ZoomCollectionView",
            dependencies: [],
            path: "Source")
    ]
)
