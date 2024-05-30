//
//  LaudspeakerManager.swift
//  testLibrary
//
//  Created by Abheek Basu on 2/4/24.
//

import Foundation
import LaudspeakerCore

class LaudspeakerManager: ObservableObject {
    let laudspeaker: LaudspeakerCore
    
    init(sentryURL: String? = nil) {
        PackageInitializer.setup(withDSN: sentryURL)

        laudspeaker = LaudspeakerCore(url: "https://app.laudspeaker.com/api/", apiKey: "oT5cNNyPPffC0kea9l7SYwXtT0TlgLXSx9TZEDsc")
        
    }
    
}
