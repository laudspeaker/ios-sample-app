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
        //NB if you are using flush we need isPushAutomated:
        
        //laudspeaker = LaudspeakerCore(url: "https://test-laudspeaker.laudtest.com/api/", apiKey: "wBdh7MM1Jk4uF1IwKM0w14wG5o04Wos0WmWADvEN", isPushAutomated: true)
        //laudspeaker = LaudspeakerCore(url: "https://test-laudspeaker.laudtest.com/api/", apiKey: "oT5cNNyPPffC0kea9l7SYwXtT0TlgLXSx9TZEDsc" , sentryDSN: "https://15c7f142467b67973258e7cfaf814500@o4506038702964736.ingest.sentry.io/4506040630640640")
        //laudspeaker = LaudspeakerCore(url: "https://finda-laudspeaker.finda.co.kr/api/", apiKey: "gL3V4q4bzGW98u6j48bxt2DcAra7lJMA2dqvIbqJ" , sentryDSN: "https://15c7f142467b67973258e7cfaf814500@o4506038702964736.ingest.sentry.io/4506040630640640")
        
        laudspeaker = LaudspeakerCore(url: "https://3d2bc2089b9a.ngrok.app", apiKey: "FkyTRWAcnb6wENW5Qcc9bm7ro0KU57oCcTOt2oCq", sentryDSN: "https://15c7f142467b67973258e7cfaf814500@o4506038702964736.ingest.sentry.io/4506040630640640")
        
        //laudspeaker = LaudspeakerCore(url: "https://app.laudspeaker.com", apiKey: "DRvD5WjH0TV0Z5nJMPgXGi6krFyiMHNbA7D4MyPF", sentryDSN: "https://15c7f142467b67973258e7cfaf814500@o4506038702964736.ingest.sentry.io/4506040630640640")
        
        //laudspeaker = LaudspeakerCore(url: "https://d25c7ba3a7a1.ngrok.app/", apiKey: "j5fq3WKUG6OdoQg3b5CynusGh6mWEzR1YFO0Mrin", isPushAutomated: true)
        
        
        //laudspeaker = LaudspeakerCore(url: "https://staging-app.laudspeaker.com/api/", apiKey: "4A7nrIMYrwGT7rrY3E0ALG1UfIEfoYqlWhYp42Dp", isPushAutomated: true)
        
    }
    
    // Add any additional methods you need to interact with LaudspeakerCore,
    // or to facilitate functionality in your SwiftUI app.
}
