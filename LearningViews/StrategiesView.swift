import SwiftUI
import CoreHaptics

struct StrategiesView: View {
    @State private var showText = false
    @State private var selectedTab: Int = 0 // Controla la pestaña seleccionada
    private let hapticManager = HapticFeedbackManager() // Instancia de HapticFeedbackManager
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @StateObject private var progressModel = StarProgressModel()

    var body: some View {
        
        ZStack{
            
            VStack(spacing: 0) {
                if selectedTab == 0 {
                    // Contenido principal de la primera pestaña (Métodos)
                    NavigationStack {
                        GeometryReader { geometry in
                            VStack() {
                                
                                Spacer() .frame( height: geometry.size.height * 0.1)
                                HStack() {
                                    // Botón 1: Organization Methods
                                    NavigationLink(destination: OrganizationView().environmentObject(progressModel) ) {
                                        VStack {
                                            Image("OrganizationIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                            Spacer() .frame( height: geometry.size.height * 0.001)
                                            Text("Organization\nMethods") // Salto manual
                                                .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                                .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                                .multilineTextAlignment(.center)
                                                .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                                .lineLimit(2)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Spacer() .frame( width: geometry.size.width * 0.25)
                                    
                                    // Botón 2: Study Methods
                                    NavigationLink(destination: StudyView() .environmentObject(progressModel) ) {
                                        VStack {
                                            Image("StudyIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                            Spacer() .frame( height: geometry.size.height * 0.001)
                                            Text("Study\nMethods") // Salto manual
                                                .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                                .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                                .multilineTextAlignment(.center)
                                                .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                                .lineLimit(2)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                Spacer() .frame( height: geometry.size.height * 0.001)
                                
                                // Botón 3: Memorization Methods
                                NavigationLink(destination: MemorizationView().environmentObject(progressModel)) {
                                    VStack {
                                        Image("MemorizationIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.20, height: geometry.size.height * 0.20)
                                        Spacer() .frame( height: geometry.size.height * 0.001)
                                        
                                        Text("Memorization\nMethods") // Salto manual
                                            .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                            .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                            .multilineTextAlignment(.center)
                                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                            .lineLimit(2)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                
                                Spacer()
                                    .frame( height: geometry.size.height * 0.1)
                                // Título principal
                                Text("Learning Strategies")
                                    .font(.system(size: geometry.size.width * 0.05))
                                    .fontWeight(.bold)
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                                    .foregroundColor(Color(hex: "#2632BF"))
                                    .padding()
                                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.2)
                                    .background(Color(hex: "#92D321"))
                                    .cornerRadius(20)
                                    .offset(y: showText ? 0 : 100) // Controla la posición
                                
                                
                            }
                            .frame(width: geometry.size.width * 0.95, height: geometry.size.height ,alignment: .top) // Ajusta dimensiones
                            .background(
                                Image(colorScheme == .dark ? "Background2" : "Background")
                                    .resizable()
                            )
                            .cornerRadius(15)
                            
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            
                            .onAppear {
                                withAnimation(.easeOut(duration: 1)) { // Añade una animación suave al aparecer
                                    showText = true
                                }
                            }
                        }
                    }
                } else if selectedTab == 1 {
                    
                    MyItemsView().environmentObject(progressModel)
                    
                } else if selectedTab == 2 {
                    ProgressView().environmentObject(progressModel)
                }
                
                // Barra inferior de navegación
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            selectTab(0)
                        }) {
                            Image("Lampara")
                                .resizable()
                                .scaledToFit()
                                .frame(width: selectedTab == 0 ? 50 : 40, height: selectedTab == 0 ? 50 : 40) // Escala
                                .animation(.easeInOut(duration: 0.2), value: selectedTab) // Animación
                                .foregroundColor(selectedTab == 0 ? .yellow : .white)
                        }
                        Text("Methods")
                            .font(.footnote)
                            .foregroundColor(selectedTab == 0 ? .yellow : .white)
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            selectTab(1)
                        }) {
                            Image("Items")
                                .resizable()
                                .scaledToFit()
                                .frame(width: selectedTab == 1 ? 50 : 40, height: selectedTab == 1 ? 50 : 40)
                                .animation(.easeInOut(duration: 0.2), value: selectedTab)
                                .foregroundColor(selectedTab == 1 ? .yellow : .white)
                        }
                        Text("My Items")
                            .font(.footnote)
                            .foregroundColor(selectedTab == 1 ? .yellow : .white)
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            selectTab(2)
                        }) {
                            Image("Planta")
                                .resizable()
                                .scaledToFit()
                                .frame(width: selectedTab == 2 ? 50 : 40, height: selectedTab == 2 ? 50 : 40)
                                .animation(.easeInOut(duration: 0.2), value: selectedTab)
                                .foregroundColor(selectedTab == 2 ? .yellow : .white)
                        }
                        Text("Progress")
                            .font(.footnote)
                            .foregroundColor(selectedTab == 2 ? .yellow : .white)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(hex: "#8E4D22")) // Color café para la barra inferior
            }
            GeometryReader { geom in
                VStack{
                    ZStack{
                        
                    }
                    Text("")
                }
                .frame(width: geom.size.width,height: geom.size.height)
                .background(Color.white)
            }
        }
        
    }
    private func selectTab(_ tab: Int) {
           selectedTab = tab
           hapticManager.playHapticFeedback() // Reproduce la vibración
       }
    
}

#Preview {
    StrategiesView()
}
