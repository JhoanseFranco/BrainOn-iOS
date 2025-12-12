//
//  AudioService.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 12/12/25.
//

import Foundation
import AVFoundation

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
    
    private let fadeDuration: TimeInterval = 30
    private let fadeSteps: TimeInterval = 0.5
    
    
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
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            startVibration()
            startFadeIn()
        } catch {
            debugPrint("❌ AudioService Error: Could not play audio: \(error)")
        }
    }
    
    func stopAlarm() {
        audioPlayer?.stop()
        
        audioPlayer = nil
        
        fadeInTask?.cancel()
        
        fadeInTask = nil
    }
    
    func duckVolumeForMission() {
        fadeInTask?.cancel()
        audioPlayer?.setVolume(0.2, fadeDuration: 1)
    }
    
    func restoreMaxVolume() {
        audioPlayer?.setVolume(1, fadeDuration: 0.5)
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
    
    func startFadeIn() {
        fadeInTask?.cancel()
        
        let volumeStep = 1 / (fadeDuration / fadeSteps)
        
        fadeInTask = Task {
            guard let audioPlayer else { return }
            
            while audioPlayer.volume < 1 {
                try? await Task.sleep(for: .seconds(fadeSteps))
                
                if Task.isCancelled { return }
                
                if audioPlayer.volume + Float(volumeStep) >= 1 {
                    audioPlayer.volume = 1
                } else {
                    audioPlayer.volume += Float(volumeStep)
                }
            }
        }
    }
    
    func startVibration() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
