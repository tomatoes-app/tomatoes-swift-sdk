# Tomatoes Swift SDK
[![Build Status](https://travis-ci.org/tomatoes-app/tomatoes-swift-sdk.svg?branch=master)](https://travis-ci.org/tomatoes-app/tomatoes-swift-sdk)

The Tomatoes Swift SDK allows developers to quickly integrate Tomatoes services into their Swift applications. 
See [API reference](http://www.tomato.es/pages/api_reference) for more details.

## Requirements

- iOS 9.0+ / macOS 10.11+
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
github "tomatoes-app/tomatoes-swift-sdk" ~> 0.2.1
```

Run `carthage update` to build the framework and drag the built `Tomatoes.framework` into your Xcode project.

### Swift Package Manager

Add the following code to your `Package.swift` file and run `swift build`.

```Swift
import PackageDescription

let package = Package(
    name: "tomatoes-swift-sdk",
    dependencies: [
        .Package(url: "https://github.com/tomatoes-app/tomatoes-swift-sdk.git", Version(0,2,1))
    ])
```
### App Transport Security

App Transport Security was introduced with iOS 9 to enforce secure Internet connections, but Tomatoes doesn't support HTTPS yet. Allow insecure connections to Tomatoes by adding the following exception to your application's `Info.plist` file.

```xml
<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>www.tomato.es</key>
			<dict>
				<key>NSExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSTemporaryExceptionMinimumTLSVersion</key>
				<string>TLSv1.1</string>
			</dict>
		</dict>
	</dict>
```

## Usage
Review the iOS [sample application](https://github.com/tomatoes-app/tomatoes-ios)

### Create a Tomatoes session

To establish a new Tomatoes session you'll need to implement GitHub auth and retrieve a GitHub user access token, see [GitHub doc](https://developer.github.com/v3/oauth_authorizations/). Leave the default scope.

Then you can use the GitHub access token to create a new Tomatoes session as follow:

```Swift
 let session = Session(provider: .github, accessToken: <github-access-token>)
 session.create { (result) in
    switch result {
    case .success: print("You are authenticated")
    case .failure(let error): print(error?.localizedDescription ?? "no error description")
   }
 }
```
__Note: Tomatoes new session requests will return an access token that the SDK will store in the keychain. The SDK will try to apply the token stored in the keychain to send requests to Tomatoes that need authentication.__

### Request user info

```Swift
User.read { (result) in
    switch result {
    case .success(let user): print(user.name)
    case .failure(let error): print(error?.localizedDescription)
    }
}
```
