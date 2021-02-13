//
//  ContentView.swift
//  WorkAnimations
//
//  Created by PATRICIA S SIQUEIRA on 13/02/21.
//

import SwiftUI

struct ColorCyclingRetangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Arrow: Shape {
    var insetAmount: CGFloat
    
    func path (in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: 0 , y: rect.maxY * 0.3))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.midX / 2), y: rect.maxY * 0.3))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.midX / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.midX * 1.5), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.midX * 1.5), y: rect.maxY * 0.3))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.3))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: 0 , y: rect.maxY * 0.3))
        
        return path
    }
}

struct ContentView: View {
    
    @State private var insetAmount: CGFloat = 50
    @State private var colorRetangle = 1.0
    
    var body: some View {
        VStack {
            Arrow(insetAmount: insetAmount)
                .stroke(lineWidth: insetAmount)
                .frame(width: 100, height: 100, alignment: .center)
            Slider(value: $insetAmount, in: 0...30, step: 0.1)
                .padding()
            ColorCyclingRetangle(amount: self.colorRetangle)
                .frame(width: 300, height: 300)
            Slider(value: $colorRetangle)
                .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
