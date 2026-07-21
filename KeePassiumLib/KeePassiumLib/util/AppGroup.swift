//  KeePassium Password Manager
//  Copyright © 2018-2025 KeePassium Labs <info@keepassium.com>
// 
//  This program is free software: you can redistribute it and/or modify it
//  under the terms of the GNU General Public License version 3 as published
//  by the Free Software Foundation: https://www.gnu.org/licenses/).
//  For commercial licensing, please contact the author.

import Foundation

public class AppGroup {
    public static var id: String = {
        if BusinessModel.isIntuneEdition {
            return "group.com.keepassium.intune"
        } else {
            return "group.com.keepassium"
        }
    }()

    public static let appURLScheme: String = {
        if BusinessModel.isIntuneEdition {
            return "keepassium.org"
        }
        switch BusinessModel.type {
        case .freemium:
            return "keepassium"
        case .prepaid:
            return "keepassium.pro"
        }
    }()

    public static let launchMainAppURL = URL(string: appURLScheme + "://")!

    public static let upgradeToPremiumURL = URL(string: appURLScheme + "://upgradeToPremium")!

    public static let donateURL = URL(string: appURLScheme + "://donate")! 

    public static var isMainApp: Bool {
        return applicationShared != nil
    }

    public static var isAppExtension: Bool {
        return !isMainApp
    }

    public static weak var applicationShared: UIApplication?

    public static var sharedContainerURL: URL? {
        FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: id
        )
    }

    public static var storageContainerURL: URL {
        if let sharedContainerURL {
            return sharedContainerURL
        }

#if FEATHER_COMPAT
        let applicationSupportURL = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first!
        return applicationSupportURL.appendingPathComponent(
            "KeePassium",
            isDirectory: true
        )
#else
        fatalError("Failed to access the application group container.")
#endif
    }
}
