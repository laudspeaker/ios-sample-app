import SwiftUI
import LaudspeakerCore


struct ContentView: View {
    @EnvironmentObject private var laudspeakerManager: LaudspeakerManager
    @State private var isToggled = false

    
    var body: some View {
        VStack {
            
            // The toggle view
            Toggle("Toggle State", isOn: $isToggled)
                .padding()
            
            
            Button("Identify H") {
                laudspeakerManager.laudspeaker.identify(distinctId: "4289893")
            }
            .padding()
            
            
            Button("Identify  with props") {
                laudspeakerManager.laudspeaker.identify(distinctId:"88888", userProperties: ["num":8])
            }
            .padding()

            
            Button("SetH") {
                laudspeakerManager.laudspeaker.set(properties: ["num":8])
            }
            .padding()
            
            Button("SetH mkt t") {
                laudspeakerManager.laudspeaker.set(properties: ["mkt_agree":true])
            }
            .padding()
            
            Button("SetH mkt f") {
                laudspeakerManager.laudspeaker.set(properties: ["mkt_agree":false])
            }
            .padding()
            
            Button("test sentry") {
                laudspeakerManager.laudspeaker.testSentryIntegration()
            }
            .padding()
             

            Button("Identify") {
                laudspeakerManager.laudspeaker.identify(distinctId: "12499")
            }
            .padding()

            
            // Constructing a complex payload with nested dictionaries and arrays
            let loanlist: [String: Any] = [
                "product_id": [94835, 43523]
            ]

            
            Button("fire event H") {
                laudspeakerManager.laudspeaker.fire(event: "LA_loanlist_view", payload: loanlist)
            }
            .padding()
            
            
            // Constructing a complex payload with nested dictionaries and arrays
            let complexPayload: [String: Any] = [
                "order": [
                    "id": "order123",
                    "date": "2024-02-14",
                    "items": [
                        ["product": "Product 1", "quantity": 2, "price": 29.99],
                        ["product": "Product 2", "quantity": 1, "price": 9.99]
                    ]
                ],
                "comments": "This is a sample order.",
                "tags": ["urgent", "gift"]
            ]

            
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
