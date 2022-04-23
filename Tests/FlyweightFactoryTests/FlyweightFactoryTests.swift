import XCTest
@testable import FlyweightFactory

class Factory: FlyweightFactory {
    static var instances: [String: String] = [:]
}

final class FlyweightFactoryTests: XCTestCase {

    let indetifier = "id"
    let value = "value"

    lazy
    var instance: String? = Factory.instance(for: indetifier, initializer: {
        value
    })

    func testLaunchDestroy() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        XCTAssertEqual(instance, value)
        instance = nil
        XCTAssertEqual(instance, nil)
    }

    func testSetUp() {
        let instance = Factory.instance(for: "id", initializer: {
            value
        })
        XCTAssertEqual(instance, value)
    }

    func testTearDown() async throws {
        Factory.destroy(with: indetifier)

        let instance = Factory.instance(for: indetifier)

        XCTAssertEqual(instance, nil)
    }
}
