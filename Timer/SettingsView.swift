//
//  SettingsView.swift
//  Timer
//
//  Created by Kimberly Torres on 12/5/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var countdownTime: Int  // Binding to update the countdown time in the main view
    @Binding var timeRemaining: Int  // Binding to update the remaining time in the main view
    @Environment(\.dismiss) var dismiss  // Environment variable to dismiss the view
    @State private var newTime = ""  // Holds user input for new time
    @FocusState private var isTextFieldFocused: Bool  // Focus state for the text field

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [Color.orange.opacity(0.8), Color.pink.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Title
                Text("Set Timer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                // Input field for new time
                TextField("Enter time in seconds", text: $newTime)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .focused($isTextFieldFocused)

                // Save button to update the timer
                Button(action: updateTime) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .scaleEffect(isTextFieldFocused ? 1.1 : 1.0)  // Animation for button focus
                        .animation(.easeInOut, value: isTextFieldFocused)
                }

                Spacer()
            }
            .padding()
        }
        .onAppear {
            // Automatically focus on the text field when the view appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isTextFieldFocused = true
            }
        }
    }

    // Update the countdown time when Save is pressed
    func updateTime() {
        if let time = Int(newTime), time > 0 {
            countdownTime = time
            timeRemaining = time
            dismiss()
        }
    }
}
