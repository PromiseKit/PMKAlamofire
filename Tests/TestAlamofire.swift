import PMKAlamofire
import OHHTTPStubs
import PromiseKit
import XCTest

class AlamofireTests: XCTestCase {
    func test() {
        let json: NSDictionary = ["key1": "value1", "key2": ["value2A", "value2B"]]

        OHHTTPStubs.stubRequests(passingTest: { $0.url!.host == "example.com" }) { _ in
            return OHHTTPStubsResponse(jsonObject: json, statusCode: 200, headers: nil)
        }

        let ex = expectation(description: "")

        let rq = Alamofire.request("http://example.com", method: .get).responseJSON().done { rsp in
            XCTAssertEqual(json, rsp.json as? NSDictionary)
            ex.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
    }
    #if swift(>=3.2)
    struct KeyValuesService: Decodable {
        let key1: String
        let key2: [String]
    }
    
    func getFeed() -> Promise<KeyValuesService> {
        return Alamofire.request("http://example.com", method: .get).responseDecodable(queue: nil)
    }
    
    func testDecodable() {
        
        let json: NSDictionary = ["key1": "value1", "key2": ["value2A", "value2B"]]
        
        OHHTTPStubs.stubRequests(passingTest: { $0.url!.host == "example.com" }) { _ in
            return OHHTTPStubsResponse(jsonObject: json, statusCode: 200, headers: nil)
        }
        
        let ex = expectation(description: "")
        
        getFeed().done { keyValueService in
            XCTAssert(keyValueService.key1=="value1", "Value1 found")
            ex.fulfill()
        }
        waitForExpectations(timeout: 1)
        
    }
    #endif
}
