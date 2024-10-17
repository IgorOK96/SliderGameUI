//
//  UISliderRepresentation.swift
//  SliderGameUI
//
//  Created by user246073 on 10/17/24.
//

import SwiftUI

struct UISliderRepresentation: UIViewRepresentable {
    @Binding var value: Float
    var range: ClosedRange<Float>
    var thumbOpacity: CGFloat = 1.0

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = range.lowerBound
        slider.maximumValue = range.upperBound
        slider.value = value
        
        slider.thumbTintColor = UIColor.systemRed.withAlphaComponent(thumbOpacity)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged),
            for: .valueChanged
        )
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
        uiView.thumbTintColor = UIColor.systemRed.withAlphaComponent(thumbOpacity)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    class Coordinator: NSObject {
        @Binding var value: Float
        
        init(value: Binding<Float>) {
            self._value = value
        }

        @objc func valueChanged(_ sender: UISlider) {
            value = sender.value
        }
    }
}

struct SliderView: View {
    @State private var sliderValue: Float = 4
    @State private var thumbOpacity: CGFloat = 1.0
    
    var body: some View {
        VStack {
            UISliderRepresentation(value: $sliderValue, range: 0...100, thumbOpacity: thumbOpacity)
                .frame(height: 50)
                .padding()
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
