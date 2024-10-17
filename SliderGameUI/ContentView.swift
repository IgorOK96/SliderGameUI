//
//  ContentView.swift
//  SliderGameUI
//
//  Created by user246073 on 10/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 1...100)
    @State private var currentValue: Float = 50.0
    @State private var opacity: CGFloat = 1.0
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Подвинте слайдер, как можно ближе к: \(targetValue)")
            
            HStack {
                Text("0")
                UISliderRepresentation(
                    value: $currentValue,
                    range: 1...100,
                    thumbOpacity: calculateOpacity()
                )
                Text("100")
            }
            
            Button("Проверь меня!") { showAlert = true }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Your Score"),
                        message: Text("Ваш результат: \(computeScore())"),
                        dismissButton: .default(Text("ОК"))
                    )
                }
            
            Button("Начать заново", action: { restartGame() })
        }
        .padding()
    }
    
    private func restartGame() {
        targetValue = Int.random(in: 1...100)
    }
    
    private func calculateOpacity() -> CGFloat {
        let difference = abs(CGFloat(currentValue) - CGFloat(targetValue))
        let normalizedDifference = 1.0 - (difference / 100.0)
        return max(0.1, normalizedDifference)
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(Double(currentValue)))
        return 100 - difference}
}

#Preview {
    ContentView()
}
