//
//  RoadmapView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 24/01/25.
//

import SwiftUI

struct RoadmapView: View {
    let milestones: [Milestone]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 1) Dibuja el camino (Path)
                Path { path in
                    // Asegúrate de tener al menos un punto
                    guard let first = milestones.first else { return }
                    // Convertimos la posición relativa en coordenadas del GeometryReader
                    let startPoint = CGPoint(
                        x: first.x * geometry.size.width,
                        y: first.y * geometry.size.height
                    )
                    path.move(to: startPoint)
                    
                    for milestone in milestones.dropFirst() {
                        let nextPoint = CGPoint(
                            x: milestone.x * geometry.size.width,
                            y: milestone.y * geometry.size.height
                        )
                        path.addLine(to: nextPoint)
                    }
                }
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))

                ForEach(milestones) { milestone in
                    let point = CGPoint(
                        x: milestone.x * geometry.size.width,
                        y: milestone.y * geometry.size.height
                    )

                    // En lugar de usar overlay en el círculo,
                    // creamos un ZStack que contenga tanto el círculo como el texto.
                    ZStack(alignment: .top) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                        
                        Text(milestone.title)
                            .font(.caption2)
                            .padding(4)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(5)
                            .offset(y: 25)
                            // Ajusta este offset según lo alto que quieras el texto
                    }
                    .position(point)
                    // Posicionamos el ZStack completo donde corresponda
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            // Opcional: agrega un fondo tipo “montañas”
            .background(
                Image("Map")
                    .resizable()
                    .scaledToFill()
            )
        }
    }
}
struct Milestone: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var title: String
    // Podrías incluir más info, como un icono, descripción, etc.
}
#Preview {
    GeometryReader { geometry in
        
        
        let sampleMilestones = [
            Milestone(x: 0.1, y: 1, title: "Start"),
            Milestone(x: 0.3, y: 0.85, title: "Task 1"),
            Milestone(x: 0.5, y: 0.55, title: "Task 2"),
            Milestone(x: 0.9, y: 0.4, title: "Task 3"),
            Milestone(x: 0.5, y: 0.3, title: "Task 4"),
            Milestone(x: 0.2, y: 0.2, title: "Task 5"),
            Milestone(x: 0.51, y: 0.01, title: "Goal")
        ]
        
        // Aquí instancias la vista
        return RoadmapView(milestones: sampleMilestones)
            .frame(width: geometry.size.width * 0.5, height:  geometry.size.height * 0.4)
            .padding()
    }
}
