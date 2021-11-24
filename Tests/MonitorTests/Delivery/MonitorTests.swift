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

    func testCrash() {
        monitor.crash()
        XCTAssertTrue(service.crashed)
    }

}
