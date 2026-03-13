import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    private let voiceChangerManager = VoiceChangerManager.shared
    private let soundEffectManager = SoundEffectManager.shared
    
    private let voiceChangerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🎤 实时变声", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let soundEffectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🔊 音效板", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let floatingPanelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⚡ 悬浮工具箱", for: .normal)
        button.backgroundColor = UIColor.systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "秋葵游戏助手"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "V1.0 - 游戏语音伴侣"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(voiceChangerButton)
        view.addSubview(soundEffectButton)
        view.addSubview(floatingPanelButton)
        
        voiceChangerButton.addTarget(self, action: #selector(voiceChangerTapped), for: .touchUpInside)
        soundEffectButton.addTarget(self, action: #selector(soundEffectTapped), for: .touchUpInside)
        floatingPanelButton.addTarget(self, action: #selector(floatingPanelTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        voiceChangerButton.translatesAutoresizingMaskIntoConstraints = false
        soundEffectButton.translatesAutoresizingMaskIntoConstraints = false
        floatingPanelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            voiceChangerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            voiceChangerButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 60),
            voiceChangerButton.widthAnchor.constraint(equalToConstant: 240),
            voiceChangerButton.heightAnchor.constraint(equalToConstant: 60),
            
            soundEffectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soundEffectButton.topAnchor.constraint(equalTo: voiceChangerButton.bottomAnchor, constant: 20),
            soundEffectButton.widthAnchor.constraint(equalToConstant: 240),
            soundEffectButton.heightAnchor.constraint(equalToConstant: 60),
            
            floatingPanelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            floatingPanelButton.topAnchor.constraint(equalTo: soundEffectButton.bottomAnchor, constant: 20),
            floatingPanelButton.widthAnchor.constraint(equalToConstant: 240),
            floatingPanelButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func voiceChangerTapped() {
        let voiceVC = VoiceChangerViewController()
        navigationController?.pushViewController(voiceVC, animated: true)
    }
    
    @objc private func soundEffectTapped() {
        let soundVC = SoundEffectViewController()
        navigationController?.pushViewController(soundVC, animated: true)
    }
    
    @objc private func floatingPanelTapped() {
        FloatingPanelManager.shared.showFloatingPanel()
        
        let alert = UIAlertController(title: "悬浮工具箱", message: "悬浮面板已开启！\n\n功能包括：\n• 一键调整亮度\n• 触感反馈开关\n• 勿扰模式\n• 网络状态检测\n• 录屏/截图快捷键", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "知道了", style: .default))
        present(alert, animated: true)
    }
}
