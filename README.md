# ``Rebrickable.framework``

## **Rebrickable.framework** is a framework that uses [Rebrickable APIs](https://rebrickable.com/api/v3/docs/?key=5d31bd9f6fe3ad39cbcc573bd64bada1) to build their own apps that want to use the Rebrickable database.

## Thanks
Thank you https://github.com/renTramontano/RebrickableSDK for the implementation of the SDK. I just converted it to a framework.

## Getting Started
### Installation with Swift Package Manager
Add the following to your **Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/mpwg/RebrickableSDK.git", .upToNextMajor(from: "1.0.1"))
]
``` 

### Installation
```
$ git clone https://github.com/mpwg/RebrickableSDK
```

### Usage
To use the SDK generate the [API Key](https://rebrickable.com/)
```swift
let legoApi = LegoAPI(apiKey: "<YOUR_API_KEY>")
```

## License
RebrickableSDK is licensed under the AGPL3 License. See the LICENSE file for more information.
