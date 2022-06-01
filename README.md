# Approximate

Approximate floating point equality comparisons for the Swift Programming Language.

## Introduction
**Approximate** is a Swift package that provides implementations of floating point comparisons 
for the Swift ecosystem. It is generally not correct behavior to compare two floating 
point numbers for equality or inequality using exact equality comparisons, due to the 
imprecise nature of floating point arithmetic. In its place one uses approximate 
comparisons instead. Floating point numbers are counterintuitive creatures, so one needs 
to approach them differently than integers.

## Usage
To use **Approximate** in your projects, add the following line to the dependencies
list in your swift package manifest
```swift
dependencies: [
    .package(url: "https://github.com/lambdaxymox/Approximate", .branch("master")),
]
```
and the following line to each of your desired targets
```swift
.product(name: "Approximate", package: "Approximate")
```
For example, your Swift package manifest may look like
```swift
// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "my-app",
    dependencies: [
        .package(url: "https://github.com/lambdaxymox/Approximate", from: "1.0.1"),
    ],
    targets: [
        .target(name: "my-app", dependencies: [
            .product(name: "Approximate", package: "Approximate"),
        ]),
    ]
)
```
Finally import the library
```swift
import Approximate
```
and use it in your project.

## Features
This library provides the three standard forms of approximate equality 
comparisons for floating point numbers in Swift. These are absolute difference 
equality, units in last place (ULPS) equality, and relative equality. 

## References
Some references going in depth about comparing floating point numbers and their 
tricky subtleties.
- [Comparing Floating Point Numbers, 2012 Edition](https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
- [The Floating-Point Guide](https://floating-point-gui.de/errors/comparison/)
- [What Every Computer Scientist Should Know About Floating-Point Arithmetic](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html)

