//
//  AudioService.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 12/12/25.
//

import Foundation
import AVFoundation
import MediaPlayer

@MainActor
protocol AudioServiceProtocol: Sendable {
    
    func playAlarm(soundName: String)
    func stopAlarm()
    func duckVolumeForMission()
    func restoreMaxVolume()
}

@MainActor
final class AudioService: AudioServiceProtocol {
    
    static let shared: AudioServiceProtocol = AudioService()
    
    private var audioPlayer: AVAudioPlayer?
    private var fadeInTask: Task<Void, Never>?
    private var volumeEnforcementTask: Task<Void, Never>?
    private var userOriginalVolume: Float?
    
    private let fadeDuration: TimeInterval = 30
    private let timeStep: TimeInterval = 0.5
    private let volumeView = MPVolumeView(frame: .zero)
    
    
    // MARK: Initialization
    
    private init() {
        configureAudioSession()
    }
    
    
    // MARK: AudioServiceProtocol Implementation
    
    func playAlarm(soundName: String) {
        stopAlarm()
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            debugPrint("❌ AudioService Error: Sound file '\(soundName).mp3' not found in Bundle.")

            return
        }
        
        do {
            userOriginalVolume = AVAudioSession.sharedInstance().outputVolume
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0.01
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            setSystemVolume(to: 0.7)
            startVibration()
            startExponentialFadeIn()
            startVolumeEnforcement()
        } catch {
            debugPrint("❌ AudioService Error: Could not play audio: \(error)")
        }
    }
    
    func stopAlarm() {
        audioPlayer?.stop()
        
        audioPlayer = nil
        
        fadeInTask?.cancel()
        volumeEnforcementTask?.cancel()
        
        fadeInTask = nil
        volumeEnforcementTask = nil
        
        if let userOriginalVolume {
            setSystemVolume(to: userOriginalVolume)
        }
        
        userOriginalVolume = nil
    }
    
    func duckVolumeForMission() {
        fadeInTask?.cancel()
        audioPlayer?.setVolume(0.1, fadeDuration: 1)
    }
    
    func restoreMaxVolume() {
        audioPlayer?.setVolume(1, fadeDuration: 0.5)
        setSystemVolume(to: 0.7)
        startVibration()
    }
}


// MARK: Private methods

private extension AudioService {
    
    func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            
            try session.setCategory(.playback, options: [.duckOthers, .interruptSpokenAudioAndMixWithOthers])
            try session.setActive(true)
        } catch {
            debugPrint("❌ AudioService Error: Failed to configure session: \(error)")
        }
    }
    
    func setSystemVolume(to value: Float) {
        if let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                slider.value = value
            }
        }
    }
    
    func startVibration() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func startExponentialFadeIn() {
        fadeInTask?.cancel()
        
        fadeInTask = Task {
            guard let audioPlayer else { return }
            
            var elapsedTime: TimeInterval = 0
            
            try? await Task.sleep(nanoseconds: 500_000_000) // 0,5s
            
            while elapsedTime < fadeDuration {
                if Task.isCancelled { return }
                
                try? await Task.sleep(nanoseconds: UInt64(timeStep * 1_000_000_000))
                
                elapsedTime += timeStep
                
                let progress = elapsedTime / fadeDuration
                let exponentialVolume = Float(pow(progress, 3))
                
                audioPlayer.volume = max(0.0, min(exponentialVolume, 1))
            }
            
            audioPlayer.volume = 1
        }
    }
    
    func startVolumeEnforcement() {
        volumeEnforcementTask?.cancel()
        
        volumeEnforcementTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000) //1s
                
                if Task.isCancelled { return }
                
                let currentVolume = AVAudioSession.sharedInstance().outputVolume
                
                if currentVolume < 0.6 {
                    setSystemVolume(to: 0.7)
                }
            }
        }
    }
}
