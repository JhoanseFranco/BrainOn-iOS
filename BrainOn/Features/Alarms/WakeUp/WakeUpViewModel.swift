//
//  WakeUpViewModel.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 12/12/25.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class WakeUpViewModel {
    
    // MARK: Properties
    
    private let audioService: AudioServiceProtocol
    private var clockTimer: Task<Void, Never>?
    
    var currentTime = Date()
    var alarmLabel: String
    
    
    // MARK: Initialization
    
    init(alarmLabel: String, audioService: AudioServiceProtocol = AudioService.shared) {
        self.alarmLabel = alarmLabel
        self.audioService = audioService
    }
    
    func onAppear() {
        audioService.playAlarm(soundName: "alarm_sound")
        //startClock()
    }
    
    func onDisappear() {
        clockTimer?.cancel()
    }
    
    func stopAlarm() {
        audioService.stopAlarm()
    }
    
    func prepareForMission() {
        audioService.duckVolumeForMission()
    }
}


// MARK: Private methods

private extension WakeUpViewModel {
    
    func startClock() {
        clockTimer?.cancel()
        
        clockTimer = Task {
            while !Task.isCancelled {
                currentTime = Date()
                
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }
}
