import SwiftUI
import FirebaseCore
import FirebaseMessaging


class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    //static var laudspeakerManager : LaudspeakerManager? = nil
    var laudspeakerManager = LaudspeakerManager()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM token: \(error)")
          } else if let token = token {
            print("FCM token: \(token)")
          }
        }
        
        // Request notification permission and register for remote notifications
        let center = UNUserNotificationCenter.current()
        center.delegate = self // Set the UNUserNotificationCenter delegate
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        print("1 didFinishLaunchingWithOptions")
        
        return true
    }
    
    //set up apns the first time
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS Token: \(deviceToken.map { String(format: "%02.2hhx", $0) }.joined())")
        Messaging.messaging().apnsToken = deviceToken
        print("2 didRegisterForRemoteNotificationsWithDeviceToken")
        
    }
    
    // Implement the delegate method to handle the FCM token refresh
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Registration Token: \(String(describing: fcmToken))")
        self.laudspeakerManager.laudspeaker.setFcmToken(token: fcmToken!)
        //self.laudspeakerManager.laudspeaker.sendFCMToken(fcmToken: fcmToken)

        print("about to connect")
        print("3 didReceiveRegistrationToken")

    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("here in  will present");
        let userInfo = notification.request.content.userInfo
        self.laudspeakerManager.laudspeaker.logMessageEvent(event: "$delivered", userInfo: userInfo)
        completionHandler([.alert, .sound, .badge]) // Adjust based on how you want the notification to be presented
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("here in  didReceive");
        let userInfo = response.notification.request.content.userInfo

        self.laudspeakerManager.laudspeaker.logMessageEvent(event: "$opened", userInfo: userInfo)
        
        completionHandler()
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        print("this is the userInfo");
        print(userInfo)
        
        let userInfoStringKeyed = userInfo.reduce(into: [String: Any]()) { (result, item) in
                result[item.key as? String ?? ""] = item.value
            }
        
        // Check for quiet hours before processing further
        if !self.laudspeakerManager.laudspeaker.handleData(data: userInfoStringKeyed) {

            completionHandler(.newData)
        } else {
            // Quiet hours are active, you might not want to process the notification
            completionHandler(.noData)
        }
    }
    
}

@main
struct testLibraryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(delegate.laudspeakerManager)
        }
    }
}


