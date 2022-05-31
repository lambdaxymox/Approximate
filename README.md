# Approximate

Approximate floating point equality comparisons and assertions for the Swift 
Programming Language.

## Introduction
This Swift package provides implementations of floating point comparisons for the Swift 
ecosystem. It is generally not correct behavior to compare two floating point numbers 
for equality or inequality using exact equality comparisons, due to the imprecise 
nature of floating point arithmetic. In its place one uses approximate comparisons 
instead. Floating point numbers are counter-intuitive creatures, so we need to
approach them differently than integer or rational numbers.

## Usage

## Features
This library provides the three standard forms of approximate equality 
comparisons for floating point numbers in Swift. These are absolute difference 
equality, units in last place (ULPS) equality, and relative equality. 

## References
Some references going in depth about comparing floating point numbers and their 
tricky subtlties.
- [Comparing Floating Point Numbers, 2012 Edition](https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
- [The Floating-Point Guide](https://floating-point-gui.de/errors/comparison/)
- [What Every Computer Scientist Should Know About Floating-Point Arithmetic](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html)
