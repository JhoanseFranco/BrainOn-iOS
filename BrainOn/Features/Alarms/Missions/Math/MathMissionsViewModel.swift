//
//  MathMissionsViewModel.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 14/12/25.
//

import Foundation

@MainActor
@Observable
final class MathMissionsViewModel {
    
    // MARK: Properties
    
    private let audioService: AudioServiceProtocol
    private var timerTask: Task<Void, Never>?
    
    var currentProblem: MathProblem
    var difficulty: Difficulty
    var userInput = ""
    var timeRemaining: CGFloat = 60.0
    let totalTime: CGFloat = 60.0
    var isGameOver = false
    var isSuccess = false
    var shakeEffect = false
    var onMissionCompleted: (() -> Void)?
    
    
    // MARK: Initialization
    
    init(difficulty: Difficulty = .easy, audioService: AudioServiceProtocol) {
        self.audioService = audioService
        self.difficulty = difficulty
        
        currentProblem = MathProblem.generate(difficulty: difficulty)
    }
    
    
    // MARK: methods
    
    func startGame() {
        audioService.duckVolumeForMission()
        
        startTimer()
    }
    
    func stopGame() {
        timerTask?.cancel()
    }
    
    func appendInput(number: String) {
        if userInput.count < 4 {
            userInput += number
        }
    }
    
    func deleteInput() {
        if !userInput.isEmpty {
            userInput.removeLast()
        }
    }
    
    func submitAnswer() {
        guard let intValue = Int(userInput) else { return }
        
        if intValue == currentProblem.answer {
            handleSuccess()
        } else {
            handleError()
        }
    }
}


// MARK: Private methods

private extension MathMissionsViewModel {
    
    func handleSuccess() {
        timerTask?.cancel()
        
        isSuccess = true
        
        audioService.stopAlarm()
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            
            onMissionCompleted?()
        }
    }
    
    func handleError() {
        shakeEffect = true
        
        Task {
            try? await Task.sleep(for: .milliseconds(500))
            
            shakeEffect = false
            userInput = ""
        }
        
        timeRemaining = max(0, timeRemaining - 5)
    }
    
    func startTimer() {
        timerTask?.cancel()
        
        timerTask = Task {
            while timeRemaining > 0 {
                if Task.isCancelled { return }
                
                try? await Task.sleep(for: .seconds(0.1))
                
                timeRemaining -= 0.1
            }
            
            handleTimeOut()
        }
    }
    
    func handleTimeOut() {
        isGameOver = true
        
        audioService.restoreMaxVolume()
        
        resetForRetry()
    }
    
    func resetForRetry() {
        currentProblem = MathProblem.generate(difficulty: difficulty)
        userInput = ""
        timeRemaining = totalTime
        isGameOver = false
        
        startTimer()
    }
}
