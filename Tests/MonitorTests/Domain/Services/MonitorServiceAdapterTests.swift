//
//  MonitorServiceAdapterTests.swift
//  
//
//  Created by Martin Dutra on 9/12/21.
//

import XCTest
@testable import Monitor

final class MonitorServiceAdapterTests: XCTestCase {

    private var apiService: APIServiceMock!
    private var service: MonitorServiceAdapter!

    override func setUp() {
        apiService = APIServiceMock()
        service = MonitorServiceAdapter(apiService: apiService)
    }

    func testIdentify() {
        service.identify(identity: Identity(identifier: "user hash",
                                            name: "user name",
                                            networkKey: "network key",
                                            networkName: "network name"))
        XCTAssertTrue(apiService.identified)
    }

    func testForget() {
        service.forget()
        XCTAssertTrue(apiService.forgot)
    }

    func testRecord() {
        service.record("message")
        XCTAssertTrue(apiService.recorded)
    }

    func testReport() {
        let error = NSError(domain: "com.planetary.social", code: 408, userInfo: nil)
        service.report(error: error, metadata: nil)
        XCTAssertTrue(apiService.crashed)
    }

}
