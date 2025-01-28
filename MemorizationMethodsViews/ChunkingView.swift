//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 09/01/25.
//

import SwiftUI

struct ChunkingView: View {
    @State private var currentFrame: Int = 0 // Cuadro actual
    @State private var nextStep = true;
       @State private var timer: Timer? // Temporizador
    @State private var spacing: CGFloat = 0 // Espaciado inicial entre los elementos
       private let frameDuration: TimeInterval = 0.1 // Duración entre cuadros
       private let totalFrames: Int = 10 // Total de cuadros de la animación
    @State private var currentStep: Int = 1
    @State private var showNumbers1: Bool = false // Controla si se muestran los números
    @State private var showNumbers2: Bool = false
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @State private var showStrokes: Bool = false
    @EnvironmentObject var progressModel: StarProgressModel // Usa el mismo ViewModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
                
                VStack(spacing: geometry.size.height * 0.05) {
                    Text("Chunking")
                        .font(Font.custom("MarkerFelt-Thin", size: geometry.size.width * 0.2)) // Fuente ChalkboardSE
                        .padding(.top, geometry.size.height * 0.07)
                    if (currentStep>1){
                        
                        if (currentStep>=2){
                            
                            Image("Contacts")
                                .resizable()
                                .scaledToFit()
                                .frame(width: currentStep == 2 ? geometry.size.width * 0.5 : geometry.size.width * 0.25)
                                .onAppear {
                                    // Retrasa la aparición de los números por 1 segundo
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation {
                                            showNumbers1 = true
                                        }
                                    }
                                }
                            if showNumbers1 {
                                Text("149217761941")
                                    .font(Font.custom("MarkerFelt-Thin", size: currentStep == 2 ? geometry.size.width * 0.07 : geometry.size.width * 0.05)) // Fuente personalizada
                                    .foregroundColor(.white) // Color del texto
                                    .padding() // Espaciado interno
                                    .background(
                                        RoundedRectangle(cornerRadius: 15) // Fondo con bordes redondeados
                                            .fill(Color(hex: "1C6E14")) // Color verde apagado con transparencia
                                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Sombra para mayor estética
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.white, lineWidth: 2) // Borde blanco del contenedor
                                    )
                                    .padding(.horizontal, geometry.size.width * 0.05) // Espaciado horizontal
                                    .transition(.scale) // Transición de escala
                            }
                        }
                        if (currentStep>=3){
                            Image(String(format: "Rompecabezas 2_%05d", currentFrame + 1)) // Nombres como Rompecabezas_00001
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(currentStep==3 ? 2.5 : 2)
                                .frame(width: geometry.size.width * 0.5,height: geometry.size.height * 0.1) // Ajusta el tamaño según necesidad
                                .onAppear {
                                    startAnimation() // Inicia la animación al cargar la vista
                                }
                            if (showNumbers2){
                                
                                HStack(spacing: spacing) {
                                    Text("149")
                                        .font(Font.custom("MarkerFelt-Thin", size: currentStep == 3 ? geometry.size.width * 0.07 : geometry.size.width * 0.05)) // Fuente personalizada
                                        .foregroundColor(showStrokes ? Color(hex: "527E0E") : Color.white) // Cambia el color del texto
                                        .padding() // Espaciado interno
                                        .background(
                                            RoundedRectangle(cornerRadius: 15) // Fondo con bordes redondeados
                                                .fill(showStrokes ? Color.green : Color(hex: "1C6E14"))
                                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Sombra para mayor estética
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: showStrokes ? 2 : 0 ) // Borde blanco del contenedor
                                        )
                                    Text("217")
                                        .font(Font.custom("MarkerFelt-Thin", size: currentStep == 3 ? geometry.size.width * 0.07 : geometry.size.width * 0.05)) // Fuente personalizada
                                        .foregroundColor(showStrokes ? Color(hex: "6C95A9") : Color.white) // Cambia el color del texto
                                        .padding() // Espaciado interno
                                        .background(
                                            RoundedRectangle(cornerRadius: 15) // Fondo con bordes redondeados
                                                .fill(showStrokes ? Color.green : Color(hex: "1C6E14"))
                                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Sombra para mayor estética
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: showStrokes ? 2 : 0 ) // Borde blanco del contenedor
                                        )
                                    Text("761")
                                        .font(Font.custom("MarkerFelt-Thin", size: currentStep == 3 ? geometry.size.width * 0.07 : geometry.size.width * 0.05)) // Fuente personalizada
                                        .foregroundColor(showStrokes ? Color(hex: "E72A71") : Color.white) // Cambia el color del texto
                                        .padding() // Espaciado interno
                                        .background(
                                            RoundedRectangle(cornerRadius: 15) // Fondo con bordes redondeados
                                                .fill(showStrokes ? Color.green : Color(hex: "1C6E14"))
                                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Sombra para mayor estética
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: showStrokes ? 2 : 0 ) // Borde blanco del contenedor
                                        )
                                    Text("941")
                                        .font(Font.custom("MarkerFelt-Thin", size: currentStep == 3 ? geometry.size.width * 0.07 : geometry.size.width * 0.05)) // Fuente personalizada
                                        .foregroundColor(showStrokes ? Color(hex: "F5872A") : Color.white) // Cambia el color del texto
                                        .padding() // Espaciado interno
                                        .background(
                                            RoundedRectangle(cornerRadius: 15) // Fondo con bordes redondeados
                                                .fill(showStrokes ? Color.green : Color(hex: "1C6E14"))
                                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Sombra para mayor estética
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: showStrokes ? 2 : 0 ) // Borde blanco del contenedor
                                        )
                                }
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 4.0)) {
                                        spacing = geometry.size.width * 0.02 // Cambia el espaciado después de la animación
                                        showStrokes = true
                                    }
                                }
                            }
                        }
                    }
                    else{
                        Text("""
           Chunking is a memory and learning technique that involves breaking down large amounts of information into smaller, manageable units or “chunks.” 
           
           This method leverages the brain’s natural ability to group related items, making it easier to process, understand, and recall complex information.
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
                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95) // Ajusta dimensiones
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                                       .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height)
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
                       
                .onTapGesture {
                    if nextStep {
                        nextStep = false
                        withAnimation(.easeInOut(duration: 1)) {
                            currentStep += 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Duración de la animación
                            nextStep = true
                        }
                    }
                }
                .onChange(of: currentStep) { newValue in
                    if (newValue == 5 && !progressModel.star1CompleteMemo){
                        progressModel.star1CompleteMemo = true // Actualiza el estado
                  
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
                if (currentStep==2){
                    
                    HStack{
                                           
                                            Text("    Take the material you need to remember, such as a list, concept, or set of numbers. ")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(20)
                                                .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.15)
                                        }
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8 , alignment: .topTrailing)
                                       // .background(Color.blue)
                                        .cornerRadius(20)
                }
                
                Spacer().frame(height: geometry.size.height * 0.02)
                HStack{
                    if (currentStep==3){
                        Text("  Divide the information into smaller, logical groups based on patterns, categories, or connections. ")
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
                        Text("     Practice remembering one chunk at a time before moving on to the next. Gradually connect the chunks together.  ")
                            .multilineTextAlignment(.center)
                            .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(20)
                            .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.4)
                    }
                }
                VStack(spacing: 15) {
                    Image("StarMemo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80) // Tamaño de la imagen
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // Sombra sutil

                    Text("You've just earned a Memorization Star!")
                        .font(.headline) // Fuente llamativa pero profesional
                        .multilineTextAlignment(.center) // Alineación centrada
                        .foregroundColor(Color.white) // Texto en blanco
                        .padding(.horizontal, 20) // Espaciado interno para que el texto no esté pegado a los bordes
                }
                
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.yellow.opacity(0.9)) // Fondo azul semi-transparente
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
    }
    private func startAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
             DispatchQueue.main.async {
                 if currentFrame < totalFrames - 1 {
                     currentFrame += 1 // Avanza al siguiente cuadro
                 } else {
                     timer?.invalidate() // Detiene la animación al llegar al último cuadro
                     withAnimation(.easeInOut(duration: 1)) {
                                            showNumbers2 = true // Muestra el HStack
                                        }
                 }
             }
            
         }
     }
    
}
#Preview {
    ChunkingView()
        .environmentObject(StarProgressModel()) // Agrega este método
}

