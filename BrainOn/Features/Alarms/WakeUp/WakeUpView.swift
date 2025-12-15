//
//  WakeUpView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 12/12/25.
//

import SwiftUI

struct WakeUpView: View {
    
    
    // MARK: Properties
    
    @State private var viewModel: WakeUpViewModel
    @State private var isPulsing = false
    
    
    // MARK: Initialization
    
    init(alarmLabel: String) {
        _viewModel = State(initialValue: WakeUpViewModel(alarmLabel: alarmLabel, audioService: AudioService.shared))
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ZStack {
                AppAssets.Colors.brandYellow
                    .opacity(isPulsing ? 0.6 : 0.1)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isPulsing)
                
                Circle()
                    .stroke(AppAssets.Colors.brandYellow.opacity(0.3), lineWidth: 2)
                    .scaleEffect(isPulsing ? 1.5 : 1)
                    .opacity(isPulsing ? 0 : 1)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isPulsing)
            }
            
            VStack(spacing: 40) {
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: AppAssets.Icons.alarm)
                        .font(.system(size: 60))
                        .foregroundStyle(AppAssets.Colors.brandYellow)
                        .symbolEffect(.bounce, options: .repeat(.continuous))
                    
                    Text(viewModel.alarmLabel)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                }
                
                Text(viewModel.currentTime, style: .time)
                    .font(.system(size: 80, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: AppAssets.Colors.brandYellow, radius: 20)
                
                Spacer()
                
                Button {
                    viewModel.prepareForMission()
                    viewModel.stopAlarm()
                } label: {
                    Text(AlarmsStrings.WakeUp.iAmAwake)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(AppAssets.Colors.brandYellow)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: AppAssets.Colors.brandYellow.opacity(0.5), radius: 10)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            viewModel.onAppear()
            
            isPulsing = true
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}

#Preview {
    WakeUpView(alarmLabel: "Entrenamiento")
}
