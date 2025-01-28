//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 07/01/25.
//

import SwiftUI

struct SQ3RView: View {
    @State private var currentStep: Int = 1
    @State private var NextStep: Bool = true
    @State private var showStepText1: Bool = true // Controla si se muestra el texto del paso
    @State private var showStepText2: Bool = true
    @State private var showStepText3: Bool = true
    @State private var showStepText4: Bool = true
    @State private var showStepText5: Bool = true
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla

    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
                
                VStack(spacing: geometry.size.height * 0.025) {
                    
                    Text("SQ3R")
                        .font(Font.custom("COPPERPLATE-Bold", size: geometry.size.width * 0.15)) // Fuente ChalkboardSE
                        .padding(.top, geometry.size.height * 0.07)
                    if (currentStep==1){
                        Text("""
                           The SQ3R Method is a structured study technique designed to enhance comprehension and retention of written material.
                           
                           It stands for Survey, Question, Read, Recite, and Review, providing a step-by-step approach to actively engage with the content.
                           """)
                        .font(.system(size: geometry.size.width * 0.05)) // Tamaño dinámico
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
                    
                    else{
                        
                        
                        VStack(alignment: .leading, spacing: geometry.size.height * 0.05) {
                            
                            VStack( alignment:.leading,spacing: geometry.size.height * 0.04) {
                                if showStepText1 {
                                    Text("Step \(currentStep-1)") // Muestra el texto del paso
                                        .font(.system(size: geometry.size.width * 0.05))
                                        .fontWeight(.bold)
                                        .transition(.opacity) // Añade una transición suave
                                } else {
                                    // HStack que se muestra después de "Step"
                                    HStack(alignment: .top, spacing: geometry.size.height * 0.04) {
                                        if currentStep >= 2 {
                                            Image("Looking")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.1)
                                                .padding()
                                            Text(" Before reading the text in detail, conduct a quick survey. Look at headings, subheadings, images, bolded words, and summaries to get an overview of the content.")
                                                .font(.system(size: geometry.size.width * 0.025))
                                        }
                                    }
                                    .transition(.opacity) // Transición suave entre elementos
                                }
                            }
                            .frame(width: geometry.size.width * 0.9)
                            
                            .onAppear {
                                // Alternar entre "Step X" y el contenido después de un retraso
                                withAnimation(.easeInOut(duration: 1)) {
                                    NextStep = false
                                    showStepText1 = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Espera 2 segundos
                                    withAnimation(.easeInOut(duration: 1)) {
                                        showStepText1 = false
                                        NextStep = true
                                    }
                                }
                            }
                            if (currentStep>=3){
                                VStack(spacing: geometry.size.height * 0.04) {
                                    if showStepText2 {
                                        Text("Step \(currentStep-1)") // Muestra el texto del paso
                                            .font(.system(size: geometry.size.width * 0.05))
                                            .fontWeight(.bold)
                                            .transition(.opacity) // Añade una transición suave
                                    } else {
                                        // HStack que se muestra después de "Step"
                                        HStack(alignment: .center , spacing: geometry.size.height * 0.04) {
                                            if currentStep >= 3 {
                                                Image("Ask")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width * 0.1)
                                                    .padding()
                                                Text(" Turn the titles into questions")
                                                    .font(.system(size: geometry.size.width * 0.03))
                                            }
                                        }
                                        
                                        .transition(.opacity) // Transición suave entre elementos
                                    }
                                }
                                .frame(width: geometry.size.width * 0.9, alignment: showStepText2 ? .center : .leading )
                                
                                .onAppear {
                                    // Alternar entre "Step X" y el contenido después de un retraso
                                    withAnimation(.easeInOut(duration: 1)) {
                                        showStepText2 = true
                                        NextStep = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Espera 2 segundos
                                        withAnimation(.easeInOut(duration: 1)) {
                                            showStepText2 = false
                                            NextStep = true
                                        }
                                    }
                                }
                            }
                            
                            if (currentStep>=4){
                                VStack(spacing: geometry.size.height * 0.04) {
                                    if showStepText3 {
                                        Text("Step \(currentStep-1)") // Muestra el texto del paso
                                            .font(.system(size: geometry.size.width * 0.05))
                                            .fontWeight(.bold)
                                            .transition(.opacity) // Añade una transición suave
                                    } else {
                                        // HStack que se muestra después de "Step"
                                        HStack(alignment: .top, spacing: geometry.size.height * 0.04) {
                                            if currentStep >= 4 {
                                                Image("Read")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width * 0.1)
                                                    .padding()
                                                Text(" Read the text actively to find answers to those questions.")
                                                    .font(.system(size: geometry.size.width * 0.03))
                                            }
                                        }
                                        .transition(.opacity) // Transición suave entre elementos
                                    }
                                }
                                .frame(width: geometry.size.width * 0.9, alignment: showStepText3 ? .center : .leading )
                                
                                .onAppear {
                                    // Alternar entre "Step X" y el contenido después de un retraso
                                    withAnimation(.easeInOut(duration: 1)) {
                                        showStepText3 = true
                                        NextStep = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Espera 2 segundos
                                        withAnimation(.easeInOut(duration: 1)) {
                                            showStepText3 = false
                                            NextStep = true
                                        }
                                    }
                                }
                            }
                            
                            
                            if (currentStep>=5){
                                VStack(spacing: geometry.size.height * 0.04) {
                                    if showStepText4 {
                                        Text("Step \(currentStep-1)") // Muestra el texto del paso
                                            .font(.system(size: geometry.size.width * 0.05))
                                            .fontWeight(.bold)
                                            .transition(.opacity) // Añade una transición suave
                                    } else {
                                        // HStack que se muestra después de "Step"
                                        HStack(alignment: .top, spacing: geometry.size.height * 0.04) {
                                            if currentStep >= 5 {
                                                Image("Recall")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width * 0.1)
                                                    .padding()
                                                Text(" Close the book and try to recall the key ideas in your own words.")
                                                    .font(.system(size: geometry.size.width * 0.03))
                                            }
                                        }
                                        .transition(.opacity) // Transición suave entre elementos
                                    }
                                }
                                .frame(width: geometry.size.width * 0.9, alignment: showStepText4 ? .center : .leading )
                                
                                .onAppear {
                                    // Alternar entre "Step X" y el contenido después de un retraso
                                    withAnimation(.easeInOut(duration: 1)) {
                                        showStepText4 = true
                                        NextStep = false
                                        
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Espera 2 segundos
                                        withAnimation(.easeInOut(duration: 1)) {
                                            showStepText4 = false
                                            NextStep = true
                                            
                                        }
                                    }
                                }
                            }
                            
