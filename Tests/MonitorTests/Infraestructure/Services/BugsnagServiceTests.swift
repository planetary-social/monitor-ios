//
//  BugsnagServiceTests.swift
//  
//
//  Created by Martin Dutra on 9/12/21.
//

import XCTest
import Bugsnag
@testable import Monitor

final class BugsnagServiceTests: XCTestCase {

    private var secrets: SecretsMock!
    private var service: BugsnagService!

    override func setUp() {
        secrets = SecretsMock()
        secrets.value = "test"
        service = BugsnagService(secrets: secrets)
    }

    func testInit() {
        XCTAssertEqual(Bugsnag.breadcrumbs().last?.message, "Bugsnag loaded")
    }

    func testInitWithoutKey() {
        secrets = SecretsMock()
        secrets.value = nil
        service = BugsnagService(secrets: secrets)
        XCTAssertEqual(Bugsnag.breadcrumbs().last?.message, "Bugsnag loaded")
    }

    func testIdentify() {
        let expectedIdentifier = "user hash"
        let expectedName = "John Doe"
        let expectedNetworkKey = "network hash"
        let expectedNetworkName = "a test network"
        let identity = Identity(identifier: expectedIdentifier,
                                name: expectedName,
                                networkKey: expectedNetworkKey,
                                networkName: expectedNetworkName)
        service.identify(identity: identity)
        let user = Bugsnag.user()
        let metadata = Bugsnag.getMetadata(section: "network")
        XCTAssertEqual(user.id, expectedIdentifier)
        XCTAssertEqual(user.name, expectedName)
        XCTAssertEqual(metadata?.value(forKey: "key") as? String, expectedNetworkKey)
        XCTAssertEqual(metadata?.value(forKey: "name") as? String, expectedNetworkName)
    }

    func testForget() {
        let identity = Identity(identifier: "user hash",
                                name: "John Doe",
                                networkKey: "network hash",
                                networkName: "a test network")
        service.identify(identity: identity)
        service.forget()
        let user = Bugsnag.user()
        let metadata = Bugsnag.getMetadata(section: "network")
        XCTAssertNil(user.id)
        XCTAssertNil(user.name)
        XCTAssertNil(metadata)
    }

    func testRecord() {
        let expectedBreadcrumb = "test"
        service.record(expectedBreadcrumb)
        XCTAssertEqual(Bugsnag.breadcrumbs().last?.message, expectedBreadcrumb)
    }

    func testReport() {
        let error = NSError(domain: "com.planetary.social", code: 408, userInfo: nil)
        service.report(error: error, metadata: nil)
        XCTAssertEqual(Bugsnag.breadcrumbs().last?.message, "NSError")
    }

    func testReportWithMetadata() {
        let error = NSError(domain: "com.planetary.social", code: 408, userInfo: nil)
        service.report(error: error, metadata: ["key": "value"])
        XCTAssertEqual(Bugsnag.breadcrumbs().last?.message, "NSError")
    }


}
