//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 17/01/25.
//

import SwiftUI

struct IvyLeeView: View {
    @State private var progress: CGFloat = 0.0 // Estado inicial del progreso
    @State private var frameIndex = 0 // Índice actual de la imagen
        private let totalFrames = 44 //1,10,20,25
    @State private var completed = false
    private let animationDuration = 4.0 // Duración de la animación en segundos
    @State private var showDetails = false
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    private let repeatInterval = 3.0 // Intervalo entre repeticiones en segundos
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla

    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
                
                VStack{
                    Text("Ivy Lee ")
                        .font(Font.custom("Noteworthy-Bold", size: geometry.size.width * 0.1)) // Fuente personalizada y tamaño dinámico
                        .padding(.top, geometry.size.height * 0.02)
                    if (!showDetails){
                        
                        Text("""
                        The Ivy Lee Method is a simple productivity strategy where you prioritize six tasks at the end of each day, focus on completing them one at a time in order of importance, and carry over unfinished tasks to the next day for consistent progress.
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
                    }else{
                        
                        
                        ZStack (alignment: .top){
                            Image("Flecha_\(String(format: "%05d", frameIndex))")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(2.5)
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                                .onAppear {
                                    Task {
                                        await startRepeatingAnimation()
                                    }
                                }
                            VStack{
                                Spacer()
                                    .frame(height: geometry.size.height * 0.03)
                                Text("""
At the end of your day,
 identify the six
most important tasks 
to work on the next day.
""")
                                .padding()
                                .background(Color (hex: "F6A622"))
                                .foregroundStyle(Color.white)
                                .font(.system(size: geometry.size.width * 0.02))
                                .cornerRadius(15)
                                .scaleEffect(completed ? 1.2 : 1.0)
                                Spacer()
                                    .frame(height: geometry.size.height * 0.08)
                                HStack{
                                    Text("""
    Reflect on your productivity at the end 
    of the day and prepare 
    your next prioritized list.
    """)
                                    .padding()
                                    .background(Color (hex: "7C70EC"))
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .foregroundStyle(Color.white)
                                    .cornerRadius(15)
                                    .scaleEffect(frameIndex>25 ? 1.2 : 1.0)
                                    Spacer()
                                        .frame(width: geometry.size.width * 0.35)
                                    Text("""
    Rank the six tasks in order of importance, 
    placing the most critical task at the top.
    """)
                                    .padding()
                                    .background(Color (hex:"352D60"))
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .foregroundStyle(Color.white)
                                    .cornerRadius(15)
                                    .scaleEffect(frameIndex>1 ? 1.2 : 1.0)
                                    
                                }
                                Spacer()
                                    .frame(height: geometry.size.height * 0.06)
                                HStack{
                                    Text("""
    At the end of the day, 
    move any unfinished tasks 
    to the next day’s list, ensuring the 
    total remains six.
    """)
                                    .padding()
                                    .background(Color (hex: "FF585A"))
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .cornerRadius(15)
                                    .scaleEffect(frameIndex>20 ? 1.2 : 1.0)
                                    Spacer()
                                        .frame(width: geometry.size.width * 0.25)
                                    Text("""
    Begin your next day by working on the first task.
    Only move to the next task when the current one is complete.
    """)
                                    .padding()
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .background(Color (hex: "10E4C7"))
                                    .cornerRadius(15)
                                    .scaleEffect(frameIndex>10 ? 1.2 : 1.0)
                                    
                                }
                            }
                            
                        }
                    }
                }
                .padding()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height*0.95, alignment: .center) // Alinea al tope
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                        .resizable()
                )
                .cornerRadius(15)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) { // Animación lenta al ocultar descripción
                        showDetails = true
                        
                    }
                }
                .onChange(of: completed) { newValue in
                    if (completed && !progressModel.star4CompleteOrga){
                        progressModel.star4CompleteOrga = true // Actualiza el estado
                                      
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
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Asegura que todo esté alineado arriba
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
    
    
    
    
    
    private func startRepeatingAnimation() async {
        while true {
            completed = false // Marca como no completado al iniciar cada ciclo de animación
            await startAnimation() // Ejecuta la animación individual
            completed = true // Marca como completado cuando la animación ha finalizado
            try? await Task.sleep(nanoseconds: UInt64(repeatInterval * 1_000_000_000)) // Espera el intervalo antes de repetir
        }
    }

    private func startAnimation() async {
        for frame in 0..<totalFrames {
            await MainActor.run {
                frameIndex = frame // Actualiza el índice de la imagen en el hilo principal
            }
            try? await Task.sleep(nanoseconds: UInt64((animationDuration / Double(totalFrames)) * 1_000_000_000)) // Pausa entre frames
        }
    }
  
}

#Preview {
    IvyLeeView()
}
