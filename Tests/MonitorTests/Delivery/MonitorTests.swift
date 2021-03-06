//
//  MonitorTests.swift
//
//
//  Created by Martin Dutra on 24/11/21.
//

import XCTest
@testable import Monitor

final class MonitorTests: XCTestCase {

    private var service: MonitorServiceMock!
    private var monitor: Monitor!

    override func setUp() {
        service = MonitorServiceMock()
        monitor = Monitor(service: service)
    }

    func testIdentify() {
        monitor.identify(identifier: "user hash",
                         name: "user name",
                         networkKey: "network key",
                         networkName: "network name")
        XCTAssertTrue(service.identified)
    }

    func testForget() {
        monitor.forget()
        XCTAssertTrue(service.forgot)
    }

    func testRecord() {
        monitor.record("message")
        XCTAssertTrue(service.recorded)
    }

    func testCrash() {
        monitor.crash()
        XCTAssertTrue(service.crashed)
    }

    func testReport() {
        let error = NSError(domain: "com.planetary.social", code: 408, userInfo: nil)
        monitor.reportIfNeeded(error: error)
        XCTAssertTrue(service.crashed)
    }


}
