//
//  MonitorServiceMock.swift
//  
//
//  Created by Martin Dutra on 24/11/21.
//

import Foundation
@testable import Monitor

class MonitorServiceMock: MonitorService {

    var crashed: Bool = false

    func identify(identity: Identity) {

    }

    func forget() {

    }

    func record(_ message: String) {

    }

    func report(error: Error) {
        crashed = true
    }

    func report(error: Error, metadata: [AnyHashable: Any]) {
        crashed = true
    }

}
