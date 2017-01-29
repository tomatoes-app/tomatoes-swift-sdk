# Tomatoes Swift SDK

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
        .Package(url: "https://github.com/tomatoes-app/tomatoes-swift-sdk.git", Version(0,1,0))
    ])
````
## Usage

### Request user info

```Swift
User.read { (result, error) in
    if let user = result as? User {
        print(user)
    }
}
````
