import SwiftUI

struct FirstLetterView: View {
    @State private var showDetails = false
    @State private var currentStep = 1 // Comienza con todo visible desde el paso 2
    @State private var Description = true
    @State private var showOverlay = false // Controla la visibilidad de la vista superpuesta
    @State private var showinstructions = false
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @EnvironmentObject var progressModel: StarProgressModel // Usa el mismo ViewModel
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    private let totalSteps = 5 // Número total de pasos
    private let sections = [
            "Take the first letter of each word or concept in your list.",
            "Make a list of the words, concepts, or items you need to memorize.",
            "Use the letters to form a memorable word, phrase, or acronym.",
            "Repeat the phrase multiple times to strengthen your memory and recall each element associated with the initial letter."
        ]
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .center){
                VStack(spacing: geometry.size.height * 0.05) {
                    // Título
                    Text("First Letter")
                        .font(.system(size: geometry.size.width * 0.15, weight: .bold)) // Tamaño dinámico
                        .padding(.top, geometry.size.height * 0.02)
                    
                    if showDetails {
                        // Sección de imágenes e instrucciones
                        HStack(spacing: geometry.size.width * 0.04) {
                            // Evaporation
                            VStack {
                                Image("Evaporation") // Reemplaza con el nombre de tu imagen
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                
                                Text("E")
                                    .font(.system(size: geometry.size.width * 0.035)) // Tamaño dinámico
                                    .foregroundColor(Color(hex: "#0797F2")) +
                                Text("vaporation")
                                    .font(.system(size: geometry.size.width * 0.035)) // Tamaño dinámico
                                  
                            }
                            
                            // Condensation
                            VStack {
                                Image("Condensation") // Reemplaza con el nombre de tu imagen
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                
                                
                                Text("C")
                                    .font(.system(size: geometry.size.width * 0.035)) // Tamaño dinámico
                                    .foregroundColor(Color(hex: "#0797F2")) +
                                Text("ondensation")
                                    .font(.system(size: geometry.size.width * 0.035)) // Tamaño dinámico
                            
                            }
                            
                            // Precipitation
                            VStack {
                                Image("Precipitation") // Reemplaza con el nombre de tu imagen
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                
                                Text("P")
                                    .font(.system(size: geometry.size.width * 0.035)) // Tamaño dinámico
                                    .foregroundColor(Color(hex: "#0797F2")) +
                                Text("recipitation")
                                    .font(.system(size: geometry.size.width * 0.035)) // Tamaño dinámico
                             
                            }
                            
                            // Collection
                            VStack {
                                Image("Collection") // Reemplaza con el nombre de tu imagen
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                
                                
                                Text("C")
                                    .font(.system(size: geometry.size.width * 0.035)) // Tamaño dinámico
                                    .foregroundColor(Color(hex: "#0797F2")) +
                                Text("ollection")
                                    .font(.system(size: geometry.size.width * 0.035)) // Tamaño dinámico
                                    
                            }
                            
                        }
                        .padding(.top, geometry.size.height * 0.02)
                        .opacity((currentStep == 2||currentStep>=5) ? 1 : 0.2) // Cambia opacidad
                        
                        Spacer()
                            .frame(height: 50) // Espaciador fijo
                        
                        // Texto: "E, C, P, C"
                        Text("E, C, P, C")
                            .font(.system(size: geometry.size.width * 0.07)) // Tamaño dinámico
                            .foregroundColor(Color(hex: "#0797F2"))
                        
                            .padding(.top, geometry.size.height * 0.02)
                            .opacity((currentStep == 3||currentStep>=5) ? 1 : 0.2)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        // Frase completa
                        HStack(spacing: 0) {
                            Text("E")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                                .foregroundColor(Color(hex: "#0797F2")) +
                            Text("very ")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                                
                            
                            Text("C")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                                .foregroundColor(Color(hex: "#0797F2")) +
                            Text("loud ")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                               
                            
                            Text("P")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                                .foregroundColor(Color(hex: "#0797F2")) +
                            Text("roduces ")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                               
                            
                            Text("C")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                                .foregroundColor(Color(hex: "#0797F2")) +
                            Text("alm")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                              
                        }
                        .opacity(currentStep >= 4||currentStep>=6 ? 1 : 0.2) // Cambia opacidad
                        .padding(.horizontal, geometry.size.width * 0.1)
                        .multilineTextAlignment(.center)
                    }
                    
                    if Description {
                        Text("""
                    The First Letter Technique is a mnemonic strategy used to help memorize information by creating a phrase, acronym, or word using the first letters of a list of items.
                    
                    This method is especially helpful for learning sequences, lists, or key terms because it simplifies complex information into something easier to remember.
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
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height)
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
            VStack {
                Spacer().frame(height: geometry.size.height * 0.2) // Altura dinámica del primer Spacer
                if(showinstructions){
                    Text("Take the first letter of each word or concept in your list.")
                                       .font(.system(size: geometry.size.width * 0.04)) // Tamaño dinámico de fuente
                                       .foregroundColor(.white)
                                       .padding()
                                       .background(Color.black)
                                       .cornerRadius(20)
                                       .opacity((currentStep == 2) ? 1 : 0) // Cambia opacidad
                                   
                                   Spacer().frame(height: geometry.size.height * 0.25) // Altura dinámica del segundo Spac
                                   
                                   VStack {
                                       Text("Make a list of the words, concepts, or items you need to memorize.")
                                           .font(.system(size: geometry.size.width * 0.04)) // Tamaño dinámico de fuente
                                           .foregroundColor(.white)
                                           .padding()
                                           .background(Color.black)
                                           .cornerRadius(20)
                                           .frame(height: geometry.size.height * 0.12) // Altura dinámica del texto
                                           .opacity((currentStep == 3) ? 1 : 0) // Cambia opacidad

                                       Spacer().frame(height: geometry.size.height * 0.08) // Altura dinámica del espaciador interno

                                       Text("Use the letters to form a memorable word, phrase, or acronym.")
                                           .font(.system(size: geometry.size.width * 0.04)) // Tamaño dinámico de fuente
                                           .foregroundColor(.white)
                                           .padding()
                                           .background(Color.black)
                                           .cornerRadius(20)
                                           .frame(height: geometry.size.height * 0.15) // Altura dinámica del texto
                                           .opacity((currentStep == 4) ? 1 : 0) // Cambia opacidad
                                   }
                                   .frame(width: geometry.size.width, alignment: .leading) // Asegura que el VStack use todo el ancho disponible

                                   Spacer().frame(height: geometry.size.height * 0.05) // Altura dinámica del tercer Spacer

                                   Text("Repeat the phrase multiple times to strengthen your memory and recalling each element associated with the initial letter.")
                                       .font(.system(size: geometry.size.width * 0.02)) // Tamaño dinámico de fuente
                                       .foregroundColor(.white)
                                       .padding()
                                       .background(Color.black)
                                       .cornerRadius(20)
                                       .opacity((currentStep == 5) ? 1 : 0) // Cambia opacidad
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
        .onTapGesture {
                                    print(currentStep)
            if currentStep <= totalSteps {
                withAnimation(.easeInOut(duration: 1)) {
                    currentStep += 1
                }
            }

            if currentStep > 1 && !showDetails {
                withAnimation(.easeInOut(duration: 1)) { // Ocultar descripción
                    Description = false
                }
                
                // Mostrar detalles después de 1.5 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeInOut(duration: 2)) {
                        showDetails = true
                    }
                }
                
                // Mostrar instrucciones después de 3.5 segundos (1.5 segundos de showDetails + 2 segundos de animación)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation(.easeInOut(duration: 2)) {
                        showinstructions = true
                    }
                }
            }
        }
        .onChange(of: currentStep) { newValue in
            if (newValue == 6 && !progressModel.star2CompleteMemo) {
                progressModel.star2CompleteMemo = true // Actualiza el estado
          
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

#Preview{
        FirstLetterView().environmentObject(StarProgressModel())
    
}
