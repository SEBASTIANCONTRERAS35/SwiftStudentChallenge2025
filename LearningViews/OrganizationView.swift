//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 30/12/24.
//

import SwiftUI

struct OrganizationView: View {
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
                        Button(action: {
                            print("Organization Methods button tapped!")
                        }) {
                            NavigationLink(destination: EisenhowerView().environmentObject(progressModel) ) {
                                
                                VStack {
                                    Image("EisenHower")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                    Spacer() .frame( height: geometry.size.height * 0.001)
                                    
                                    Text("EisenHower") // Salto manual
                                        .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                        .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                        .multilineTextAlignment(.center)
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                        .lineLimit(2)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer() .frame( width: geometry.size.width * 0.25)
                        Button(action: {
                            print("Study Methods button tapped!")
                        }) {
                            NavigationLink (destination: KanbanView().environmentObject(progressModel) ) {
                                
                                
                                VStack {
                                    Image("Kanban")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                    Spacer() .frame( height: geometry.size.height * 0.001)
                                    
                                    Text("Kanban") // Salto manual
                                        .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                        .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                        .multilineTextAlignment(.center)
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                        .lineLimit(2)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    HStack() {
                        Button(action: {
                            print("Organization Methods button tapped!")
                        }) {
                            NavigationLink (destination: GtdView().environmentObject(progressModel) ) {
                                VStack {
                                    Image("GTD")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                    Spacer() .frame( height: geometry.size.height * 0.001)
                                    
                                    Text("GTD") // Salto manual
                                        .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                        .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                        .multilineTextAlignment(.center)
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                        .lineLimit(2)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer() .frame( width: geometry.size.width * 0.25)
                        Button(action: {
                            print("Study Methods button tapped!")
                        }) {
                            NavigationLink (destination: IvyLeeView().environmentObject(progressModel) ) {
                                VStack {
                                    Image("Ivy Lee")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                                    Spacer() .frame( height: geometry.size.height * 0.001)
                                    
                                    Text("Ivy Lee") // Salto manual
                                        .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .serif))
                                        .foregroundColor(Color.primary) // Cambia automáticamente entre negro y blanco
                                        .multilineTextAlignment(.center)
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                                        .lineLimit(2)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                        .frame( height: geometry.size.height * 0.05)
                    
                    
                    Text("Organization Methods")
                        .font(.system(size: geometry.size.width * 0.05))
                        .fontWeight(.bold)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                        .foregroundColor(Color(hex: "#03F34F"))
                        .padding()
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.2)
                        .background(Color(hex: "#8804B8"))
                        .cornerRadius(20)
                        .offset(y: showText ? 0 : 100)
                        .animation(.easeOut(duration: 1), value: showText)
                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height , alignment: .top) // Ajusta dimensiones
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                                       .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear {showText = true}
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
    OrganizationView()
}
