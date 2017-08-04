# PromiseKit Alamofire Extensions ![Build Status]

This project adds promises to [Alamofire](https://github.com/Alamofire/Alamofire).

This project supports Swift 3.1, 3.2 and 4.0.

## Usage

```swift
Alamofire.request("https://httpbin.org/get", withMethod: .GET)
    .responseJSON().then { json in
        //…
    }.catch{ error in
        //…
    }
```

Of course, the whole point in promises is composability, so:

```swift
func login() -> Promise<User> {
    let q = DispatchQueue.global()
    UIApplication.shared.isNetworkActivityIndicatorVisible = true

    return firstly { in
        Alamofire.request(url, method: .get).responseData()
    }.then(on: q) { data in
        convertToUser(data)
    }.always {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

firstly {
    login()
}.then { user in
    //…
}.catch { error in
   UIAlertController(/*…*/).show() 
}
```

## CococaPods

```ruby
# Podfile
pod 'PromiseKit/Alamofire', '~> 4.0'
```

```swift
// `.swift` files
import PromiseKit
import Alamofire
```

```objc
// `.m files`
@import PromiseKit;
@import Alamofire;
```

## Carthage

```ruby
github "PromiseKit/Alamofire-" ~> 1.0
```

The extensions are built into their own framework:

```swift
// `.swift` files
import PromiseKit
import PMKAlamofire
```

```objc
// `.m files`
@import PromiseKit;
@import PMKAlamofire;
```

## SwiftPM

```swift
let package = Package(
    dependencies: [
        .Target(url: "https://github.com/PromiseKit/Alamofire", majorVersion: 1)
    ]
)
```


[Build Status]: https://travis-ci.org/PromiseKit/Alamofire.svg?branch=master
