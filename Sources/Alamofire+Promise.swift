@_exported import Alamofire
import Foundation
#if !PMKCocoaPods
import PromiseKit
#endif

/**
 To import the `Alamofire` category:

     use_frameworks!
     pod "PromiseKit/Alamofire"

 And then in your sources:

     import PromiseKit
 */
extension Alamofire.DataRequest {
    /// Adds a handler to be called once the request has finished.
    public func response(_: PMKNamespacer) -> Promise<(URLRequest, HTTPURLResponse, Data)> {
        return Promise(.pending) { seal in
            response(queue: nil) { rsp in
                if let error = rsp.error {
                    seal.reject(error)
                } else if let a = rsp.request, let b = rsp.response, let c = rsp.data {
                    seal.fulfill((a, b, c))
                } else {
                    seal.reject(PMKError.invalidCallingConvention)
                }
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    public func responseData() -> Promise<(data: Data, response: PMKAlamofireDataResponse)> {
        return Promise(.pending) { seal in
            responseData(queue: nil) { response in
                switch response.result {
                case .success(let value):
                    seal.fulfill((value, PMKAlamofireDataResponse(response)))
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    public func responseString() -> Promise<(string: String, response: PMKAlamofireDataResponse)> {
        return Promise(.pending) { seal in
            responseString(queue: nil) { response in
                switch response.result {
                case .success(let value):
                    seal.fulfill((value, PMKAlamofireDataResponse(response)))
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    public func responseJSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        return Promise(.pending) { seal in
            responseJSON(queue: nil, options: options) { response in
                switch response.result {
                case .success(let value):
                    seal.fulfill((value, PMKAlamofireDataResponse(response)))
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    public func responsePropertyList(options: PropertyListSerialization.ReadOptions = PropertyListSerialization.ReadOptions()) -> Promise<(plist: Any, response: PMKAlamofireDataResponse)> {
        return Promise(.pending) { seal in
            responsePropertyList(queue: nil, options: options) { response in
                switch response.result {
                case .success(let value):
                    seal.fulfill((value, PMKAlamofireDataResponse(response)))
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}

extension Alamofire.DownloadRequest {
    public func response(_: PMKNamespacer) -> Promise<DefaultDownloadResponse> {
        return Promise(.pending) { seal in
            response(queue: nil) { response in
                if let error = response.error {
                    seal.reject(error)
                } else {
                    seal.fulfill(response)
                }
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    public func responseData() -> Promise<DownloadResponse<Data>> {
        return Promise(.pending) { seal in
            responseData(queue: nil) { response in
                switch response.result {
                case .success:
                    seal.fulfill(response)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}



public enum PMKAlamofireOptions {
    case response
}


public struct PMKAlamofireDataResponse {
    fileprivate init<T>(_ rawrsp: Alamofire.DataResponse<T>) {
        request = rawrsp.request
        response = rawrsp.response
        data = rawrsp.data
        timeline = rawrsp.timeline
    }

    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The data returned by the server.
    public let data: Data?

    /// The timeline of the complete lifecycle of the request.
    public let timeline: Timeline
}
