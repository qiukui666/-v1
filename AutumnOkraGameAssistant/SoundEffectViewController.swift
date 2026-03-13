import UIKit
import AVFoundation

class SoundEffectViewController: UIViewController {
    
    private let soundEffectManager = SoundEffectManager.shared
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "音效板"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "点击播放音效"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    struct SoundEffect {
        let name: String
        let emoji: String
        let color: UIColor
        let type: SoundType
    }
    
    enum SoundType {
        case clap
        case laugh
        case wow
        case applause
        case sad
        case angry
        case cheer
        case surprise
    }
    
    private let soundEffects: [SoundEffect] = [
        SoundEffect(name: "鼓掌", emoji: "👏", color: .systemBlue, type: .clap),
        SoundEffect(name: "笑声", emoji: "😂", color: .systemYellow, type: .laugh),
        SoundEffect(name: "哇哦", emoji: "😲", color: .systemOrange, type: .wow),
        SoundEffect(name: "欢呼", emoji: "🎉", color: .systemGreen, type: .applause),
        SoundEffect(name: "悲伤", emoji: "😢", color: .systemIndigo, type: .sad),
        SoundEffect(name: "生气", emoji: "😡", color: .systemRed, type: .angry),
        SoundEffect(name: "加油", emoji: "💪", color: .systemPurple, type: .cheer),
        SoundEffect(name: "惊讶", emoji: "😱", color: .systemPink, type: .surprise)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createSoundButtons()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "音效板"
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func createSoundButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 分成两列
        let rowStack1 = createRowStackView(effects: Array(soundEffects.prefix(4)))
        let rowStack2 = createRowStackView(effects: Array(soundEffects.suffix(4)))
        
        stackView.addArrangedSubview(rowStack1)
        stackView.addArrangedSubview(rowStack2)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func createRowStackView(effects: [SoundEffect]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        for effect in effects {
            let button = createSoundButton(effect: effect)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
    
    private func createSoundButton(effect: SoundEffect) -> UIButton {
        let button = UIButton(type: .system)
        
        let container = UIView()
        container.backgroundColor = effect.color
        container.layer.cornerRadius = 15
        container.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(container)
        
        let emojiLabel = UILabel()
        emojiLabel.text = effect.emoji
        emojiLabel.font = .systemFont(ofSize: 40)
        emojiLabel.textAlignment = .center
        container.addSubview(emojiLabel)
        
        let nameLabel = UILabel()
        nameLabel.text = effect.name
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        container.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: button.topAnchor),
            container.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            
            emojiLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
            emojiLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.tag = soundEffects.firstIndex(where: { $0.type == effect.type }) ?? 0
        button.addTarget(self, action: #selector(soundButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc private func soundButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let effect = soundEffects[index]
        
        // 播放音效
        soundEffectManager.playSoundEffect(type: effect.type)
        
        // 触摸反馈
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
        
        // 视觉反馈
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
    }
}

// MARK: - SoundEffectManager

class SoundEffectManager {
    static let shared = SoundEffectManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playSoundEffect(type: SoundEffectViewController.SoundType) {
        // 使用系统音效生成器播放音效
        let systemSoundID: SystemSoundID
        
        switch type {
        case .clap:
            systemSoundID = 1104
        case .laugh:
            systemSoundID = 1103
        case .wow:
            systemSoundID = 1105
        case .applause:
            systemSoundID = 1106
        case .sad:
            systemSoundID = 1107
        case .angry:
            systemSoundID = 1108
        case .cheer:
            systemSoundID = 1109
        case .surprise:
            systemSoundID = 1110
        }
        
        // 尝试使用系统音效
        AudioServicesPlaySystemSound(systemSoundID)
        
        // 也可以尝试播放自定义音效
        // 如果需要更丰富的音效，可以在 Resources 文件夹中添加音频文件
    }
}
