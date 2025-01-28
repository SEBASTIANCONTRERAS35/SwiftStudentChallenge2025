//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 05/01/25.
//

import SwiftUI

struct EisenhowerView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var ShowDetails = false;
    @State private var DoText = "DO";
    @State private var DescriptionDo = false;
    @State private var PlanText = "PLAN";
    @State private var DescriptionPlan = false;
    @State private var DelegateText = "DELEGATE";
    @State private var DescriptionDelegate = false;
    @State private var EliminateText = "ELIMINATE";
    @State private var DescriptionEliminate = false;
    @State private var AnimatePermission = false // Controla si las animaciones están en curso
    @State private var rotationAnglePlan: Double = 0 // Controla la rotación del rectángulo
    @State private var rotationAngleDo: Double = 0 // Controla la rotación del rectángulo
    @State private var rotationAngleDelegate: Double = 0 // Controla la rotación del rectángulo
    @State private var rotationAngleEliminate: Double = 0 // Controla la rotación del rectángulo
    @State private var rotated : Int = 0
    @State private var rotatedDo: Bool = false
    @State private var rotatedPlan: Bool = false
    @State private var rotatedDelegate: Bool = false
    @State private var rotatedEliminate: Bool = false
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
                VStack(spacing: geometry.size.height * 0.05) {
                    Text("Eisenhower Matrix ")
                        .font(Font.custom("Noteworthy-Bold", size: geometry.size.width * 0.1)) // Fuente personalizada y tamaño dinámico
                    
                        .padding(.top, geometry.size.height * 0.02)
                    if (ShowDetails){
                        VStack(spacing: 0) {
                                               ZStack {
                                                   // Línea principal
                                                   Path { path in
                                                       let midY = geometry.size.height * 0.08// Altura relativa para la línea
                                                       path.move(to: CGPoint(x: geometry.size.width * 0.25, y: midY))
                                                       path.addLine(to: CGPoint(x: geometry.size.width * 0.75, y: midY))
                                                   }
                                                   .stroke(Color.primary, lineWidth: 5)
                                                   
                                                   // Flecha izquierda
                                                   Path { path in
                                                       let midY = geometry.size.height * 0.08
                                                       path.move(to: CGPoint(x: geometry.size.width * 0.25, y: midY))
                                                       path.addLine(to: CGPoint(x: geometry.size.width * 0.28, y: midY - 10))
                                                       path.move(to: CGPoint(x: geometry.size.width * 0.25, y: midY))
                                                       path.addLine(to: CGPoint(x: geometry.size.width * 0.28, y: midY + 10))
                                                   }
                                                   .stroke(Color.primary, lineWidth: 5)
                                                   
                                                   // Flecha derecha
                                                   Path { path in
                                                       let midY = geometry.size.height * 0.08
                                                       path.move(to: CGPoint(x: geometry.size.width * 0.75, y: midY))
                                                       path.addLine(to: CGPoint(x: geometry.size.width * 0.72, y: midY - 10))
                                                       path.move(to: CGPoint(x: geometry.size.width * 0.75, y: midY))
                                                       path.addLine(to: CGPoint(x: geometry.size.width * 0.72, y: midY + 10))
                                                   }
                                                   .stroke(Color.primary, lineWidth:5)
                                                   
                                                   // Etiqueta "Urgent"
                                                   Text("Urgent")
                                                       .font(.system(size: geometry.size.width * 0.04, weight: .bold))
                                                      
                                                       .frame(width: geometry.size.width * 0.2)
                                                       .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.015)
                                                   
                                                   // Etiqueta "Not Urgent"
                                                   Text("Not Urgent")
                                                       .font(.system(size: geometry.size.width * 0.04, weight: .bold))
                                                    
                                                       .frame(width: geometry.size.width * 0.2)
                                                       .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.015)
                                               }
                                               .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                                               
                                               HStack(spacing: 0) {
                                                   //linea vertical
                                                   
                                                   Text(DoText)
                                                       .font(.system(size: DescriptionDo ? geometry.size.width * 0.03 : geometry.size.width * 0.05)) // Tamaño dinámico
                                                       .fontWeight(.bold)
                                                       .foregroundColor(.white)
                                                       .rotation3DEffect(
                                                           Angle(degrees: DescriptionDo ? 180 : 0), // Aplica la rotación en 3D
                                                           axis: (x: 0, y: 1, z: 0) // Rota en el eje Y
                                                       )
                                                       .frame(width: geometry.size.width * 0.37, height: geometry.size.height * 0.3)
                                                       .background(
                                                           RadialGradient(
                                                               gradient: Gradient(colors: [Color(hex: "27D321"), Color(hex: "116D14")]),
                                                               center: .center,
                                                               startRadius: 10,
                                                               endRadius: 200
                                                           )
                                                       )
                                                       .rotation3DEffect(
                                                           Angle(degrees: rotationAngleDo), // Aplica la rotación
                                                                      axis: (x: 0, y: 1, z: 0) // Rota en el eje Y para simular el volteo
                                                                  )
                                                       .animation(.easeInOut(duration: 0.6), value: rotationAngleDo) // Define la animación
                                                   
                                                
                                                   
                                                       .onTapGesture {
                                                           if (AnimatePermission){
                                                               withAnimation {
                                                                   if (!rotatedDo){
                                                                       rotatedDo=true
                                                                       rotated+=1
                                                                   }
                                                                                                                             rotationAngleDo += 180 // Incrementa el ángulo para girar
                                                                                                                         }
                                                                                                                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Cambia el texto a mitad del giro
                                                                                                                             DescriptionDo.toggle()
                                                                                                                             DoText = DescriptionDo
                                                                                                                                 ? "Tasks that are both urgent and important require immediate attention. These are often deadlines, emergencies, or critical tasks that cannot wait."
                                                                                                                                 : "DO"
                                                                                                                         }
                                                           }
                                                          
                                                       }
                                                   
                                                   // "Plan"
                                                   Text(PlanText)
                                                       .font(.system(size: DescriptionPlan ? geometry.size.width * 0.03 : geometry.size.width * 0.05)) // Tamaño dinámico
                                                       .fontWeight(.bold)
                                                       .foregroundColor(.white)
                                                       .rotation3DEffect(
                                                               Angle(degrees: DescriptionPlan ? 180 : 0), // Aplica la rotación en 3D
                                                               axis: (x: 0, y: 1, z: 0) // Rota en el eje Y
                                                           )
                                                       .frame(width: geometry.size.width * 0.37, height: geometry.size.height * 0.3)
                                                       .background(
                                                           RadialGradient(
                                                               gradient: Gradient(colors: [Color(hex: "2E94FA"), Color(hex: "1B5794")]),
                                                               center: .center,
                                                               startRadius: 10,
                                                               endRadius: 200
                                                           )
                                                       )
                                                       .rotation3DEffect(
                                                           Angle(degrees: rotationAnglePlan), // Aplica la rotación
                                                                      axis: (x: 0, y: 1, z: 0) // Rota en el eje Y para simular el volteo
                                                                  )
                                                   
                                                       .animation(.easeInOut(duration: 0.6), value: rotationAnglePlan) // Define la animación
                                                                  .onTapGesture {
                                                                      if (AnimatePermission){
                                                                          if (!rotatedPlan){
                                                                              rotatedPlan = true
                                                                              rotated+=1
                                                                          }
                                                                          withAnimation {
                                                                              rotationAnglePlan += 180 // Incrementa el ángulo para girar
                                                                          }
                                                                          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Cambia el texto a mitad del giro
                                                                              DescriptionPlan.toggle()
                                                                              PlanText = DescriptionPlan
                                                                              ? "These tasks are essential for achieving long-term goals but don’t require immediate action. They often involve planning, strategy, or personal development."
                                                                              : "PLAN"
                                                                          }
                                                                      }
                                                                  }
                                               }.padding(.bottom, -55) // R
                            
                    }
                    
                        
                        // Segunda fila: "Delegate" y "Eliminate"
                        HStack(spacing: 0) {
                            
                            
                            
                            Text(DelegateText)
                                .font(.system(size: DescriptionDelegate ? geometry.size.width * 0.03 : geometry.size.width * 0.05)) // Tamaño dinámico
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .rotation3DEffect(
                                    Angle(degrees: DescriptionDelegate ? 180 : 0), // Aplica la rotación en 3D
                                    axis: (x: 0, y: 1, z: 0) // Rota en el eje Y
                                )
                                .frame(width: geometry.size.width * 0.37, height: geometry.size.height * 0.3)
                                .background(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color(hex: "FABC2E"), Color(hex: "946F1B")]),
                                        center: .center,
                                        startRadius: 10,
                                        endRadius: 200
                                    )
                                )
                                .rotation3DEffect(
                                    Angle(degrees: rotationAngleDelegate), // Aplica la rotación
                                               axis: (x: 0, y: 1, z: 0) // Rota en el eje Y para simular el volteo
                                           )
                                .animation(.easeInOut(duration: 0.6), value: rotationAngleDelegate) // Define la animación
                                .onTapGesture {
                                    if (AnimatePermission){
                                        if (!rotatedDelegate){
                                            rotatedDelegate = true
                                            rotated+=1
                                        }
                                        withAnimation {
                                            rotationAngleDelegate += 180 // Incrementa el ángulo para girar
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Cambia el texto a mitad del giro
                                            DescriptionDelegate.toggle()
                                            DelegateText = DescriptionDelegate
                                            ? "These tasks demand immediate attention but don’t significantly impact your goals. They are often interruptions or tasks that others can handle."
                                            : "DELEGATE"
                                        }
                                    }
                                }
                            
                            // "Eliminate"
                            Text(EliminateText)
                                .font(.system(size: DescriptionEliminate ? geometry.size.width * 0.03 : geometry.size.width * 0.05)) // Tamaño dinámico
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .rotation3DEffect(
                                    Angle(degrees: DescriptionEliminate ? 180 : 0), // Aplica la rotación en 3D
                                    axis: (x: 0, y: 1, z: 0) // Rota en el eje Y
                                )
                                .frame(width: geometry.size.width * 0.37, height: geometry.size.height * 0.3)
                                .background(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color(hex: "E51313"), Color (hex: "7F0A0A")]),
                                        center: .center,
                                        startRadius: 10,
                                        endRadius: 200
                                    )
                                )
                                .rotation3DEffect(
                                    Angle(degrees: rotationAngleEliminate), // Aplica la rotación
                                               axis: (x: 0, y: 1, z: 0) // Rota en el eje Y para simular el volteo
                                           )
                                .animation(.easeInOut(duration: 0.6), value: rotationAngleEliminate) // Define la animación
                                .onTapGesture {
                                    if (AnimatePermission){
                                        if (!rotatedEliminate){
                                            rotatedEliminate = true
                                            rotated+=1
                                        }
                                        withAnimation {
                                            rotationAngleEliminate += 180 // Incrementa el ángulo para girar
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Cambia el texto a mitad del giro
                                            DescriptionEliminate.toggle()
                                            EliminateText = DescriptionEliminate
                                            ? "These tasks are distractions or time-wasters. They don’t contribute to your goals and often consume time without adding value."
                                            : "ELIMINATE"
                                        }
                                    }
                                }
                        }
                        
                        .frame(alignment: .top)
                    
                       
                   }
                else{
                      
                        Text("""
                    The Eisenhower Matrix, also known as the Urgent-Important Matrix, is a decision-making tool designed to help prioritize tasks based on their urgency and importance. this method emphasizes focusing on what truly matters and delegating or eliminating distractions.
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
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95) // Ajusta dimensiones
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                                       .resizable()
                )              .cornerRadius(15)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) { // Primera animación
                        ShowDetails = true
                    }
                   
                    // Inicia la rotación después de que termine la animación inicial
                    if (!AnimatePermission){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.003) { // Espera 1 segundo
                                             withAnimation(.easeInOut(duration: 0.05)) { // Animación de rotación
                                                 rotationAnglePlan += 15
                                                 rotationAngleDo += 15
                                                 rotationAngleDelegate += 15
                                                 rotationAngleEliminate += 15
                                             }

                                             // Rotación adicional antes de regresar completamente
                                             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                 withAnimation(.easeInOut(duration: 0.05)) {
                                                     rotationAnglePlan = -10
                                                     rotationAngleDo = -10
                                                     rotationAngleDelegate = -10
                                                     rotationAngleEliminate = -10
                                                 }

                                                 // Regresa a la posición original con un ajuste final
                                                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                     withAnimation(.easeInOut(duration: 0.05)) {
                                                         rotationAnglePlan = 0
                                                         rotationAngleDo = 0
                                                         rotationAngleDelegate = 0
                                                         rotationAngleEliminate = 0
                                                     }
                                                 }
                                                 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                     AnimatePermission = true
                                                                }
                                             }
                                         }
                    }
                 
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                if (ShowDetails){
                    VStack{
                                     Spacer().frame(height: geometry.size.height*0.25)
                                     ZStack {
                                                     // Línea principal
                                                     Path { path in
                                                         let centerX = geometry.size.width * 0.08 // Centro horizontal
                                                         let topY = geometry.size.height * 0.16 // Comienza un poco debajo de la parte superior
                                                         let bottomY = geometry.size.height * 0.45 // Termina un poco arriba de la parte inferior
                                                         path.move(to: CGPoint(x: centerX, y: topY))
                                                         path.addLine(to: CGPoint(x: centerX, y: bottomY))
                                                     }
                                                     .stroke(Color.primary, lineWidth: 5)
                                                     
                                                     // Flecha hacia arriba
                                                     Path { path in
                                                         let arrowX = geometry.size.width * 0.08 // Posición horizontal de la flecha
                                                         let arrowY = geometry.size.height * 0.154 // Posición vertical de la punta de la flecha
                                                         path.move(to: CGPoint(x: arrowX - 10, y: arrowY + 10)) // Línea izquierda
                                                         path.addLine(to: CGPoint(x: arrowX, y: arrowY)) // Punto de la flecha
                                                         path.addLine(to: CGPoint(x: arrowX + 10, y: arrowY + 10)) // Línea derecha
                                                     }
                                                     .stroke(Color.primary, lineWidth: 5)
                                                     
                                                     // Flecha hacia abajo
                                                     Path { path in
                                                         let arrowX = geometry.size.width * 0.08 // Posición horizontal de la flecha
                                                         let arrowY = geometry.size.height * 0.455 // Posición vertical de la base de la flecha
                                                         path.move(to: CGPoint(x: arrowX - 10, y: arrowY - 10)) // Línea izquierda
                                                         path.addLine(to: CGPoint(x: arrowX, y: arrowY)) // Punto de la flecha
                                                         path.addLine(to: CGPoint(x: arrowX + 10, y: arrowY - 10)) // Línea derecha
                                                     }
                                                     .stroke(Color.primary, lineWidth: 5)
                                                 }
                                     .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.61)
                                   
                                 }
                                 .frame(width: geometry.size.width*0.95, alignment: .leading) // Alinea todo el VStack a la izquierda
                                 VStack(alignment: .leading, spacing: 10) {
                                     Spacer().frame(height: geometry.size.height*0.34)
                                     Text("Important").rotationEffect(.degrees(-90)) // Rotar 90 grados
                                         .font(.system(size: geometry.size.width * 0.03, weight: .bold))

                                     Spacer().frame(height: geometry.size.height*0.4)
                                     Text("""
                 Not 
                 Important
                 """).rotationEffect(.degrees(-90)) // Rotar 90 grados
                                         .font(.system(size: geometry.size.width * 0.03, weight: .bold))

                                 }
                                 .frame(width: geometry.size.width * 0.97, height: geometry.size.height * 0.95, alignment: .topLeading) // Alineación hacia arriba
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
                        .onChange(of: rotated) { newValue in
                            if (newValue == 4 && !progressModel.star1CompleteOrga){
                                progressModel.star1CompleteOrga = true // Actualiza el estado
                                              
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
    EisenhowerView()
}
class PortraitHostingController<Content>: UIHostingController<Content> where Content: View {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait // Bloquear en orientación vertical
    }
}
