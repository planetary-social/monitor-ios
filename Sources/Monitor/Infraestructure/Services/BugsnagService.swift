//
//  BugsnagService.swift
//  
//
//  Created by Martin Dutra on 24/11/21.
//

import Foundation
import Bugsnag
import Secrets
import Logger

class BugsnagService: APIService {

    init(secrets: Secrets = Secrets.shared) {
        guard let apiKey = secrets.get(key: .bugsnag) else {
            Logger.shared.info("Error while configuring Bugsnag. ApiKey does not exist.")
            return
        }
        Logger.shared.info("Configuring Bugsnag...")
        Bugsnag.start(withApiKey: apiKey)
    }

    func identify(identity: Identity) {
        Bugsnag.setUser(identity.identifier,
                        withEmail: nil,
                        andName: identity.name)
        Bugsnag.addMetadata(identity.networkKey, key: "key", section: "network")
        Bugsnag.addMetadata(identity.networkName, key: "name", section: "network")
    }

    func forget() {
        Bugsnag.setUser(nil, withEmail: nil, andName: nil)
        Bugsnag.clearMetadata(section: "network")
    }

    func record(_ message: String) {
        Bugsnag.leaveBreadcrumb(withMessage: message)
    }

    func report(error: Error, metadata: [AnyHashable : Any]?) {
        Bugsnag.notifyError(error) { event in
            if let metadata = metadata {
                event.addMetadata(metadata, section: "metadata")
            }
            if let log = Logger.shared.fileUrls.first, let data = try? Data(contentsOf: log), let string = String(data: data, encoding: .utf8) {
                event.addMetadata(string, key: "app", section: "logs")
            }
            // TODO: Send bot metadata
            return true
        }
    }

}
