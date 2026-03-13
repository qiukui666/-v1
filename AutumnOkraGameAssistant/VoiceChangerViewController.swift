import UIKit
import AVFoundation

class VoiceChangerViewController: UIViewController {
    
    private let voiceChangerManager = VoiceChangerManager.shared
    
    private var voiceButtons: [VoiceType: UIButton] = [:]
    private var selectedVoiceType: VoiceType = .none
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "实时变声器"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("按住说话", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 35
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "选择变声效果，然后按住说话"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    enum VoiceType: String, CaseIterable {
        case none = "原声"
        case loli = "萝莉"
        case uncle = "大叔"
        case robot = "机器人"
        case electronic = "电音"
        case chipmunk = "花栗鼠"
        case deep = "深沉"
        
        var emoji: String {
            switch self {
            case .none: return "🎤"
            case .loli: return "👧"
            case .uncle: return "👨"
            case .robot: return "🤖"
            case .electronic: return "⚡"
            case .chipmunk: return "🐿️"
            case .deep: return "🎭"
            }
        }
        
        var pitchMultiplier: Float {
            switch self {
            case .none: return 1.0
            case .loli: return 1.6
            case .uncle: return 0.7
            case .robot: return 1.0
            case .electronic: return 1.3
            case .chipmunk: return 1.8
            case .deep: return 0.6
            }
        }
        
        var playbackRate: Float {
            switch self {
            case .none: return 1.0
            case .loli: return 1.3
            case .uncle: return 0.8
            case .robot: return 1.0
            case .electronic: return 1.2
            case .chipmunk: return 1.5
            case .deep: return 0.7
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVoiceButtons()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "实时变声"
        
        view.addSubview(titleLabel)
        view.addSubview(statusLabel)
        view.addSubview(recordButton)
        
        recordButton.addTarget(self, action: #selector(recordButtonTouchDown), for: .touchDown)
        recordButton.addTarget(self, action: #selector(recordButtonTouchUp), for: [.touchUpInside, .touchUpOutside])
        
        setupConstraints()
    }
    
    private func setupVoiceButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for voiceType in VoiceType.allCases {
            let button = UIButton(type: .system)
            button.setTitle("\(voiceType.emoji) \(voiceType.rawValue)", for: .normal)
            button.backgroundColor = .systemGray5
            button.setTitleColor(.label, for: .normal)
            button.layer.cornerRadius = 8
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            button.tag = VoiceType.allCases.firstIndex(of: voiceType) ?? 0
            
            button.addTarget(self, action: #selector(voiceButtonTapped(_:)), for: .touchUpInside)
            
            voiceButtons[voiceType] = button
            stackView.addArrangedSubview(button)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            statusLabel.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -30),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            recordButton.widthAnchor.constraint(equalToConstant: 140),
            recordButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    @objc private func voiceButtonTapped(_ sender: UIButton) {
        // 重置所有按钮样式
        voiceButtons.values.forEach { button in
            button.backgroundColor = .systemGray5
        }
        
        // 设置选中样式
        sender.backgroundColor = .systemBlue
        sender.setTitleColor(.white, for: .normal)
        
        // 更新选中的声音类型
        if let index = VoiceType.allCases.firstIndex(where: { $0.rawValue.contains(sender.title(for: .normal) ?? "") }) {
            selectedVoiceType = VoiceType.allCases[index]
        }
        
        statusLabel.text = "已选择：\(selectedVoiceType.rawValue)"
    }
    
    @objc private func recordButtonTouchDown() {
        recordButton.backgroundColor = .systemBlue
        recordButton.setTitle("正在录音...", for: .normal)
        statusLabel.text = "正在录制并应用变声效果..."
        
        voiceChangerManager.startRecording(voiceType: selectedVoiceType)
    }
    
    @objc private func recordButtonTouchUp() {
        recordButton.backgroundColor = .systemRed
        recordButton.setTitle("按住说话", for: .normal)
        
        voiceChangerManager.stopRecording { [weak self] audioURL in
            DispatchQueue.main.async {
                self?.statusLabel.text = "录音完成！已应用\(self?.selectedVoiceType.rawValue ?? "")效果"
                // 自动播放录音
                if let url = audioURL {
                    self?.voiceChangerManager.playAudio(url: url, voiceType: self?.selectedVoiceType ?? .none)
                }
            }
        }
    }
}

// MARK: - VoiceChangerManager

class VoiceChangerManager {
    static let shared = VoiceChangerManager()
    
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var recordingURL: URL?
    
    private init() {}
    
    func startRecording(voiceType: VoiceChangerViewController.VoiceType) {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        recordingURL = documentsPath.appendingPathComponent("temp_recording.m4a")
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: recordingURL!, settings: settings)
            audioRecorder?.record()
        } catch {
            print("录音失败: \(error)")
        }
    }
    
    func stopRecording(completion: @escaping (URL?) -> Void) {
        audioRecorder?.stop()
        completion(recordingURL)
    }
    
    func playAudio(url: URL, voiceType: VoiceChangerViewController.VoiceType) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.enableRate = true
            audioPlayer?.rate = voiceType.playbackRate
            
            // 使用 AVAudioUnitTimePitch 来改变音调
            let engine = AVAudioEngine()
            let playerNode = AVAudioPlayerNode()
            let pitchEffect = AVAudioUnitTimePitch()
            
            pitchEffect.pitch = voiceType.pitchMultiplier
            
            engine.attach(playerNode)
            engine.attach(pitchEffect)
            
            engine.connect(playerNode, to: pitchEffect, format: nil)
            engine.connect(pitchEffect, to: engine.outputNode, format: nil)
            
            let audioFile = try AVAudioFile(forReading: url)
            let audioFormat = audioFile.processingFormat
            
            playerNode.scheduleFile(audioFile, at: nil)
            
            try engine.start()
            playerNode.play()
            
            // 停止引擎
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(audioFile.length) / Double(audioFormat.sampleRate)) {
                engine.stop()
            }
            
        } catch {
            print("播放失败: \(error)")
        }
    }
}
