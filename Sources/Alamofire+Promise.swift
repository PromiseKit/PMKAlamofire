@_exported import Alamofire
import Foundation
#if !PMKCocoaPods
import PromiseKit
#endif

/// Extend Request to be a CancellableTask
extension Request: CancellableTask {
    /// `true` if the Alamofire request was successfully cancelled, `false` otherwise
    public var isCancelled: Bool {
        return task?.state == .canceling
    }
}

/**
 To import the `Alamofire` category:

     use_frameworks!
     pod "PromiseKit/Alamofire"

 And then in your sources:

     import PromiseKit
 */
extension Alamofire.DataRequest {
    /// Adds a handler to be called once the request has finished.
    /// - Note: cancelling this promise will cancel the underlying task
    /// - SeeAlso: [Cancellation](http://promisekit.org/docs/)
    public func response(_: PMKNamespacer, queue: DispatchQueue? = nil) -> Promise<(URLRequest, HTTPURLResponse, Data)> {
        return Promise<(URLRequest, HTTPURLResponse, Data)>(cancellableTask: self) { seal in
            response(queue: queue) { rsp in
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
    /// - Note: cancelling this promise will cancel the underlying task
    /// - SeeAlso: [Cancellation](http://promisekit.org/docs/)
    public func responseData(queue: DispatchQueue? = nil) -> Promise<(data: Data, response: PMKAlamofireDataResponse)> {
        return Promise<(data: Data, response: PMKAlamofireDataResponse)>(cancellableTask: self) { seal in
            responseData(queue: queue) { response in
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
    /// - Note: cancelling this promise will cancel the underlying task
    /// - SeeAlso: [Cancellation](http://promisekit.org/docs/)
    public func responseString(queue: DispatchQueue? = nil) -> Promise<(string: String, response: PMKAlamofireDataResponse)> {
        return Promise<(string: String, response: PMKAlamofireDataResponse)>(cancellableTask: self) { seal in
            responseString(queue: queue) { response in
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
    /// - Note: cancelling this promise will cancel the underlying task
    /// - SeeAlso: [Cancellation](http://promisekit.org/docs/)
    public func responseJSON(queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        return Promise<(json: Any, response: PMKAlamofireDataResponse)>(cancellableTask: self) { seal in
            responseJSON(queue: queue, options: options) { response in
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
    /// - Note: cancelling this promise will cancel the underlying task
    /// - SeeAlso: [Cancellation](http://promisekit.org/docs/)
    public func responsePropertyList(queue: DispatchQueue? = nil, options: PropertyListSerialization.ReadOptions = PropertyListSerialization.ReadOptions()) -> Promise<(plist: Any, response: PMKAlamofireDataResponse)> {
        return Promise<(plist: Any, response: PMKAlamofireDataResponse)>(cancellableTask: self) { seal in
            responsePropertyList(queue: queue, options: options) { response in
                switch response.result {
                case .success(let value):
                    seal.fulfill((value, PMKAlamofireDataResponse(response)))
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

#if swift(>=3.2)
    /**
     Returns a Promise for a Decodable
     Adds a handler to be called once the request has finished.
     
     - Parameter queue: DispatchQueue, by default nil
     - Parameter decoder: JSONDecoder, by default JSONDecoder()
     - Note: cancelling this promise will cancel the underlying task
     - SeeAlso: [Cancellation](http://promisekit.org/docs/)
     */
    public func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
        return Promise<T>(cancellableTask: self) { seal in
            responseData(queue: queue) { response in
                switch response.result {
                case .success(let value):
                    do {
                        seal.fulfill(try decoder.decode(T.self, from: value))
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
 
     /**
     Returns a Promise for a Decodable
     Adds a handler to be called once the request has finished.
     
     - Parameter queue: DispatchQueue, by default nil
     - Parameter decoder: JSONDecoder, by default JSONDecoder()
     - Note: cancelling this promise will cancel the underlying task
     - SeeAlso: [Cancellation](http://promisekit.org/docs/)
    */
    public func responseDecodable<T: Decodable>(_ type: T.Type, queue: DispatchQueue? = nil, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
        return Promise<T>(cancellableTask: self) { seal in
            responseData(queue: queue) { response in
                switch response.result {
                case .success(let value):
                    do {
                        seal.fulfill(try decoder.decode(type, from: value))
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
#endif
}

extension Alamofire.DownloadRequest {
    /// - Note: cancelling this promise will cancel the underlying task
    /// - SeeAlso: [Cancellation](http://promisekit.org/docs/)
    public func response(_: PMKNamespacer, queue: DispatchQueue? = nil) -> Promise<DefaultDownloadResponse> {
        return Promise<DefaultDownloadResponse>(cancellableTask: self) { seal in
            response(queue: queue) { response in
                if let error = response.error {
                    seal.reject(error)
                } else {
                    seal.fulfill(response)
                }
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    /// - Note: cancelling this promise will cancel the underlying task
    /// - SeeAlso: [Cancellation](http://promisekit.org/docs/)
    public func responseData(queue: DispatchQueue? = nil) -> Promise<DownloadResponse<Data>> {
        return Promise<DownloadResponse<Data>>(cancellableTask: self) { seal in
            responseData(queue: queue) { response in
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


/// Alamofire.DataResponse, but without the `result`, since the Promise represents the `Result`
public struct PMKAlamofireDataResponse {
    public init<T>(_ rawrsp: Alamofire.DataResponse<T>) {
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
