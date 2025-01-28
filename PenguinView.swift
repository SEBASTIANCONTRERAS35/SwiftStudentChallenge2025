import SwiftUI

struct PenguinView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    
    /// Índice del cuadro actual de la animación
    @State private var currentFrame: Int = 0
    
    /// Controla el movimiento/animación extra (por ejemplo, "levitar")
    @State private var levitate: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Imagen base del pingüino animado
                Image("PinguinoAnimacion_\(String(format: "%05d", currentFrame))")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
                    .scaleEffect(1.2) // Ajustar escala si lo quieres más grande
                    .onAppear {
                        startPenguinAnimation()
                    }
                
                // Capas de accesorios
                ZStack {
                    // 1. Corbata
                    Image("Tie")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.1)
                        .offset(x: geometry.size.width * 0.005, y: geometry.size.height * 0.03)
                        .opacity(
                            progressModel.star1CompleteOrga &&
                            progressModel.star2CompleteOrga &&
                            progressModel.star3CompleteOrga &&
                            progressModel.star4CompleteOrga ? 1 : 0
                        )
                    
                    // 2. Gafas
                    Image("Glass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.1)
                        .offset(x: geometry.size.width * 0.0, y: geometry.size.height * -0.07)
                        .opacity(
                            progressModel.star1CompleteStudy &&
                            progressModel.star2CompleteStudy &&
                            progressModel.star3CompleteStudy &&
                            progressModel.star4CompleteStudy ? 1 : 0
                        )
                    
                    // 3. Sombrero
                    Image("Hat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.1)
                        .offset(x: geometry.size.width * 0.0, y: geometry.size.height * -0.13)
                        .opacity(
                            progressModel.star1CompleteMemo &&
                            progressModel.star2CompleteMemo &&
                            progressModel.star3CompleteMemo ? 1 : 0
                        )
                }
                // Alineamos accesorios con el “centro” del pingüino
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    // Animación simple de frames
    private func startPenguinAnimation() {
        DispatchQueue.global().async {
            while true {
                for frame in 0..<14 {
                    DispatchQueue.main.async {
                        self.currentFrame = frame
                    }
                    Thread.sleep(forTimeInterval: 0.1)
                }
                // Pequeña pausa al final del ciclo
                Thread.sleep(forTimeInterval: 1.5)
            }
        }
    }
}
