import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var floatingPanelManager: FloatingPanelManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 设置窗口
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 创建主视图控制器
        let mainViewController = MainViewController()
        
        // 使用导航控制器
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.navigationBar.isHidden = true
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        // 初始化悬浮面板管理器
        floatingPanelManager = FloatingPanelManager.shared
        
        // 请求权限
        requestPermissions()
        
        return true
    }
    
    private func requestPermissions() {
        // 请求麦克风权限
        if #available(iOS 14.0, *) {
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                print("麦克风权限: \(granted)")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

import AVFoundation
