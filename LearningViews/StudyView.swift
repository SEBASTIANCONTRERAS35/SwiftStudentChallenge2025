import SwiftUI

struct StudyView: View {
    @State private var showText = false
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack() {
                    Spacer() .frame( height: geometry.size.height * 0.1)

                    HStack() {
                        // Botón 1: Pomodoro
                        
                        NavigationLink(destination: PomodoroView().environmentObject(progressModel)) {
                            VStack {
                                Image("Pomodoro")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                Spacer() .frame( height: geometry.size.height * 0.001)

                                Text("Pomodoro") // Salto manual
                                    .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                    .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                    .lineLimit(2)
                            }
                        }
                        
                        Spacer() .frame( width: geometry.size.width * 0.25)

                        // Botón 2: Mind Maps
                        NavigationLink(destination: MindMapView().environmentObject(progressModel)) {
                            VStack {
                                Image("Mental")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                Spacer() .frame( height: geometry.size.height * 0.001)

                                Text("Mind Maps") // Salto manual
                                    .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                    .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    HStack() {
                        // Botón 3: Cornel
                        NavigationLink(destination: CornelView().environmentObject(progressModel)) {
                            VStack {
                                Image("Cornel")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                Spacer() .frame( height: geometry.size.height * 0.001)

                                Text("Cornel") // Salto manual
                                    .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                    .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                    .lineLimit(2)
                            }
                        }
                        
                        Spacer() .frame( width: geometry.size.width * 0.25)

                        // Botón 4: SQ3R
                        NavigationLink(destination: SQ3RView().environmentObject(progressModel)) {
                            VStack {
                                Image("SQ3R")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                Spacer() .frame( height: geometry.size.height * 0.001)

                                Text("SQ3R") // Salto manual
                                    .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                    .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                    .lineLimit(2)
                            }
                        }
                    }
                    Spacer()
                        .frame( height: geometry.size.height * 0.04)

                    Text("Study Methods")
                        .font(.system(size: geometry.size.width * 0.05))
                        .fontWeight(.bold)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                        .foregroundColor(Color(hex: "#FCB608"))
                        .padding()
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.2)
                        .background(Color(hex: "#0797F2"))
                        .cornerRadius(20)
                        .offset(y: showText ? 0 : 100) // Controla la posición
                        .animation(.easeOut(duration: 1), value: showText)
                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height , alignment: .top) // Ajusta dimensiones
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                                       .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear { showText = true }
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
        
    }
}
#Preview {
    StudyView()
}
