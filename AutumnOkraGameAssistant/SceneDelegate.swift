import UIKit
import AVFoundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // 创建主视图控制器
        let mainViewController = MainViewController()
        mainViewController.title = "秋葵游戏助手"

        // 使用导航控制器
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        // 设置导航栏外观
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.prefersLargeTitles = false

        // 设置窗口
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        // 请求权限
        requestPermissions()
        
        print("Scene loaded successfully")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

    private func requestPermissions() {
        // 请求麦克风权限
        if #available(iOS 14.0, *) {
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                print("麦克风权限: \(granted)")
            }
        }
    }
}
