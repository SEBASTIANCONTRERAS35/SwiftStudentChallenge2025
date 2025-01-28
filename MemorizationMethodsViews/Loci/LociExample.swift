import SwiftUI

struct LociExampleView: View {
    @State private var showDetails = false
    @State private var currentStep = 1 // Comienza con todo visible desde el paso 2
    private let totalSteps = 5 // Número total de pasos
    @State private var Description = true
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel // Usa el mismo ViewModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
                
                VStack(spacing: geometry.size.height * 0.05) {
                    // Título
                    Text("Loci")
                        .font(Font.custom("ChalkboardSE-Regular", size: geometry.size.width * 0.15)) // Fuente ChalkboardSE
                        .padding(.top, geometry.size.height * 0.05)
                    
                    if showDetails {
                        
                        // Primera fila: Palacio
                        HStack(alignment: .center, spacing: geometry.size.width * 0.05) {
                            Image("Home") // Reemplaza con tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .opacity(shouldHighlightStep(2) ? 1 : 0.5)
                            
                            Text("We will use our house as our memory palace.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .multilineTextAlignment(.leading)
                                .opacity(shouldHighlightStep(2) ? 1 : 0.5)
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        
                        // Segunda fila
                        HStack(alignment: .center, spacing: geometry.size.width * 0.05) {
                            Text("Visualize yourself walking through our house, noting specific details of each room or area that could help to memorize one element..")
                                .font(.system(size: geometry.size.width * 0.03))
                                .multilineTextAlignment(.leading)
                                .opacity(shouldHighlightStep(3) ? 1 : 0.5)
                            
                            Image("EnterHome") // Reemplaza con tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .opacity(shouldHighlightStep(3) ? 1 : 0.5)
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        
                        // Tercera fila
                        HStack(alignment: .center, spacing: geometry.size.width * 0.05) {
                            Image("NA") // Reemplaza con tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .opacity(shouldHighlightStep(4) ? 1 : 0.5)
                            
                            Text("Connect the elements you want to remember with the object that you select in your journey. ")
                                .font(.system(size: geometry.size.width * 0.03))
                                .multilineTextAlignment(.leading)
                                .opacity(shouldHighlightStep(4) ? 1 : 0.5)
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        
                        // Cuarta fila
                        HStack(alignment: .center, spacing: geometry.size.width * 0.05) {
                            Text("Explore our house over and over again until you feel comfortable moving around and remember all the information you've organized inside about the elements of the periodic table.")
                                .font(.system(size: geometry.size.width * 0.03))
                                .multilineTextAlignment(.leading)
                                .opacity(shouldHighlightStep(5) ? 1 : 0.5)
                                .frame (height: geometry.size.height * 0.15)
                            
                            Image("RememberHome") // Reemplaza con tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .opacity(shouldHighlightStep(5) ? 1 : 0.5)
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        Spacer()
                        
                        
                        
                    }
                    if Description {
                        Text("""
In this example, we'll use learning some elements of the periodic table with the Method of Loci.
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
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.95) // Ajusta al tamaño del dispositivo
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                        .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 1)
                .onTapGesture {
                    if currentStep > 1 && !showDetails {
                        withAnimation(.easeInOut(duration: 1)) { // Animación lenta al ocultar descripción
                            Description = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Retraso de 1 segundo
                            withAnimation(.easeInOut(duration: 2)) { // Animación para mostrar detalles
                                showDetails = true
                            }
                        }
                    }
                  
                        withAnimation(.easeInOut(duration: 1)) { // Duración más rápida para pasos siguientes
                            currentStep += 1
                        }
                    
                }
                .onChange(of: currentStep) { newValue in
                    if (newValue > totalSteps  && !progressModel.star3CompleteMemo){
                        progressModel.star3CompleteMemo = true // Actualiza el estado
                  
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
    
    // Determina si el contenido debe estar completamente visible
    private func shouldHighlightStep(_ step: Int) -> Bool {
        return currentStep == step || currentStep > totalSteps
    }
}

struct LociExampleView_Previews: PreviewProvider {
    static var previews: some View {
        LociExampleView()
    }
}
