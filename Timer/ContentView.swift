//
//  ContentView.swift
//  Timer
//
//  Created by Kimberly Torres on 12/5/24.
//

import SwiftUI

struct ContentView: View {
    // State variables for the timer
    @State private var countdownTime = 60  // Default countdown time
    @State private var timeRemaining = 60  // Remaining time
    @State private var timerRunning = false  // Indicates if the timer is running
    @State private var timer: Timer? = nil  // Holds the timer object

    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background for a modern look
                LinearGradient(
                    colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()  // Ensure background covers the whole screen

                VStack(spacing: 20) {
                    // Title of the app
                    Text("Countdown Timer")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()

                    // Animated time display
                    Text("\(timeRemaining) seconds")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 200, height: 200)
                                .scaleEffect(timerRunning ? 1.2 : 1.0)  // Animation for pulse effect
                                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: timerRunning)
                        )

                    Spacer()

                    // Buttons displayed based on timer state
                    if !timerRunning && timeRemaining == countdownTime {
                        // Show Start and Settings buttons when timer is not running
                        VStack(spacing: 15) {
                            Button(action: startTimer) {
                                Text("Start")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }

                            NavigationLink(destination: SettingsView(countdownTime: $countdownTime, timeRemaining: $timeRemaining)) {
                                Text("Settings")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                        }
                    } else {
                        // Show Reset, Pause/Resume, and Stop buttons during countdown
                        HStack(spacing: 15) {
                            Button(action: resetAndRestartTimer) {
                                Text("Reset")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.pink)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }

                            if timerRunning {
                                Button(action: pauseTimer) {
                                    Text("Pause")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.orange)
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                }
                            } else if timeRemaining < countdownTime {
                                Button(action: resumeTimer) {
                                    Text("Resume")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                }
                            }

                            Button(action: stopTimer) {
                                Text("Stop")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }

    // Start the countdown timer
    func startTimer() {
        timerRunning = true
        timeRemaining = countdownTime
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.timerRunning = false
            }
        }
    }

    // Reset the timer and immediately start it again
    func resetAndRestartTimer() {
        timer?.invalidate()
        timeRemaining = countdownTime
        timerRunning = true
        startTimer()
    }

    // Pause the timer
    func pauseTimer() {
        timer?.invalidate()
        timerRunning = false
    }

    // Resume the paused timer
    func resumeTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.timerRunning = false
            }
        }
    }

    // Stop the timer and reset it to the initial value
    func stopTimer() {
        timer?.invalidate()
        timeRemaining = countdownTime
        timerRunning = false
    }
}
