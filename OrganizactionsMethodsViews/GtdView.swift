//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 18/01/25.
//

import SwiftUI

struct GtdView: View {
    @State private var currentStep: Int = 1
    @State private var showOption: Int = 0
    @State private var levitate: Bool = false
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    @State private var showed1: Bool = false
    @State private var showed2: Bool = false
    @State private var showed3: Bool = false
    @State private var showed4: Bool = false
    @State private var showed5: Bool = false
    @State private var showedN: Int = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
            
            VStack {
                Text("GTD")
                    .font(Font.custom("Hiragino Mincho ProN", size: geometry.size.width * 0.15)) // Fuente ChalkboardSE
                    .padding(.top, geometry.size.height * 0.07)
                if (currentStep>1){
                    
                    HStack{
                        createButton(imageName: "CaptureGtd", label: "Capture", showOptionValue: 1, geometry: geometry,ColorFondo: Color.yellow)
                            .scaleEffect(showOption==1 ? 1.2 : 1)
                            .zIndex(showOption == 1 ? 1 : 0) // Bring this button to the front when scaled
                        createButton(imageName: "ClarifyGtd", label: "Clarify", showOptionValue: 2, geometry: geometry,ColorFondo: Color.green)
                            .scaleEffect(showOption==2 ? 1.2 : 1)
                            .zIndex(showOption == 2 ? 1 : 0) // Bring this button to the front when scaled
                        createButton(imageName: "OrganizeGtd", label: "Organize", showOptionValue: 3, geometry: geometry,ColorFondo: Color .orange)
                            .scaleEffect(showOption==3 ? 1.2 : 1)
                            .zIndex(showOption == 3 ? 1 : 0) // Bring this button to the front when scaled
                        createButton(imageName: "ReflectGtd", label: "Reflect", showOptionValue: 4, geometry: geometry, ColorFondo: Color.red)
                            .scaleEffect(showOption==4 ? 1.2 : 1)
                            .zIndex(showOption == 4 ? 1 : 0) // Bring this button to the front when scaled
                        createButton(imageName: "EngageGtd", label: "Engage", showOptionValue: 5, geometry: geometry,ColorFondo: Color.blue)
                            .scaleEffect(showOption==5 ? 1.2 : 1)
                            .zIndex(showOption == 5 ? 1 : 0) // Bring this button to the front when scaled
                    }
                    
                    if showOption == 1 {
                        
                        VStack{
                            Image("WriteIdeas")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.18)
                                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                                .offset(y: levitate ? -10 : 10)
                                .animation(
                                    Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                    value: levitate
                                )
                                .onAppear {
                                    if (!showed1){
                                        showed1 = true
                                        showedN += 1
                                        print(showedN)
                                    }
                                    levitate = true
                                }
                                .onDisappear {
                                    levitate = false
                                }
                            
                            Text("Write down everything that requires your attention, including tasks, ideas, commitments, or reminders.")
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                                .font(.system(size: geometry.size.width * 0.04))
                                .background(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: geometry.size.width * 0.4
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                        }
                        .background(Color.yellow.opacity(0.5))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.35)
                       
                        
                        
                    } else if showOption == 2 {
                        VStack {
                            HStack {
                                // Texto principal "¿¿ACTIONABLE??"
                                Text("¿¿ACTIONABLE??")
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.10)
                                    .font(.system(size: geometry.size.width * 0.025))
                                    .multilineTextAlignment(.center)
                                    .background(
                                        RadialGradient(
                                            gradient: Gradient(colors: [Color.blue, Color.green]),
                                            center: .center, // Centro del gradiente
                                            startRadius: 0,  // Radio inicial
                                            endRadius: geometry.size.width * 0.25 // Radio final
                                        )
                                    )
                                    .cornerRadius(65)
                                    .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4) // Sombra del texto
                                
                                // ZStack con la flecha y otros textos
                                ZStack(alignment: .leading) {
                                    StyledCapsule(color:.black , width: geometry.size.width * 0.20, height: 10,rotation : .degrees(0))
                                    
                                    
                                    
                                    
                                    // Contenido sobre la flecha
                                    VStack {
                                        Spacer()
                                            .frame(height: geometry.size.height * 0.01)
                                        
                                        // Primera línea: "Delegate or defer it"
                                        HStack {
                                            Text("Delegate or defer it")
                                                .font(.system(size: geometry.size.width * 0.015))
                                                .multilineTextAlignment(.center)
                                                .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.05)
                                                .background(
                                                    RadialGradient(
                                                        gradient: Gradient(colors: [Color.blue, Color.green]),
                                                        center: .center,
                                                        startRadius: 0,
                                                        endRadius: geometry.size.width * 0.4
                                                    )
                                                )
                                                .cornerRadius(15)
                                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                                            
                                            StyledCapsule(color:.red , width: geometry.size.width * 0.05, height: 10,rotation : .degrees(0))
                                            // Texto central
                                            Text("Takes less than 2 minutes? ")
                                                .font(.system(size: geometry.size.width * 0.015))
                                                .multilineTextAlignment(.center)
                                                .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.05)
                                            
                                            
                                            StyledCapsule(color:Color(hex: "288F84") , width: geometry.size.width * 0.05, height: 15,rotation : .degrees(0))
                                            
                                            
                                            
                                            Text("Do it immediately")
                                                .font(.system(size: geometry.size.width * 0.015))
                                                .multilineTextAlignment(.center)
                                                .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.05)
                                                .background(
                                                    RadialGradient(
                                                        gradient: Gradient(colors: [Color.blue, Color.green]),
                                                        center: .center,
                                                        startRadius: 0,
                                                        endRadius: geometry.size.width * 0.4
                                                    )
                                                )
                                                .cornerRadius(15)
                                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                                            
                                        }
                                        // .background(Color.pink)
                                        
                                        Spacer()
                                            .frame(height: geometry.size.height * 0.02)
                                        StyledCapsule(color:.black , width: geometry.size.width * 0.04, height: 10,rotation : .degrees(90))
                                        
                                        // Texto "Yes" y "No"
                                        Text("Yes")
                                            .font(.system(size: geometry.size.width * 0.03))
                                        
                                        
                                        StyledCapsule(color:Color.black , width: geometry.size.width * 0.04, height: 10,rotation : .degrees(-90))
                                        
                                        Text("No")
                                            .font(.system(size: geometry.size.width * 0.03))
                                        HStack{
                                            StyledCapsule(color:Color.black , width: geometry.size.width * 0.07, height: 10,rotation : .degrees(-30))
                                            StyledCapsule(color:Color.black , width: geometry.size.width * 0.05, height: 10,rotation : .degrees(90))
                                            StyledCapsule(color:Color.black , width: geometry.size.width * 0.07, height: 10,rotation : .degrees(-150))
                                        }
                                        
                                        // Opciones: "Delete", "Reference", "Someday"
                                        HStack {
                                            Text("Delete")
                                                .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                                .background(
                                                    RadialGradient(
                                                        gradient: Gradient(colors: [Color.blue, Color.green]),
                                                        center: .center,
                                                        startRadius: 0,
                                                        endRadius: geometry.size.width * 0.4
                                                    )
                                                )
                                                .cornerRadius(15)
                                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                                            Text("Reference")
                                                .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                                .background(
                                                    RadialGradient(
                                                        gradient: Gradient(colors: [Color.blue, Color.green]),
                                                        center: .center,
                                                        startRadius: 0,
                                                        endRadius: geometry.size.width * 0.4
                                                    )
                                                )
                                                .cornerRadius(15)
                                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                                            Text("Someday")
                                                .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                                .background(
                                                    RadialGradient(
                                                        gradient: Gradient(colors: [Color.blue, Color.green]),
                                                        center: .center,
                                                        startRadius: 0,
                                                        endRadius: geometry.size.width * 0.4
                                                    )
                                                )
                                                .cornerRadius(15)
                                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.35, alignment: .center)
                                    
                                }
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.35, alignment: .leading)
                                
                            }
                        }
                        .onAppear {
                            if (!showed2){
                                showed2 = true
                                showedN += 1
                                print(showedN)
                            }
                            levitate = true
                        }
                        .onDisappear {
                            levitate = false
                        }
                        .background(Color.green.opacity(0.5))
                        
                    } else if showOption == 3 {
                        VStack (spacing: 0){
                            Image("Folders")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.18)
                                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                                .offset(y: levitate ? -10 : 10)
                                .animation(
                                    Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                    value: levitate
                                )
                                .onAppear {
                                    if (!showed3){
                                        showed3 = true
                                        showedN += 1
                                        print(showedN)
                                    }
                                    levitate = true
                                }
                                .onDisappear {
                                    levitate = false
                                }
                            HStack (spacing : geometry.size.height * 0.025){
                                Text("Tasks requiring multiple steps.")
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                Text("The very next step you can take.")
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                Text("Tasks with specific deadlines")
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                Text("Tasks delegated and are awaiting completion.")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                                Text("Non-urgent ideas")
                                    .font(.system(size: geometry.size.width * 0.02))
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.06)
                            }
                            Text("Place actionable tasks into specific lists or categories")
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                                .font(.system(size: geometry.size.width * 0.04))
                                .background(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color.orange, Color.purple]),
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: geometry.size.width * 0.4
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                            
                        }
                        .background(Color.orange.opacity(0.5))
                        
                    } else if showOption == 4 {
                        VStack{
                            Image("ReviewList")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.18)
                                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                                .offset(y: levitate ? -10 : 10)
                                .animation(
                                    Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                    value: levitate
                                )
                                .onAppear {
                                    if (!showed4){
                                        showed4 = true
                                        showedN += 1
                                        print(showedN)
                                    }
                                    levitate = true
                                }
                                .onDisappear {
                                    levitate = false
                                }
                            
                            Text("Regularly review your lists to keep your system updated and ensure tasks align with your priorities.")
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                                .font(.system(size: geometry.size.width * 0.04))
                                .background(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.red]),
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: geometry.size.width * 0.4
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                        }
                        .background(Color.red.opacity(0.5))
                        
                    } else if showOption == 5 {
                        VStack{
                            Image("SetPriority")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.18)
                                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                                .offset(y: levitate ? -10 : 10)
                                .animation(
                                    Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                    value: levitate
                                )
                                .onAppear {
                                    if (!showed5){
                                        showed5 = true
                                        showedN += 1
                                        print(showedN)
                                    }
                                    levitate = true
                                }
                                .onDisappear {
                                    levitate = false
                                }
                            
                            Text("Choose tasks to work on based on context, time available, energy level, and priority.")
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                                .font(.system(size: geometry.size.width * 0.04))
                                .background(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color.orange, Color.blue]),
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: geometry.size.width * 0.4
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 4)
                        }
                        .background(Color.blue.opacity(0.5))
                    }
                    
                }
                else{
                    Text("""
                GTD (Getting Things Done) is a productivity method, designed to help individuals organize their tasks, reduce mental clutter, and achieve their goals with clarity and focus.
                
                The system emphasizes capturing tasks, organizing them into actionable steps, and reviewing progress regularly.
                """).font(.system(size: geometry.size.width * 0.04)) // Tamaño dinámico
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
            .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95)
            .background( Image(colorScheme == .dark ? "Background2" : "Background")
                .resizable()
                         
                         
            ) // Para que el fondo abarque toda el área de la vista)
            .cornerRadius(15)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onChange(of: showedN) { newValue in
                if (showedN == 5 && !progressModel.star3CompleteOrga){
                    progressModel.star3CompleteOrga = true // Actualiza el estado
                                  
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
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    currentStep += 1
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
    private func createButton(imageName: String, label: String, showOptionValue: Int, geometry: GeometryProxy,ColorFondo: Color ) -> some View {
        Button(action: {
            withAnimation {
                showOption = (showOption == showOptionValue) ? 0 : showOptionValue
                print(showOption)
            }
        }) {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.2)
                Text(label)
                    .font(.system(size: geometry.size.width * 0.03))
                    .foregroundStyle(Color.primary)
            }
            .frame(width: geometry.size.width * 0.18, height: geometry.size.height * 0.25)
            .background(ColorFondo.opacity(0.9)) // Fondo blanco ligeramente opaco
            .cornerRadius(10) // Bordes redondeados
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4) // Sombra
        }
    }
}
#Preview {
    GtdView()
}

























struct StyledCapsule: View {
    var color: Color = .red
       var width: CGFloat
       var height: CGFloat
       var rotation: Angle = .zero
       @State private var progress: CGFloat = 0.0

       var body: some View {
           Capsule()
               .trim(from: 0.0, to: progress) // Controla cuánto de la cápsula está visible
               .stroke(color, lineWidth: height) // Cambia el relleno por un trazo
               .frame(width: width, height: height)
               .rotationEffect(rotation)
               .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 4)
               .onAppear {
                   withAnimation(.easeInOut(duration: 2)) { // Ajusta la duración según sea necesario
                       progress = 1.0
                   }
               }
       }
}



