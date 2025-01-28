import SwiftUI

struct LociView: View {
    @State private var showDetails = false
    @State private var currentStep = 1 // Comienza con todo visible desde el paso 2
    private let totalSteps = 5 // Número total de pasos
    @State private var Description = true
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @State private var navigateToExample = false // Estado para navegación condicional
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel // Usa el mismo ViewModel

    var body: some View {
        NavigationStack{
            
            
            GeometryReader { geometry in
                VStack() {
                    // Título
                    Text("Loci")
                        .font(Font.custom("ChalkboardSE-Regular", size: geometry.size.width * 0.15)) // Fuente ChalkboardSE
                       
                    
                    if showDetails {
                        
                        // Primera fila: Palacio
                        HStack(alignment: .center, spacing: geometry.size.width * 0.05) {
                            Image("Palace") // Reemplaza con tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.15)
                                .opacity(shouldHighlightStep(2) ? 1 : 0.5)
                            
                            Text("Choose a familiar place, this could be your home, a route you take to work, or any location you know well.")
                                .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                                .multilineTextAlignment(.leading)
                                .opacity(shouldHighlightStep(2) ? 1 : 0.5)
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        
                        // Segunda fila
                        HStack(alignment: .center, spacing: geometry.size.width * 0.05) {
                            Text("Visualize yourself walking through this location, noting specific details of each room or area.")
                                .font(.system(size: geometry.size.width * 0.03))
                                .multilineTextAlignment(.leading)
                                .opacity(shouldHighlightStep(3) ? 1 : 0.5)
                            
                            Image("EnterPalace") // Reemplaza con tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.15)
                                .opacity(shouldHighlightStep(3) ? 1 : 0.5)
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        
                        // Tercera fila
                        HStack(alignment: .center, spacing: geometry.size.width * 0.05) {
                            Image("Key") // Reemplaza con tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.15)
                                .opacity(shouldHighlightStep(4) ? 1 : 0.5)
                            
                            Text("Connect the items you want to remember with specific places in your journey.")
                                .font(.system(size: geometry.size.width * 0.03))
                                .multilineTextAlignment(.leading)
                                .opacity(shouldHighlightStep(4) ? 1 : 0.5)
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        
                        // Cuarta fila
                        HStack(alignment: .center, spacing: geometry.size.width * 0.05) {
                            Text("Explore your palace over and over again until you feel comfortable moving around and realize how easy it is to retrieve all the information you've organized inside.")
                                .font(.system(size: geometry.size.width * 0.03))
                                .multilineTextAlignment(.leading)
                                .opacity(shouldHighlightStep(5) ? 1 : 0.5)
                                .frame(height : geometry.size.height * 0.12)
                            
                            Image("RememberPalace") // Reemplaza con tu imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .opacity(shouldHighlightStep(5) ? 1 : 0.5)
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        
                        // Botón inferior
                        if currentStep > totalSteps {
                                                    NavigationLink(
                                                        destination: LociExampleView().environmentObject(progressModel),
                                                        isActive: $navigateToExample // Activa la navegación
                                                    ) {
                                                        Button(action: {
                                                            navigateToExample = true // Cambia el estado para navegar
                                                        }) {
                                                            Text("Example")
                                                                .font(.system(size: geometry.size.width * 0.05, weight: .bold))
                                                                .foregroundColor(.red)
                                                                .frame(maxWidth: .infinity)
                                                                .padding()
                                                                .background(Color.yellow)
                                                                .cornerRadius(25)
                                                        }
                                                    }
                                                    .padding(.horizontal, geometry.size.width * 0.1)
                                                    .padding(.bottom, geometry.size.height * 0.05)
                                                } else {
                                                    Button(action: {
                                                        // No hace nada porque está deshabilitado
                                                    }) {
                                                        Text("Example")
                                                            .font(.system(size: geometry.size.width * 0.05, weight: .bold))
                                                            .foregroundColor(.gray) // Muestra un color deshabilitado
                                                            .frame(maxWidth: .infinity)
                                                            .padding()
                                                            .background(Color.gray.opacity(0.5)) // Fondo deshabilitado
                                                            .cornerRadius(25)
                                                    }
                                                    .padding(.horizontal, geometry.size.width * 0.1)
                                                    .padding(.bottom, geometry.size.height * 0.05)
                                                }
                    }
                    if Description {
                        Text("""
Loci is a mnemonic device that uses visualization to aid memory.

It involves creating a mental image of a familiar location and associating items you want to remember with specific places within that location.
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
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95 ,alignment: .center) // Ajusta al tamaño del dispositivo
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                                       .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width , height: geometry.size.height )
                
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
                    else if currentStep <= totalSteps {
                        withAnimation(.easeInOut(duration: 1)) { // Duración más rápida para pasos siguientes
                            currentStep += 1
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
                            .foregroundColor(Color (hex: "#8E4D22")) // Cambia el color del ícono y texto
                            
                        }
                    }
                }
            }
        }
    }
    
    // Determina si el contenido debe estar completamente visible
    private func shouldHighlightStep(_ step: Int) -> Bool {
        return currentStep == step || currentStep > totalSteps
    }
}

struct LociView_Previews: PreviewProvider {
    static var previews: some View {
        LociView()
    }
}
