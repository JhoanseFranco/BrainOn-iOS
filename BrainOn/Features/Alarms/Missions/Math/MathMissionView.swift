//
//  MathMissionView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 14/12/25.
//

import SwiftUI

struct MathMissionView: View {
    
    // MARK: Properties
    
    @State private var viewModel: MathMissionsViewModel
    
    var onDismiss: () -> Void
    
    
    // MARK: Initialization
    
    init(difficulty: Difficulty, onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        _viewModel = State(initialValue: MathMissionsViewModel(difficulty: difficulty, audioService: AudioService.shared))
    }
    
    var body: some View {
        ZStack {
            AppAssets.Colors.brandBackground.ignoresSafeArea()
            
            VStack(spacing: 30) {
                ProgressBarView(value: viewModel.timeRemaining, total: viewModel.totalTime)
                    .frame(height: 8)
                    .padding(.top)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text(AlarmsStrings.Missions.solveToStopAlarm)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text(viewModel.currentProblem.question)
                        .font(.system(size: 60, weight: .bold, design: .monospaced))
                        .foregroundStyle(.white)
                    
                    Text(viewModel.userInput.isEmpty ? CommonStrings.questionMark : viewModel.userInput)
                        .font(.system(size: 50, weight: .medium))
                        .foregroundStyle(viewModel.isSuccess ? AppAssets.Colors.brandYellow : viewModel.shakeEffect ? .red : AppAssets.Colors.brandBlue)
                        .frame(minWidth: 100, minHeight: 80)
                        .background(Color.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(viewModel.isSuccess ? AppAssets.Colors.brandYellow : viewModel.shakeEffect ? .red : AppAssets.Colors.brandBlue))
                        .offset(x: viewModel.shakeEffect ? -10 : 0, y: 0)
                        .animation(viewModel.shakeEffect ? .spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0) : .default, value: viewModel.shakeEffect)
                }
                
                Spacer()
                
                CustomKeypad { key in
                    switch key {
                    case .check:
                        viewModel.submitAnswer()
                    case .delete:
                        viewModel.deleteInput()
                    case .number(let key):
                        viewModel.appendInput(number: key)
                    }
                }
                .padding(.bottom)
            }
            .padding()
        }
        .onAppear {
            viewModel.onMissionCompleted = onDismiss
            viewModel.startGame()
        }
        .onDisappear {
            viewModel.stopGame()
        }
    }
}

#Preview {
    MathMissionView(difficulty: .easy, onDismiss: {})
}
