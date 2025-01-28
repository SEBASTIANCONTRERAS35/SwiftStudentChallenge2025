import SwiftUI

struct MindMapView: View {
    @State  private var currentStep = 1
    @State private var nextStep: Bool = true
    @State private var animationProgress1: CGFloat = 0 // Controla el progreso de la primera animación
    @State private var animationProgress2: CGFloat = 0 // Controla el progreso de la segunda animación
    @State private var animationProgress3: CGFloat = 0 // Controla el progreso de la tercera animación
    @State private var animationProgress4: CGFloat = 0
    @State private var scale: CGFloat = 0 // Controla el efecto de escala
    @State private var scaleGreen: CGFloat = 0
     @State private var scaleYellow: CGFloat = 0
     @State private var scaleBlueLight: CGFloat = 0
     @State private var scalePurple: CGFloat = 0
    @State private var scaleIdeas: CGFloat = 0
    @State private var scaleImages: CGFloat = 0
    @State private var scaleSymbols: CGFloat = 0
    @State private var scaleDefinitions: CGFloat = 0
    @State private var scaleQuestions: CGFloat = 0
    @State private var scaleAssociations: CGFloat = 0
    @State private var scaleFlashcards: CGFloat = 0
    @State private var scaleLinks: CGFloat = 0
    @State private var scaleTriggers: CGFloat = 0
    @State private var scalePatterns: CGFloat = 0
    @State private var scalePrompts: CGFloat = 0
    @State private var scaleRelations: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                VStack(spacing: geometry.size.height * 0.025) {
                    
                    
                    Text("MindMap")
                        .font(Font.custom("Didot-Bold", size: geometry.size.width * 0.15)) // Fuente ChalkboardSE
                        .padding(.top, geometry.size.height * 0.07)
                    if (currentStep==1){
                        Text("""
                               A Mind Map is a visual representation of ideas, concepts, or information organized in a non-linear, hierarchical structure. 
                               
                               It starts with a central idea and expands outward with branches, making it easier to organize thoughts, identify relationships, and stimulate creativity.
                               """)
                                        .font(.system(size: geometry.size.width * 0.04)) // Tamaño dinámico
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black) // Color del texto
                                        .padding() // Espaciado interno del texto
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.white) // Fondo blanco
                                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Sombra
                                        )
                                        .padding(.horizontal, geometry.size.width * 0.1) // Espaciado horizontal
                                        .padding(.bottom, geometry.size.height * 0.05) // Espaciado inferior
                    }
                    if (currentStep>1){
                            
                        
                        ZStack (alignment : .center) {
                            // Líneas principales (curvas) desde el centro
                            if (currentStep>=3){
                                
                                Path { path in
                                    let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 4)

                                    // Línea hacia arriba izquierda
                                    path.move(to: center)
                                    path.addCurve(to: CGPoint(x: center.x - 100, y: center.y - 100),
                                                  control1: CGPoint(x: center.x - 50, y: center.y - 20),
                                                  control2: CGPoint(x: center.x - 100, y: center.y - 50))
                                    
                                    // Línea hacia arriba derecha
                                    path.move(to: center)
                                    path.addCurve(to: CGPoint(x: center.x + 100, y: center.y - 100),
                                                  control1: CGPoint(x: center.x + 50, y: center.y - 20),
                                                  control2: CGPoint(x: center.x + 100, y: center.y - 50))
                                    
                                    // Línea hacia abajo izquierda
                                    path.move(to: center)
                                    path.addCurve(to: CGPoint(x: center.x - 100, y: center.y + 100),
                                                  control1: CGPoint(x: center.x - 50, y: center.y + 20),
                                                  control2: CGPoint(x: center.x - 100, y: center.y + 50))
                                    
                                    // Línea hacia abajo derecha
                                    path.move(to: center)
                                    path.addCurve(to: CGPoint(x: center.x + 100, y: center.y + 100),
                                                  control1: CGPoint(x: center.x + 50, y: center.y + 20),
                                                  control2: CGPoint(x: center.x + 100, y: center.y + 50))
                                }
                                .trim(from: 0, to: animationProgress1) // Controla el progreso de la animación
                                .stroke(Color.red, lineWidth: 6) // Estilo de línea
                                .onAppear {
                                    nextStep = false;
                                    // Inicia la animación al aparecer la vista
                                    withAnimation(.easeInOut(duration: 2)) {
                                        animationProgress1 = 1.0
                                    }
                                    nextStep = true
                                }
                            }
                            // Líneas desde el rectángulo verde
                            if (currentStep>=5){
                                
                                
                                Path { path in
                                    let greenBox = CGPoint(x: geometry.size.width / 2 - 100, y: geometry.size.height / 4 - 100)
                                    
                                    // Línea a la izquierda (rectángulo amarillo)
                                    path.move(to: greenBox)
                                    path.addCurve(to: CGPoint(x: greenBox.x - 100, y: greenBox.y + 40),
                                                  control1: CGPoint(x: greenBox.x - 30, y: greenBox.y + 20),
                                                  control2: CGPoint(x: greenBox.x - 100, y: greenBox.y + 30))
                                    
                                    // Línea arriba (rectángulo morado)
                                    path.move(to: greenBox)
                                    path.addCurve(to: CGPoint(x: greenBox.x + 40, y: greenBox.y - 100),
                                                  control1: CGPoint(x: greenBox.x + 20, y: greenBox.y - 30),
                                                  control2: CGPoint(x: greenBox.x + 30, y: greenBox.y - 50))
                                    
                                    // Línea derecha (rectángulo azul claro)
                                    path.move(to: greenBox)
                                    path.addCurve(to: CGPoint(x: greenBox.x - 100, y: greenBox.y - 100),
                                                  control1: CGPoint(x: greenBox.x + 30, y: greenBox.y + 20),
                                                  control2: CGPoint(x: greenBox.x + 40, y: greenBox.y + 30))
                                }
                                .trim(from: 0, to: animationProgress2) // Controla el progreso de la animación
                                .stroke(Color.green, lineWidth: 6) // Estilo de línea
                                .onAppear {
                                    nextStep = false;
                                    // Inicia la animación al aparecer la vista
                                    withAnimation(.easeInOut(duration: 2)) {
                                        animationProgress1 = 1.0
                                    }
                                    nextStep = true
                                }
                                
                                Path { path in
                                    let PurpleBox = CGPoint(x: geometry.size.width / 2 + 100, y: geometry.size.height / 4 + 100)
                                    
                                    // Línea a la izquierda (rectángulo amarillo)
                                    path.move(to: PurpleBox)
                                    path.addCurve(to: CGPoint(x: PurpleBox.x + 100, y: PurpleBox.y - 40),
                                                  control1: CGPoint(x: PurpleBox.x + 30, y: PurpleBox.y - 20),
                                                  control2: CGPoint(x: PurpleBox.x + 100, y: PurpleBox.y - 30))
                                    
                                    // Línea arriba (rectángulo morado)
                                    path.move(to: PurpleBox)
                                    path.addCurve(to: CGPoint(x: PurpleBox.x - 40, y: PurpleBox.y + 100),
                                                  control1: CGPoint(x: PurpleBox.x - 20, y: PurpleBox.y + 30),
                                                  control2: CGPoint(x: PurpleBox.x - 30, y: PurpleBox.y + 50))
                                    
                                    // Línea derecha (rectángulo azul claro)
                                    path.move(to: PurpleBox)
                                    path.addCurve(to: CGPoint(x: PurpleBox.x + 100, y: PurpleBox.y + 100),
                                                  control1: CGPoint(x: PurpleBox.x - 30, y: PurpleBox.y - 20),
                                                  control2: CGPoint(x: PurpleBox.x - 40, y: PurpleBox.y - 30))
                                }
                                .trim(from: 0, to: animationProgress2) // Controla el progreso de la animación
                                .stroke(Color.purple, lineWidth: 6) // Estilo de línea
                                .onAppear {
                                    // Inicia la animación al aparecer la vista
                                    withAnimation(.easeInOut(duration: 2)) {
                                        animationProgress2 = 1.0
                                    }
                                }
                                
                                Path { path in
                                    let BrownBox = CGPoint(x: geometry.size.width / 2 + 100, y: geometry.size.height / 4 - 100)
                                    
                                    // Línea a la izquierda (rectángulo amarillo)
                                    path.move(to: BrownBox)
                                    path.addCurve(to: CGPoint(x: BrownBox.x + 100, y: BrownBox.y + 40),
                                                  control1: CGPoint(x: BrownBox.x + 30, y: BrownBox.y + 20),
                                                  control2: CGPoint(x: BrownBox.x + 100, y: BrownBox.y + 30))
                                    
                                    // Línea arriba (rectángulo morado)
                                    path.move(to: BrownBox)
                                    path.addCurve(to: CGPoint(x: BrownBox.x - 40, y: BrownBox.y - 100),
                                                  control1: CGPoint(x: BrownBox.x - 20, y: BrownBox.y - 30),
                                                  control2: CGPoint(x: BrownBox.x - 30, y: BrownBox.y - 50))
                                    
                                    // Línea derecha (rectángulo azul claro)
                                    path.move(to: BrownBox)
                                    path.addCurve(to: CGPoint(x: BrownBox.x + 100, y: BrownBox.y - 100),
                                                  control1: CGPoint(x: BrownBox.x - 30, y: BrownBox.y + 20),
                                                  control2: CGPoint(x: BrownBox.x - 40, y: BrownBox.y + 30))
                                }
                                .trim(from: 0, to: animationProgress2) // Controla el progreso de la animación
                                .stroke(Color(hex: "CA940B"), lineWidth: 6) // Estilo de línea
                                .onAppear {
                                    // Inicia la animación al aparecer la vista
                                    withAnimation(.easeInOut(duration: 2)) {
                                        animationProgress2 = 1.0
                                    }
                                }
                                
                                Path { path in
                                    let BlueBox = CGPoint(x: geometry.size.width / 2 - 100, y: geometry.size.height / 4 + 100)
                                    
                                    // Línea a la izquierda (rectángulo amarillo)
                                    path.move(to: BlueBox)
                                    path.addCurve(to: CGPoint(x: BlueBox.x - 100, y: BlueBox.y - 40),
                                                  control1: CGPoint(x: BlueBox.x - 30, y: BlueBox.y - 20),
                                                  control2: CGPoint(x: BlueBox.x + 100, y: BlueBox.y + 30))
                                    
                                    // Línea arriba (rectángulo morado)
                                    path.move(to: BlueBox)
                                    path.addCurve(to: CGPoint(x: BlueBox.x + 40, y: BlueBox.y + 100),
                                                  control1: CGPoint(x: BlueBox.x + 20, y: BlueBox.y + 30),
                                                  control2: CGPoint(x: BlueBox.x + 30, y: BlueBox.y + 50))
                                    
                                    // Línea derecha (rectángulo azul claro)
                                    path.move(to: BlueBox)
                                    path.addCurve(to: CGPoint(x: BlueBox.x - 100, y: BlueBox.y + 100),
                                                  control1: CGPoint(x: BlueBox.x + 30, y: BlueBox.y - 20),
                                                  control2: CGPoint(x: BlueBox.x + 40, y: BlueBox.y - 30))
                                }
                                .trim(from: 0, to: animationProgress2) // Controla el progreso de la animación
                                .stroke(Color.blue, lineWidth: 6) // Estilo de línea
                                .onAppear {
                                    // Inicia la animación al aparecer la vista
                                    withAnimation(.easeInOut(duration: 2)) {
                                        animationProgress2 = 1.0
                                    }
                                }
                            }
                            
                            // Centro: Círculo rojo
                            if (currentStep>=2){
                                
                                Circle()
                                                .fill(Color.red)
                                                .frame(width: 100, height: 100)
                                                .overlay(
                                                    Text("Main  topic")
                                                        .font(.headline) // Cambia el tamaño del texto
                                                        .foregroundColor(.white) // Color del texto
                                                        .multilineTextAlignment(.center) // Alineación al centro si tiene varias líneas
                                                )
                                                .scaleEffect(scale) // Aplica el efecto de escala
                                                .onAppear {
                                                    // Inicia un temporizador para activar la animación
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                        withAnimation(.easeInOut(duration: 1)) {
                                                            scale = 1 // Cambia la escala a tamaño completo
                                                        }
                                                    }
                                                }
                                                .position(x: geometry.size.width / 2, y: geometry.size.height / 4)
                            }
                            if (currentStep>=4){
                                
                            
                            // Arriba izquierda: Rectángulo verde
                                Rectangle()
                                                   .fill(Color.green)
                                                   .frame(width: 80, height: 80)
                                                   .overlay(
                                                       Text("Subtopic")
                                                           .font(.callout)
                                                           .foregroundColor(.white)
                                                           .multilineTextAlignment(.center)
                                                   )
                                                   .scaleEffect(scaleGreen)
                                                   .onAppear {
                                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                           withAnimation(.easeInOut(duration: 1)) {
                                                               scaleGreen = 1
                                                           }
                                                       }
                                                   }
                                                   .position(x: geometry.size.width / 2 - 100, y: geometry.size.height / 4 - 100)

                                               // Arriba derecha: Rectángulo amarillo
                                               Rectangle()
                                                   .fill(Color(hex: "CA940B"))
                                                   .frame(width: 80, height: 80)
                                                   .overlay(
                                                       Text("Subtopic")
                                                           .font(.callout)
                                                           .foregroundColor(.white)
                                                           .multilineTextAlignment(.center)
                                                   )
                                                   .scaleEffect(scaleYellow)
                                                   .onAppear {
                                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                           withAnimation(.easeInOut(duration: 1)) {
                                                               scaleYellow = 1
                                                           }
                                                       }
                                                   }
                                                   .position(x: geometry.size.width / 2 + 100, y: geometry.size.height / 4 - 100)

                                               // Abajo izquierda: Rectángulo azul claro
                                               Rectangle()
                                                   .fill(Color(hex: "2EABFA"))
                                                   .frame(width: 80, height: 80)
                                                   .overlay(
                                                       Text("Subtopic")
                                                           .font(.callout)
                                                           .foregroundColor(.white)
                                                           .multilineTextAlignment(.center)
                                                   )
                                                   .scaleEffect(scaleBlueLight)
                                                   .onAppear {
                                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                           withAnimation(.easeInOut(duration: 1)) {
                                                               scaleBlueLight = 1
                                                           }
                                                       }
                                                   }
                                                   .position(x: geometry.size.width / 2 - 100, y: geometry.size.height / 4 + 100)

                                               // Abajo derecha: Rectángulo púrpura
                                               Rectangle()
                                                   .fill(Color.purple)
                                                   .frame(width: 80, height: 80)
                                                   .overlay(
                                                       Text("Subtopic")
                                                           .font(.callout)
                                                           .foregroundColor(.white)
                                                           .multilineTextAlignment(.center)
                                                   )
                                                   .scaleEffect(scalePurple)
                                                   .onAppear {
                                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                                           withAnimation(.easeInOut(duration: 1)) {
                                                               scalePurple = 1
                                                           }
                                                       }
                                                   }
                                                   .position(x: geometry.size.width / 2 + 100, y: geometry.size.height / 4 + 100)
                        }
                            if (currentStep>=5){
                                
                                
                                // Pequeños rectángulos conectados al verde
                                Rectangle()
                                    .fill(Color(hex: "FABC2E"))
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Text("Ideas")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .scaleEffect(scaleIdeas)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleIdeas = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 - 200, y: geometry.size.height / 4 - 75)

                                Rectangle()
                                    .fill(Color.pink)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Text("Images")
                                            .font(.system(size: 17))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .scaleEffect(scaleImages)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleImages = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 - 60, y: geometry.size.height / 4 - 200)

                                Rectangle()
                                    .fill(Color.cyan)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Text("Symbols")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .scaleEffect(scaleSymbols)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleSymbols = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 - 200, y: geometry.size.height / 4 - 200)
                                
                                
                                
                                Rectangle()
                                    .fill(Color(hex: "C4BB11"))
                                    .frame(width: 70, height: 60)
                                    .overlay(
                                        Text("Definitions")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .scaleEffect(scaleDefinitions)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleDefinitions = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 + 200, y: geometry.size.height / 4 + 75)

                                Rectangle()
                                    .fill(Color(hex: "FA9E2E"))
                                    .frame(width: 70, height: 60)
                                    .overlay(
                                        Text("Questions")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .scaleEffect(scaleQuestions)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleQuestions = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 + 60, y: geometry.size.height / 4 + 200)

                                Rectangle()
                                    .fill(Color(hex: "1F7CFE"))
                                    .frame(width: 80, height: 60)
                                    .overlay(
                                        Text("Associations")
                                            .font(.system(size: 13.5))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .scaleEffect(scaleAssociations)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleAssociations = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 + 200, y: geometry.size.height / 4 + 200)
                                
                                
                                Rectangle()
                                    .fill(Color(hex: "FA2E2E"))
                                    .overlay(
                                        Text("Flashcards")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .frame(width: 70, height: 70)
                                    .scaleEffect(scaleFlashcards)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleFlashcards = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 + 200, y: geometry.size.height / 4 - 75)

                                Rectangle()
                                    .fill(Color(hex: "3F2EFA"))
                                    .overlay(
                                        Text("Links")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .frame(width: 60, height: 60)
                                    .scaleEffect(scaleLinks)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleLinks = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 + 60, y: geometry.size.height / 4 - 200)

                                Rectangle()
                                    .fill(Color(hex: "2EABFA"))
                                    .overlay(
                                        Text("Triggers")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .frame(width: 60, height: 60)
                                    .scaleEffect(scaleTriggers)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleTriggers = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 + 200, y: geometry.size.height / 4 - 200)

                                Rectangle()
                                    .fill(Color(hex: "FA2E2E"))
                                    .overlay(
                                        Text("Patterns")
                                            .font(.system(size: 17))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .frame(width: 70, height: 60)
                                    .scaleEffect(scalePatterns)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scalePatterns = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 - 200, y: geometry.size.height / 4 + 75)

                                Rectangle()
                                    .fill(Color(hex: "F03D40"))
                                    .overlay(
                                        Text("Prompts")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .frame(width: 60, height: 60)
                                    .scaleEffect(scalePrompts)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scalePrompts = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 - 60, y: geometry.size.height / 4 + 200)

                                Rectangle()
                                    .fill(Color(hex: "2EABFA"))
                                    .overlay(
                                        Text("Relations")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    )
                                    .frame(width: 70, height: 60)
                                    .scaleEffect(scaleRelations)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                scaleRelations = 1
                                            }
                                        }
                                    }
                                    .position(x: geometry.size.width / 2 - 200, y: geometry.size.height / 4 + 200)
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    }
                    
                }
                .padding()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.95, alignment: .center) // Alinea al tope
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                                       .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Asegura que
                .onTapGesture {
                    if nextStep {
                        nextStep = false // Bloquea más clics hasta que termine la animación

                        withAnimation(.easeInOut(duration: 1)) {
                            currentStep += 1 // Incrementa el paso con animación
                        }

                        // Restaura `nextStep` después de la duración de la animación
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            nextStep = true
                        }
                    }
                }
                .onChange(of: currentStep) { newValue in
                    if (newValue == 6 && !progressModel.star2CompleteStudy){
                        progressModel.star2CompleteStudy = true // Actualiza el estado
                  
                        withAnimation {
                            notificationOffset = -500
                        }
                        
                        // Vuelve a mover la notificación hacia arriba después de 2 segundos
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation {
                                notificationOffset = -800
                            }
                        }
                    }
                }
                VStack{
              
                        if (currentStep==2){
                            
                            HStack{
                                                   
                                                    Text(" Identify the goal of your mind map and draw it in the center of your canvas")
                                                        .multilineTextAlignment(.center)
                                                        .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .background(Color.black)
                                                        .cornerRadius(20)
                                                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.15)
                                                }
                                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.15 , alignment: .trailing)
                                               // .background(Color.blue)
                                                .cornerRadius(20)
                        }
                        
           
                        HStack{
                            if (currentStep==3){
                                Text("  Identify key subtopics or categories related to the central idea.  ")
                                                            .multilineTextAlignment(.center)
                                                            .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                                            .foregroundColor(.white)
                                                            .padding()
                                                            .background(Color.black)
                                                            .cornerRadius(20)
                                                            .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2)
                            }
                            
                            Spacer().frame(height: geometry.size.height * 1)
                            if (currentStep==4){
                                Text("  Draw thick lines radiating outward from the center and label them with keywords or phrases. ")
                                                           .multilineTextAlignment(.center)
                                                           .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                                           .foregroundColor(.white)
                                                           .padding()
                                                           .background(Color.black)
                                                           .cornerRadius(20)
                                                           .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.4)
                            }
                            
                         
                           
                            
                        }
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.35 , alignment: .leading)
                       // .background(Color.blue)
                        .cornerRadius(20)
                        Spacer().frame(height: geometry.size.height * 0.4)
                    if (currentStep==5){
                        
                        HStack{
                                               
                                                Text(" For each main branch, add smaller branches that break the topic into finer details.")
                                                    .multilineTextAlignment(.center)
                                                    .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .background(Color.black)
                                                    .cornerRadius(20)
                                                    .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.15)
                                            }
                                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.15 , alignment: .trailing)
                                           // .background(Color.blue)
                                            .cornerRadius(20)
                    }
                        
                    
                }
                .frame(height: geometry.size.height * 0.9, alignment: .top )
                VStack(spacing: 15) {
                    Image("StarStudy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80) // Tamaño de la imagen
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // Sombra sutil

                    Text("You've just earned a Study Star!")
                        .font(.headline) // Fuente llamativa pero profesional
                        .multilineTextAlignment(.center) // Alineación centrada
                        .foregroundColor(Color.white) // Texto en blanco
                        .padding(.horizontal, 20) // Espaciado interno para que el texto no esté pegado a los bordes
                }
                
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.9)) // Fondo azul semi-transparente
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10) // Sombra para darle profundidad
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.8), lineWidth: 1) // Borde blanco sutil
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Centrado en la pantalla
                .padding(.horizontal, 30) // Espaciado lateral
                .offset(y: notificationOffset) // Controla la posición con el estado
                        .animation(.easeInOut(duration: 0.5), value: notificationOffset) // Ani
            }
        }
        .navigationBarBackButtonHidden(true) // Oculta el botón predeterminado
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Navega hacia atrás
                        }) {
                            HStack {
                                Image(systemName: "arrow.left.circle") // Icono de retroceso
                                Text("BACK")
                            }
                            .font(.headline)
                            .foregroundColor(Color(hex: "#8E4D22")) // Cambia el color del ícono y texto

                        }
                    }
                }
    }
}

#Preview {
    MindMapView()
}
