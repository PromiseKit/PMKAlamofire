import Alamofire
import PMKAlamofire
import OHHTTPStubs
import PromiseKit
import XCTest

class AlamofireTests: XCTestCase {
    func test() {
        let json: NSDictionary = ["key1": "value1", "key2": ["value2A", "value2B"]]

        HTTPStubs.stubRequests(passingTest: { $0.url!.host == "example.com" }) { _ in
            return HTTPStubsResponse(jsonObject: json, statusCode: 200, headers: nil)
        }

        let ex = expectation(description: "")

        AF.request("http://example.com", method: .get).responseJSON().done { rsp in
            XCTAssertEqual(json, rsp.json as? NSDictionary)
            ex.fulfill()
        }.catch { _ in
            XCTAssert(false)
        }
        waitForExpectations(timeout: 1)
    }

    override func tearDown() {
        HTTPStubs.removeAllStubs()
    }

#if swift(>=3.2)
    private struct Fixture: Decodable {
        let key1: String
        let key2: [String]
    }
    
    func testDecodable1() {
        
        func getFixture() -> Promise<Fixture> {
            return AF.request("http://example.com", method: .get).responseDecodable()
        }
        
        let json: NSDictionary = ["key1": "value1", "key2": ["value2A", "value2B"]]
        
        HTTPStubs.stubRequests(passingTest: { $0.url!.host == "example.com" }) { _ in
            return HTTPStubsResponse(jsonObject: json, statusCode: 200, headers: nil)
        }
        
        let ex = expectation(description: "")
        
        getFixture().done { fixture in
            XCTAssert(fixture.key1 == "value1", "Value1 found")
            ex.fulfill()
        }.catch { _ in
            XCTAssert(false)
        }
        waitForExpectations(timeout: 1)
        
    }
    
    func testDecodable2() {
        let json: NSDictionary = ["key1": "value1", "key2": ["value2A", "value2B"]]
        
        HTTPStubs.stubRequests(passingTest: { $0.url!.host == "example.com" }) { _ in
            return HTTPStubsResponse(jsonObject: json, statusCode: 200, headers: nil)
        }
        
        let ex = expectation(description: "")
        
        firstly {
            AF.request("http://example.com", method: .get).responseDecodable(Fixture.self)
        }.done { fixture in
            XCTAssert(fixture.key1 == "value1", "Value1 found")
            ex.fulfill()
        }.catch { _ in
            XCTAssert(false)
        }
        waitForExpectations(timeout: 1)
        
    }
#endif
}
