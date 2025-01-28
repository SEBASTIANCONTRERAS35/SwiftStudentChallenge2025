import SwiftUI

struct MemorizationView: View {
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
                        // Botón 1: Loci
                        NavigationLink(destination: LociView().environmentObject(progressModel)) {
                            VStack {
                                Image("Loci")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                Spacer() .frame( height: geometry.size.height * 0.001)
                                Text("Loci") // Salto manual
                                    .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                    .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                    .lineLimit(2)
                            }
                        }
                        
                        Spacer() .frame( width: geometry.size.width * 0.25)
                        
                        // Botón 2: First Letter
                        NavigationLink(destination: FirstLetterView().environmentObject(progressModel)) {
                            VStack {
                                Image("FirstLetter")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                Text("First Letter") // Salto manual
                                    .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                    .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    // Botón 3: Chunking
                    NavigationLink(destination: ChunkingView().environmentObject(progressModel)) {
                        VStack {
                            Image("Chunking")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                            Text("Chunking") // Salto manual
                                .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                .lineLimit(2)
                        }
                    }
                    
                    Spacer()
                        .frame( height: geometry.size.height * 0.05)
                    
                    Text("Memorization Methods")
                        .font(.system(size: geometry.size.width * 0.05))
                        .fontWeight(.bold)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                        .foregroundColor(Color(hex: "#B01C1C"))
                        .padding()
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.2)
                        .background(Color(hex: "#FABC2E"))
                        .cornerRadius(20)
                        .offset(y: showText ? 0 : geometry.size.height * 0.2)
                        .animation(.easeOut(duration: 1), value: showText)
                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height, alignment: .top) // Ajusta dimensiones
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
    MemorizationView()
}
