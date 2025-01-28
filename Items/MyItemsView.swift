//
//  MyItemsView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 24/01/25.
//


import SwiftUI
struct MyItemsView: View {
    let sampleMilestones = [
        Milestone(x: 0.1, y: 1, title: "Start"),
        Milestone(x: 0.3, y: 0.85, title: "Task 1"),
        Milestone(x: 0.5, y: 0.55, title: "Task 2"),
        Milestone(x: 0.9, y: 0.4, title: "Task 3"),
        Milestone(x: 0.5, y: 0.3, title: "Task 4"),
        Milestone(x: 0.2, y: 0.2, title: "Task 5"),
        Milestone(x: 0.5, y: -0.6, title: "Goal")
    ]
    @State private var isShowingSheet: Bool = false
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var isShowingChunkingSheet: Bool = false // Estado para controlar el sheet
    @State private var isShowingPomodoroSheet: Bool = false
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack {
                    ScrollView{
                        Spacer().frame(height: geometry.size.height * 0.15)
                        
                        HStack(alignment: .top) {
                            RoadmapView(milestones: sampleMilestones)
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                            
                            VStack{
                                Text ("Today Tasks")
                                    .font(.system(size: geometry.size.width * 0.05, weight: .bold, design: .default))
                                
                            }
                            .frame(width: geometry.size.width * 0.4)
                        }
                        Spacer().frame(height: geometry.size.height * 0.2)
                        Text ("Put your tasks here")
                            .font(.system(size: geometry.size.width * 0.06, weight: .light, design: .default))
                        Button(action: {
                            isShowingSheet = true // Asegúrate de que este cambio de estado sea correcto
                        }) {
                            VStack {
                                Image("Items")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.2)
                                Text("Your tasks")
                                    .font(.system(size: geometry.size.width * 0.03))
                                    .foregroundStyle(Color.primary)
                            }
                            .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.25)
                            .background(colorScheme == .dark ? Color.gray.opacity(0.9) : Color.white.opacity(0.9))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4)
                        }
                        // Aquí vinculamos el botón con una hoja
                        .fullScreenCover(isPresented: $isShowingSheet) {
                            NavigationView {
                                YourTasksView()
                                    .navigationTitle("Your Tasks")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button("Close") {
                                                isShowingSheet = false
                                            }
                                        }
                                    }
                            }
                            .environmentObject(StarProgressModel()) // Pasamos el objeto de entorno
                            .navigationViewStyle(StackNavigationViewStyle())
                        }
                        Text ("Organize your tasks")
                            .font(.system(size: geometry.size.width * 0.06, weight: .light, design: .default))
                        HStack{
                            Button(action: {
                                print("Hola")
                            }) {
                                VStack {
                                    Image("Ivy Lee")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.2)
                                    Text("Ivy Lee")
                                        .font(.system(size: geometry.size.width * 0.03))
                                        .foregroundStyle(Color.primary)
                                }
                                .frame(width: geometry.size.width * 0.18, height: geometry.size.height * 0.25)
                                .background(colorScheme == .dark ? Color.gray.opacity(0.9) : Color.white.opacity(0.9))                                .cornerRadius(10) // Bordes redondeados
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4) // Sombra
                            }
                            Button(action: {
                               
                            }) {
                                VStack {
                                    Image("EisenHower")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.2)
                                    Text("Eisenhower")
                                        .font(.system(size: geometry.size.width * 0.03))
                                        .foregroundStyle(Color.primary)
                                }
                                .frame(width: geometry.size.width * 0.18, height: geometry.size.height * 0.25)
                                .background(colorScheme == .dark ? Color.gray.opacity(0.9) : Color.white.opacity(0.9)) // Fondo blanco ligeramente opaco
                                .cornerRadius(10) // Bordes redondeados
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4) // Sombra
                            }
                            Button(action: {
                               
                            }) {
                                VStack {
                                    Image("Kanban")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.2)
                                    Text("Kanban")
                                        .font(.system(size: geometry.size.width * 0.03))
                                        .foregroundStyle(Color.primary)
                                }
                                .frame(width: geometry.size.width * 0.18, height: geometry.size.height * 0.25)
                                .background(colorScheme == .dark ? Color.gray.opacity(0.9) : Color.white.opacity(0.9))                                .cornerRadius(10) // Bordes redondeados
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4) // Sombra
                            }
                        }
                        Text ("Use your study methods")
                            .font(.system(size: geometry.size.width * 0.06, weight: .light, design: .default))
                        HStack{
                            Button(action: {
                                isShowingPomodoroSheet = true
                            }) {
                                VStack {
                                    Image("Pomodoro")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.2)
                                    Text("Pomodoro")
                                        .font(.system(size: geometry.size.width * 0.03))
                                        .foregroundStyle(Color.primary)
                                }
                                .frame(width: geometry.size.width * 0.18, height: geometry.size.height * 0.25)
                                .background(colorScheme == .dark ? Color.gray.opacity(0.9) : Color.white.opacity(0.9))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4)
                            }
                            .fullScreenCover(isPresented: $isShowingPomodoroSheet) {
                                PomodoroItemsView() // Vista completa de Pomodoro
                                    .environmentObject(progressModel) // Asegúrate de pasar el modelo de entorno
                            }
                            Button(action: {
                                isShowingChunkingSheet = true // Cambia el estado a true para mostrar el sheet
                            }) {
                                VStack {
                                    Image("Chunking")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.2)
                                    Text("Chunking")
                                        .font(.system(size: geometry.size.width * 0.03))
                                        .foregroundStyle(Color.primary)
                                }
                                .frame(width: geometry.size.width * 0.18, height: geometry.size.height * 0.25)
                                .background(colorScheme == .dark ? Color.gray.opacity(0.9) : Color.white.opacity(0.9))
                                .cornerRadius(10) // Bordes redondeados
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4) // Sombra
                            }
                            .sheet(isPresented: $isShowingPomodoroSheet) {
                                PomodoroItemsView() // Muestra la vista de ChunkingItemsView
                                    .environmentObject(progressModel) // Asegúrate de pasar el modelo de entorno
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.95) // Ajusta dimensiones
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                        .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        
    }
    
}

#Preview {
    MyItemsView()        .environmentObject(StarProgressModel()) // Asegúrate de inicializarlo en las vistas
      
}
