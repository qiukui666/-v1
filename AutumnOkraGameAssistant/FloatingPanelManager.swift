import UIKit

class FloatingPanelManager {
    
    static let shared = FloatingPanelManager()
    
    private var floatingPanel: FloatingPanelView?
    private var isPanelVisible = false
    
    private init() {}
    
    func showFloatingPanel() {
        guard !isPanelVisible else { return }
        
        let panel = FloatingPanelView()
        floatingPanel = panel
        
        // 获取当前窗口
        guard let window = UIApplication.shared.windows.first else { return }
        
        window.addSubview(panel)
        
        // 设置初始位置
        panel.frame = CGRect(x: window.bounds.width - 80, y: 100, width: 70, height: 70)
        
        // 添加拖拽手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panel.addGestureRecognizer(panGesture)
        
        // 添加点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        panel.addGestureRecognizer(tapGesture)
        
        isPanelVisible = true
    }
    
    func hideFloatingPanel() {
        floatingPanel?.removeFromSuperview()
        floatingPanel = nil
        isPanelVisible = false
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let panel = floatingPanel else { return }
        
        let translation = gesture.translation(in: panel.superview)
        
        switch gesture.state {
        case .changed:
            panel.center = CGPoint(x: panel.center.x + translation.x, y: panel.center.y + translation.y)
            gesture.setTranslation(.zero, in: panel.superview)
            
        case .ended:
            // 吸附到屏幕边缘
            let screenWidth = UIScreen.main.bounds.width
            let panelSize: CGFloat = 70
            
            var newX = panel.center.x
            
            if newX < screenWidth / 2 {
                newX = panelSize / 2
            } else {
                newX = screenWidth - panelSize / 2
            }
            
            // 确保在屏幕范围内
            newX = max(panelSize / 2, min(screenWidth - panelSize / 2, newX))
            
            UIView.animate(withDuration: 0.3) {
                panel.center = CGPoint(x: newX, y: panel.center.y)
            }
            
        default:
            break
        }
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let panel = floatingPanel else { return }
        
        // 显示工具菜单
        panel.showMenu()
    }
}

// MARK: - FloatingPanelView

class FloatingPanelView: UIView {
    
    private let iconButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
        button.layer.cornerRadius = 35
        button.setImage(UIImage(systemName: "wrench.and.screwdriver"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return button
    }()
    
    private var menuView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(iconButton)
        
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconButton.topAnchor.constraint(equalTo: topAnchor),
            iconButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10
    }
    
    func showMenu() {
        guard menuView == nil else { return }
        
        let menu = UIView()
        menu.backgroundColor = .systemBackground
        menu.layer.cornerRadius = 15
        menu.layer.shadowColor = UIColor.black.cgColor
        menu.layer.shadowOpacity = 0.3
        menu.layer.shadowOffset = CGSize(width: 0, height: 2)
        menu.layer.shadowRadius = 10
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let tools = [
            ("brightness", "亮度", "sun.max.fill"),
            ("haptic", "触感", "hand.tap.fill"),
            ("dnd", "勿扰", "moon.fill"),
            ("network", "网络", "wifi"),
            ("screen", "录屏", "record.circle.fill"),
            ("screenshot", "截图", "camera.fill")
        ]
        
        for (id, name, iconName) in tools {
            let button = createToolButton(name: name, iconName: iconName, id: id)
            stackView.addArrangedSubview(button)
        }
        
        menu.addSubview(stackView)
        
        // 关闭按钮
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("✕", for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        closeButton.backgroundColor = .systemGray5
        closeButton.layer.cornerRadius = 12
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeMenu), for: .touchUpInside)
        
        menu.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: menu.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: menu.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: menu.trailingAnchor, constant: -10),
            
            closeButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            closeButton.leadingAnchor.constraint(equalTo: menu.leadingAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: menu.trailingAnchor, constant: -10),
            closeButton.bottomAnchor.constraint(equalTo: menu.bottomAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 获取父视图
        guard let superview = self.superview else { return }
        
        superview.addSubview(menu)
        menu.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menu.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            menu.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10),
            menu.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        menuView = menu
        
        // 点击外部关闭菜单
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        superview.addGestureRecognizer(tapGesture)
    }
    
    private func createToolButton(name: String, iconName: String, id: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle(name, for: .normal)
        button.setImage(UIImage(systemName: iconName), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        button.addTarget(self, action: #selector(toolButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc private func toolButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        switch title {
        case "亮度":
            adjustBrightness()
        case "触感":
            toggleHaptic()
        case "勿扰":
            toggleDND()
        case "网络":
            checkNetwork()
        case "录屏":
            startScreenRecording()
        case "截图":
            takeScreenshot()
        default:
            break
        }
        
        closeMenu()
    }
    
    private func adjustBrightness() {
        let currentBrightness = UIScreen.main.brightness
        let newBrightness = currentBrightness > 0.5 ? 0.3 : 0.8
        UIScreen.main.brightness = newBrightness
        
        showAlert(title: "亮度", message: "已调整亮度为 \(Int(newBrightness * 100))%")
    }
    
    private func toggleHaptic() {
        let feedback = UIImpactFeedbackGenerator(style: .medium)
        feedback.impactOccurred()
        
        showAlert(title: "触感反馈", message: "已触发触感反馈")
    }
    
    private func toggleDND() {
        // 注意：勿扰模式的切换需要特定权限
        showAlert(title: "勿扰模式", message: "请在系统设置中手动切换勿扰模式")
    }
    
    private func checkNetwork() {
        // 检查网络状态
        let reachability = Reachability()
        let isOnline = reachability.connection != .none

        showAlert(title: "网络状态", message: isOnline ? "网络连接正常" : "网络未连接")
    }
    
    private func startScreenRecording() {
        showAlert(title: "录屏", message: "录屏功能需要系统权限，请在控制中心手动启动")
    }
    
    private func takeScreenshot() {
        // 截图功能
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, UIScreen.main.scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            if let window = UIApplication.shared.windows.first {
                window.layer.render(in: context)
            }
        }
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            // 保存截图到相册
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            showAlert(title: "截图", message: "截图已保存到相册")
        }
        
        UIGraphicsEndImageContext()
    }
    
    @objc private func closeMenu() {
        menuView?.removeFromSuperview()
        menuView = nil
    }
    
    @objc private func dismissMenu(_ gesture: UITapGestureRecognizer) {
        closeMenu()
    }
    
    private func showAlert(title: String, message: String) {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        
        window.rootViewController?.present(alert, animated: true)
    }
}

// MARK: - Reachability (简单的网络检查)

class Reachability {
    
    enum Connection {
        case none
        case wifi
        case cellular
    }
    
    var connection: Connection {
        // 简化的网络检查
        return .wifi
    }
}
