# Tomatoes Swift SDK
[![Build Status](https://travis-ci.org/tomatoes-app/tomatoes-swift-sdk.svg?branch=master)](https://travis-ci.org/tomatoes-app/tomatoes-swift-sdk)
## Requirements

- iOS 10.0+ / macOS 10.10+
- Xcode 8.1+
- Swift 3.0+

## Installation
### Carthage

You can install [Carthage](https://github.com/Carthage/Carthage) with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Tomatoes Swift SDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "tomatoes-app/tomatoes-swift-sdk" ~> 0.1.0
```

Run `carthage update` to build the framework and drag the built `Tomatoes.framework` into your Xcode project.

### Swift Package Manager

Add the following text to your `Package.swift` file and run `swift build`.

```Swift
import PackageDescription

let package = Package(
    name: "tomatoes-swift-sdk",
    dependencies: [
        .Package(url: "https://github.com/tomatoes-app/tomatoes-swift-sdk.git", Version(0,2,1))
    ])
````
## Usage

### Request user info

```Swift
User.read { (result) in
    switch result {
    case .success(let user): print(user.name)
    case .failure(let error): print(error?.localizedDescription)
    }
}
````
