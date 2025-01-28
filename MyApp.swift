import SwiftUI

@main
struct MyApp: App {
    // Vincula el AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            StrategiesView()
        }
    }
}

// Clase AppDelegate para configurar orientaciones
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait // Cambia aquí la orientación deseada (e.g., .landscape, .all)
    }
}
