//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 14/01/25.
//

import SwiftUI

struct KanbanView: View {
    @State var currentStep : Int = 1
    @State var showLetters : Bool = false
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    var maxSteps : Int = 14
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .top){
                
                
                VStack(spacing: geometry.size.height * 0.05) {
                    Text("Kanban ")
                        .font(Font.custom("Baskerville-Bold", size: geometry.size.width * 0.1)) // Fuente personalizada y tamaño dinámico
                        .padding(.top, geometry.size.height * 0.02)
                    if (currentStep==1){
                        Text("""
           Kanban is a workflow management method that uses a visual board to track tasks through different stages, emphasizing continuous improvement, limiting work in progress, and optimizing efficiency.
           """)
                        .font(.system(size:  geometry.size.width * 0.04)) // Tamaño dinámico
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
                    else {
                        
                        
                        HStack(alignment: .top,spacing: 0) { // Alineación superior en el HStack
                            VStack( spacing: 0) {
                                Text("To do")
                                    .frame(width: currentStep>=5 ?  geometry.size.width * 0.15 : geometry.size.width * 0.25, height: geometry.size.height * 0.06)
                                    .font(Font.custom("Noteworthy-Bold", size: currentStep >= 5 ? geometry.size.width * 0.03 : geometry.size.width * 0.05))
                                    .background(Color.blue)
                                    .alignmentGuide(.top) { d in d[.top] } // Alineación superior
                                Rectangle()
                                    .frame(width: currentStep>=5 ?  geometry.size.width * 0.15 : geometry.size.width * 0.25, height: geometry.size.height * 0.01)
                                VStack(spacing: 120) {
                                    Spacer().frame(height: geometry.size.height * 0.001)
                                    
                                    Image("Post_it 7")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:currentStep>=5 ?  geometry.size.width * 0.1 : geometry.size.width * 0.15)
                                        .rotationEffect(.degrees(10)) // Rotar 10 grados
                                        .overlay(
                                            showLetters ?
                                            Text("Need to be started")
                                                .font(Font.custom("HoeflerText-BlackItalic", size: geometry.size.width * 0.0159))
                                                .fontWeight(.bold)
                                                .rotationEffect(.degrees(10)) // Rotar 10 grados
                                                .foregroundColor(Color(hex: "#91867D"))
                                                .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.05)
                                                .padding()
                                            : nil,
                                            alignment: .center // Controla la alineación
                                        )
                                    
                                    Image("Post_it 4")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.1)
                                        .rotationEffect(.degrees(-10)) // Rotar -10 grados
                                        .opacity (currentStep == 8 ? 1 : 0)
                                }
                            }
                            .frame(width: currentStep>=5 ? geometry.size.width * 0.15 : geometry.size.width * 0.25,height: geometry.size.height * 0.5, alignment: .top)
                            .background(Color.brown)// Asegura que la alineación sea superior
                            .scaleEffect(currentStep == 2 ? 1.2 : 1.0) // Scale up when currentStep is 2
                            .zIndex(currentStep == 2 ? 1 : 0) // Bring this button to the front when scaled
                            .animation(.easeInOut(duration: 1), value: currentStep) // Smooth animation
                            
                            
                            Rectangle()
                                .frame(width: geometry.size.width * 0.01, height: geometry.size.height * 0.5) // Separador vertical
                                .opacity(currentStep == 2 ? 0 : 1.0) // Cambia opacidad
                                .animation(nil, value: currentStep) // Deshabilita la animación para esta propiedad
                            
                            
                            VStack( spacing: 0) {
                                Text("In progress")
                                    .frame(width: currentStep>=5 ?  geometry.size.width * 0.15 : geometry.size.width * 0.25, height: geometry.size.height * 0.06)
                                    .font(Font.custom("Noteworthy-Bold", size: currentStep >= 5 ? geometry.size.width * 0.03 : geometry.size.width * 0.05))
                                    .background(Color.orange)
                                    .alignmentGuide(.top) { d in d[.top] } // Alineación superior
                                Rectangle()
                                    .frame(width: currentStep>=5 ?  geometry.size.width * 0.15 : geometry.size.width * 0.25, height: geometry.size.height * 0.01)
                                VStack(spacing: 50) {
                                    Spacer().frame(height: geometry.size.height * 0.001)
                                    
                                    Image("Post_it 1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:currentStep>=5 ?  geometry.size.width * 0.1 : geometry.size.width * 0.15)
                                        .rotationEffect(.degrees(10)) // Rotar 10 grados
                                        .overlay(
                                            showLetters ?
                                            Text("Currently")
                                                .font(Font.custom("HoeflerText-BlackItalic", size: geometry.size.width * 0.017))
                                                .fontWeight(.bold)
                                                .rotationEffect(.degrees(10)) // Rotar 10 grados
                                                .foregroundColor(Color(hex: "#1C8C76"))
                                                .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.05)
                                                .padding()
                                            : nil,
                                            alignment: .center // Controla la alineación
                                        )
                                    
                                    Image("Post_it 8")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:currentStep>=5 ?  geometry.size.width * 0.1 : geometry.size.width * 0.15)
                                        .rotationEffect(.degrees(-10)) // Rotar -10 grados
                                        .overlay(
                                            showLetters ?
                                            Text("Being worked on")
                                                .font(Font.custom("HoeflerText-BlackItalic", size: geometry.size.width * 0.017))
                                                .fontWeight(.bold)
                                                .rotationEffect(.degrees(-10)) // Rotar -10 grados
                                                .foregroundColor(Color(hex: "#DCFF70"))
                                                .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.05)
                                                .padding()
                                            : nil,
                                            alignment: .center // Controla la alineación
                                        )
                                    Image("Post_it 4")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.1)
                                        .rotationEffect(.degrees(-10)) // Rotar -10 grados
                                        .opacity ((currentStep == 9 || currentStep == 11) ? 1 : 0)
                                }
                            }
                            
                            .frame(width: currentStep>=5 ? geometry.size.width * 0.15 : geometry.size.width * 0.25,height: geometry.size.height * 0.5, alignment: .top)
                            .background(Color.brown)// Asegura que la alineación sea superior
                            .scaleEffect(currentStep == 3 ? 1.2 : 1.0) // Scale up when currentStep is 2
                            .zIndex(currentStep == 3 ? 1 : 0) // Bring this button to the front when scaled
                            .animation(.easeInOut(duration: 1), value: currentStep) // Smooth animation
                            
                            Rectangle()
                                .frame(width: geometry.size.width * 0.01, height: geometry.size.height * 0.5) // Separador vertical
                                .opacity(currentStep == 3 ? 0 : 1.0) // Cambia opacidad
                                .animation(nil, value: currentStep) // Deshabilita la animación para esta propiedad
                            
                            if (currentStep >= 5){
                                VStack( spacing: 0) {
                                    Text("On review")
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                        .font(Font.custom("Noteworthy-Bold", size: currentStep >= 5 ? geometry.size.width * 0.03 : geometry.size.width * 0.05))
                                        .background(Color.yellow)
                                        .alignmentGuide(.top) { d in d[.top] } // Alineación superior
                                    Rectangle()
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.01)
                                    VStack(spacing: 70) {
                                        Spacer().frame(height: geometry.size.height * 0.001)
                                        
                                        Image("Post_it 5")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.1)
                                            .rotationEffect(.degrees(20)) // Rotar 20 grados
                                            .overlay(
                                                showLetters ?
                                                Text("Waiting for")
                                                    .font(Font.custom("HoeflerText-BlackItalic", size: geometry.size.width * 0.02))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color(hex: "82FF89"))
                                                    .rotationEffect(.degrees(20)) // Rotar 20 grados
                                                    .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.05)
                                                    .padding()
                                                : nil,
                                                alignment: .center // Controla la alineación
                                            )
                                        
                                        Image("Post_it 2")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.1)
                                            .overlay(
                                                showLetters ?
                                                Text("Feedback")
                                                    .font(Font.custom("HoeflerText-BlackItalic", size: geometry.size.width * 0.017))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.red)
                                                    .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.05)
                                                    .padding()
                                                : nil,
                                                alignment: .center // Controla la alineación
                                            )
                                        Image("Post_it 4")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.1)
                                            .rotationEffect(.degrees(-10)) // Rotar -10 grados
                                            .opacity (currentStep == 10 ? 1 : 0)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.15,height: geometry.size.height * 0.5, alignment: .top)
                                .background(Color.brown)// Asegura que la alineación sea superior
                                .scaleEffect(currentStep == 6 ? 1.2 : 1.0) // Scale up when currentStep is 2
                                .zIndex(currentStep == 6 ? 1 : 0) // Bring this button to the front when scaled
                                .animation(.easeInOut(duration: 1), value: currentStep) // Smooth animation
                                Rectangle()
                                    .frame(width: geometry.size.width * 0.01, height: geometry.size.height * 0.5) // Separador vertical
                                    .opacity(currentStep == 6 ? 0 : 1.0) // Cambia opacidad
                                    .animation(nil, value: currentStep) // Deshabilita la animación para esta propiedad
                                
                                
                                VStack( spacing: 0) {
                                    Text("Approved")
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                        .font(Font.custom("Noteworthy-Bold", size: currentStep >= 5 ? geometry.size.width * 0.03 : geometry.size.width * 0.05))
                                        .background(Color (hex: "19E2C0"))
                                        .alignmentGuide(.top) { d in d[.top] } // Alineación superior
                                    Rectangle()
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.01)
                                    VStack(spacing: 100) {
                                        Image("Post_it 6")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.1)
                                            .rotationEffect(.degrees(10)) // Rotar 45 grados
                                            .overlay(
                                                showLetters ?
                                                Text("Ready for")
                                                    .font(Font.custom("HoeflerText-BlackItalic", size: geometry.size.width * 0.018))
                                                    .fontWeight(.bold)
                                                    .rotationEffect(.degrees(10)) // Rotar 45 grados
                                                    .foregroundColor(Color(hex: "960C00"))
                                                    .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.05)
                                                    .padding()
                                                : nil,
                                                alignment: .center // Controla la alineación
                                            )
                                        
                                        Image("Post_it 9")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.1)
                                            .rotationEffect(.degrees(-10)) // Rotar 45 grados
                                            .overlay(
                                                showLetters ?
                                                Text("Deployment")
                                                    .font(Font.custom("HoeflerText-BlackItalic", size: geometry.size.width * 0.016))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color(hex: "FFE787"))
                                                    .frame(width: geometry.size.width * 0.13, height: geometry.size.height * 0.05)
                                                    .rotationEffect(.degrees(-10)) // Rotar 45 grados
                                                    .padding()
                                                : nil,
                                                alignment: .center // Controla la alineación
                                            )
                                        Image("Post_it 4")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.1)
                                            .rotationEffect(.degrees(-10)) // Rotar -10 grados
                                            .opacity (currentStep == 12 ? 1 : 0)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.15,height: geometry.size.height * 0.5, alignment: .top)
                                .background(Color.brown)// Asegura que la alineación sea superior
                                .scaleEffect(currentStep == 7 ? 1.2 : 1.0) // Scale up when currentStep is 2
                                .zIndex(currentStep == 7 ? 1 : 0) // Bring this button to the front when scaled
                                .animation(.easeInOut(duration: 1), value: currentStep) // Smooth animation
                                
                                
                                
                                
                                Rectangle()
                                    .frame(width: geometry.size.width * 0.01, height: geometry.size.height * 0.5) // Separador vertical
                                    .opacity(currentStep == 7 ? 0 : 1.0) // Cambia opacidad
                                    .animation(nil, value: currentStep) // Deshabilita la animación para esta propiedad
                            }
                            
                            VStack( spacing: 0) {
                                Text("Done")
                                    .frame(width: currentStep>=5 ?  geometry.size.width * 0.15 : geometry.size.width * 0.25, height: geometry.size.height * 0.06)
                                    .font(Font.custom("Noteworthy-Bold", size: currentStep >= 5 ? geometry.size.width * 0.03 : geometry.size.width * 0.05))
                                    .background(Color.green)
                                    .alignmentGuide(.top) { d in d[.top] } // Alineación superior
                                Rectangle()
                                    .frame(width: currentStep>=5 ?  geometry.size.width * 0.15 : geometry.size.width * 0.25, height: geometry.size.height * 0.01)
                                VStack(spacing: 50) {
                                    Spacer().frame(height: geometry.size.height * 0.001)
                                    Image("Post_it 3")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:currentStep>=5 ?  geometry.size.width * 0.1 : geometry.size.width * 0.15)
                                        .overlay(
                                            showLetters ?
                                            Text("Completed")
                                                .font(Font.custom("HoeflerText-BlackItalic", size: geometry.size.width * 0.017))
                                                .fontWeight(.bold)
                                                .foregroundColor(.red)
                                                .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.05)
                                                .padding()
                                            : nil,
                                            alignment: .center // Controla la alineación
                                        )
                                    Image("Post_it 4")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.1)
                                        .rotationEffect(.degrees(-10)) // Rotate -10 degrees
                                        .opacity(currentStep == 13 ? 1 : 0) // Show only when currentStep == 13
                                        .overlay(
                                            currentStep == 13 ?
                                            Image(systemName: "checkmark.circle.fill") // Add a checkmark overlay
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.05) // Size of the checkmark
                                                .foregroundColor(.green)
                                                .offset(x: geometry.size.width * 0.03, y: -geometry.size.width * 0.03) // Positioning
                                            : nil // No overlay otherwise
                                        )
                                        .animation(.easeInOut(duration: 1), value: currentStep) // Smooth transition
                                }
                            }
                            .frame(width: currentStep>=5 ? geometry.size.width * 0.15 : geometry.size.width * 0.25,height: geometry.size.height * 0.5, alignment: .top)
                            .background(Color.brown)// Asegura que la alineación sea superior
                            .scaleEffect(currentStep == 4 ? 1.2 : 1.0) // Scale up when currentStep is 2
                            .zIndex(currentStep == 4 ? 1 : 0) // Bring this button to the front when scaled
                            .animation(.easeInOut(duration: 1), value: currentStep) // Smooth animation
                            
                            
                            
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Asegura alineación global superior
                        .padding(.top, geometry.size.height * 0.05) // Opcional: separa todo del borde superior
                    }
                }
                .padding()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height*0.95, alignment: .center) // Alinea al tope
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                        .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Asegura que todo esté alineado arriba
                .onTapGesture {
                    print ("Helllo")
                    if currentStep < maxSteps {
                        withAnimation(.easeInOut(duration: 1)) {
                            currentStep += 1
                            print("Current step: \(currentStep)")
                        }
                    }
                    if (currentStep==maxSteps){
                        withAnimation(.easeInOut(duration: 1.5)) {
                            showLetters = true
                        }
                    }
                }
                .onChange(of: currentStep) { newValue in
                    if (currentStep == 14 && !progressModel.star2CompleteOrga){
                        progressModel.star2CompleteOrga = true // Actualiza el estado
                                      
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
                VStack (alignment: .leading) {
                    
                    Spacer().frame(height: geometry.size.height * 0.8) // Altura dinámica del primer Spacer
                    if(currentStep>1){
                        switch currentStep {
                        case 2: Text("In this stage, tasks are identified, prioritized, and prepared for work.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.5, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 3: Text("In this stage, tasks are actively being worked on by the team or individual.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 4: Text("In this stage, tasks are fully completed and require no further action.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 5: Text("In some cases the Kanban Method use 5 stages when tasks must go through a formal review or testing phase before approval, such as in software development, content editing, or manufacturing.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.85, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 6: Text("In this stage, tasks are completed but need validation, testing, or approval.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                            
                        case 7: Text("In this stage, tasks are fully completed and require no further action.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 8:Text("A task starts in the “To Do” stage, where it is identified and prioritized.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 9:Text("When work begins, the task is dragged or moved into the “In Progress” column.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 10:Text("Tasks that are completed but need to be reviewed for quality, correctness, or approval")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 11:Text("Tasks that fail validation or require further adjustments are returned to the previous stage")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 12:Text("If the task passes the review stage (quality assurance, feedback, etc.), it moves to “Approved.”")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.5, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        case 13:Text("Finally after final validation and approval, the task moves to the “Done” stage.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.09)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(20)
                            
                        default: Text("")
                        }
                        
                        
                    }
                    
                }
                VStack(spacing: 15) {
                    Image("StarOrga")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80) // Tamaño de la imagen
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // Sombra sutil

                    Text("You've just earned a Organization Star!")
                        .font(.headline) // Fuente llamativa pero profesional
                        .multilineTextAlignment(.center) // Alineación centrada
                        .foregroundColor(Color.white) // Texto en blanco
                        .padding(.horizontal, 20) // Espaciado interno para que el texto no esté pegado a los bordes
                }
                
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.purple.opacity(0.9)) // Fondo azul semi-transparente
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
    KanbanView()
}