                            if (currentStep>=6){
                                VStack(spacing: geometry.size.height * 0.04) {
                                    if showStepText5 {
                                        Text("Step \(currentStep-1)") // Muestra el texto del paso
                                            .font(.system(size: geometry.size.width * 0.05))
                                            .fontWeight(.bold)
                                            .transition(.opacity) // Añade una transición suave
                                    } else {
                                        // HStack que se muestra después de "Step"
                                        HStack(alignment: .top, spacing: geometry.size.height * 0.04) {
                                            if currentStep >= 6 {
                                                Image("Go over")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width * 0.1)
                                                    .padding()
                                                Text("Go over your notes to verify your answers and understand any concepts you might have missed.")
                                                    .font(.system(size: geometry.size.width * 0.03))
                                            }
                                        }
                                        .transition(.opacity) // Transición suave entre elementos
                                    }
                                }
                                .frame(width: geometry.size.width * 0.9, alignment: showStepText5 ? .center : .leading )
                                
                                .onAppear {
                                    // Alternar entre "Step X" y el contenido después de un retraso
                                    withAnimation(.easeInOut(duration: 1)) {
                                        showStepText5 = true
                                        NextStep = false
                                        
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Espera 2 segundos
                                        withAnimation(.easeInOut(duration: 1)) {
                                            showStepText5 = false
                                            NextStep = true
                                            
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        
                        .frame(width: geometry.size.width * 0.9, alignment: .leading) // Alinea todo a la izquierda
                        
                    }
                }
                .padding()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.95, alignment: .center) // Alinea al tope
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                        .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Asegura que todo esté alineado arriba
                .onTapGesture {
                    if (NextStep){
                        withAnimation(.easeInOut(duration: 1)) { // Animación lenta al ocultar descripción
                            currentStep+=1
                        }
                    }
                    
                    
                }
                .onChange(of: currentStep) { newValue in
                    if (newValue == 6 && !progressModel.star3CompleteStudy){
                        progressModel.star3CompleteStudy = true // Actualiza el estado
                  
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
    }
}
#Preview {
    SQ3RView()
}
