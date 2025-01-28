//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 06/01/25.
//

import SwiftUI

struct CornelView: View {
    @State private var currentStep = 1;
    @State private var totalSteps = 5
    @State private var isAnimating1 = false
    @State private var isAnimating2 = false
    @State private var isAnimating3 = false
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack(spacing: geometry.size.height * 0.05) {
                        Text("Cornel")
                                               .font(Font.custom("Chalkduster", size: geometry.size.width * 0.2)) // Fuente ChalkboardSE
                                               .padding(.top, geometry.size.height * 0.02)
                    if (currentStep>1){
                                           Image("Cornel1")
                                               .resizable()
                                               .scaledToFit()
                                               .frame(width: geometry.size.height * 0.5)
                                               //.opacity(0.6)
                                             
                                         
                    }
                   
                    //.disabled(currentStep <= totalSteps)
                    else {
                        Text("""
                        The Cornell Note-Taking Method is a structured system that divides a page into three sections.
                        This method promotes active learning by encouraging users to organize, summarize, and review material effectively, making it ideal for studying, recalling key concepts, and preparing for exams.

                        """)  .font(.system(size: geometry.size.width * 0.04)) // Tamaño dinámico
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
                .padding()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height*0.95, alignment: .center) // Alinea al tope
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                                       .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Asegura que todo esté alineado arriba
                VStack {
                    Spacer()
                        .frame(height: geometry.size.height * 0.32)
                    HStack(spacing: 0){
                        if (currentStep>=2){
                            
                            VStack {
                                            if currentStep > 2 {
                                                Spacer().frame(height: geometry.size.height * 0.01)
                                                Text("Ideas").font(.system(size: geometry.size.width * 0.07).bold()).foregroundStyle(Color.black)
                                                Spacer().frame(height: geometry.size.height * 0.025)
                                                Text("Keywords").italic().foregroundStyle(Color.black)
                                                Spacer().frame(height: geometry.size.height * 0.025)
                                                Text("Curiosities").italic().foregroundStyle(Color.black)
                                                Spacer().frame(height: geometry.size.height * 0.05)
                                                Text("After the lecture").foregroundStyle(Color.blue)
                                            }
                                        }
                                        .frame(width: geometry.size.width * 0.26, height: geometry.size.width * 0.45)
                
                                        .background(
                                            Color.white.opacity(
                                                currentStep > 2
                                                    ? 0.5 // Opacidad fija cuando `currentStep > 2`
                                                    : (isAnimating1 ? 0.75 : 0.5) // Alterna opacidad si `currentStep <= 2`
                                            )
                                        )
                                        .cornerRadius(20)

                                        .shadow(
                                            color: .black.opacity(currentStep > 2 ? 0 : 0.6), // Elimina la sombra si `currentStep > 2`
                                            radius: currentStep > 2 ? 0 : 10,
                                            x: 0,
                                            y: currentStep > 2 ? 0 : 5
                                        )
                                        .onAppear {
                                            if currentStep <= 2 {
                                                startBlinking1()
                                            }
                                        }
                        }
                        Spacer().frame(width: geometry.size.width * 0.04)
                        if (currentStep>=3){
                            VStack {
                                            if currentStep > 3 {
                                                Spacer().frame(height: geometry.size.height * 0.01)
                                                Text("Notes").font(.system(size: geometry.size.width * 0.07).bold()).foregroundStyle(Color.black)
                                                Spacer().frame(height: geometry.size.height * 0.025)
                                                Text("Concepts").italic().foregroundStyle(Color.black)
                                                Spacer().frame(height: geometry.size.height * 0.025)
                                                Text("Examples").italic().foregroundStyle(Color.black)
                                                Spacer().frame(height: geometry.size.height * 0.05)
                                                Text("During the lecture").foregroundStyle(Color.blue)
                                            }
                                        }
                                        .frame(width: geometry.size.width * 0.26, height: geometry.size.width * 0.45)
                                        .background(
                                            Color.white.opacity(
                                                currentStep > 3
                                                    ? 0.5 // Opacidad fija cuando `currentStep > 3`
                                                    : (isAnimating2 ? 0.75 : 0.5) // Alterna opacidad si `currentStep <= 3`
                                            )
                                        )
                                        .cornerRadius(15)
                                        .shadow(
                                            color: .black.opacity(currentStep > 3 ? 0 : 0.6), // Elimina la sombra si `currentStep > 3`
                                            radius: currentStep > 3 ? 0 : 10,
                                            x: 0,
                                            y: currentStep > 3 ? 0 : 5
                                        )
                                        .onAppear {
                                            if currentStep <= 3 {
                                                startBlinking2()
                                            }
                                        }
                        }
                       
                    
                    }
                    .frame(width: geometry.size.width*0.55,height: geometry.size.height * 0.32,alignment: .topLeading)
                   
                    Spacer().frame(height: geometry.size.height * 0.024)
                    if (currentStep>=4){
                        VStack {
                            if currentStep > 4 {
                                Text("Summary").font(.system(size: geometry.size.width * 0.04).bold()).foregroundStyle(Color.black)
                                Text("Clear summary in your own words, reinforcing your understanding and retention.").font(.system(size: geometry.size.width * 0.02)).multilineTextAlignment(.center).foregroundStyle(Color.black)
                                Text("Final step").foregroundStyle(Color.blue)
                            }
                        }
                        .frame(width: geometry.size.width * 0.55, height: geometry.size.height * 0.12)
                        .background(
                            Color.white.opacity(
                                currentStep > 4
                                    ? 0.5 // Opacidad fija cuando `currentStep > 3`
                                    : (isAnimating3 ? 0.75 : 0.5) // Alterna opacidad si `currentStep <= 3`
                            )
                        )
                        .cornerRadius(15)
                        .shadow(
                            color: .black.opacity(currentStep > 4 ? 0 : 0.6), // Elimina la sombra si `currentStep > 3`
                            radius: currentStep > 4 ? 0 : 10,
                            x: 0,
                            y: currentStep > 4 ? 0 : 5
                        )
                        .onAppear {
                            if currentStep <= 4 {
                                startBlinking3()
                            }
                        }
                    }
                   
                 
                }
                .frame(width: geometry.size.width * 0.55,height: geometry.size.height * 0.8,alignment: .topLeading)
                VStack{
                    if (currentStep==2){
                        
                        HStack{
                                               
                                                Text("Use this column to write keywords, questions, or main topics ")
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
                    
                    Spacer().frame(height: geometry.size.height * 0.02)
                    HStack{
                        if (currentStep==3){
                            Text("  Take the main notes during a lecture. Write down notes, concepts, definitions, examples, and any other important information  ")
                                                        .multilineTextAlignment(.center)
                                                        .font(.system(size: geometry.size.width * 0.025)) // Tamaño dinámico de fuente
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .background(Color.black)
                                                        .cornerRadius(20)
                                                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2)
                        }
                        
                        Spacer().frame(height: geometry.size.height * 1)
                        if (currentStep==4){
                            Text("  After completing your notes ,write a brief summary of the content on the page in a short paragraph. The goal is to condense all the information into a clear summary in your own words, reinforcing your understanding and retention.  ")
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
                    Spacer().frame(height: geometry.size.height * 0.02)
                    
                }
                .frame(width :geometry.size.width * 0.9, height: geometry.size.height*0.8 , alignment: .topLeading)
               // .background(Color.red.opacity(0.3))
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
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    currentStep += 1
                }
            }
            .onChange(of: currentStep) { newValue in
                if (newValue == 5 && !progressModel.star4CompleteStudy){
                    progressModel.star4CompleteStudy = true // Actualiza el estado
              
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
        }
    }
    private func startBlinking1() {
            // Cambia el valor de `isAnimating` periódicamente en el main actor
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                Task { @MainActor in
                    isAnimating1.toggle()
                }
            }
        }
    private func startBlinking2() {
            // Cambia el valor de `isAnimating` periódicamente en el main actor
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                Task { @MainActor in
                    isAnimating2.toggle()
                }
            }
        }
    private func startBlinking3() {
            // Cambia el valor de `isAnimating` periódicamente en el main actor
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                Task { @MainActor in
                    isAnimating3.toggle()
                }
            }
        }
    
}

#Preview {
    CornelView()
}
