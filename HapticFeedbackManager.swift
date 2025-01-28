//
//  HapticFeedbackManager.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 14/01/25.
//

import CoreHaptics
import Foundation

class HapticFeedbackManager {
    private var engine: CHHapticEngine?

    init() {
        prepareHaptics()
    }

    /// Prepara el motor de haptics
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error initializing haptic engine: \(error.localizedDescription)")
        }
    }

    /// Reproduce un efecto de vibración
    func playHapticFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // Vibración fuerte y breve
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic feedback: \(error.localizedDescription)")
        }
    }
}
