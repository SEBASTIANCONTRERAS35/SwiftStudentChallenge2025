//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 07/01/25.
//

import SwiftUI
import UniformTypeIdentifiers
struct CornelExerciseView: View {
    @State private var CurrentlyOption: String? = nil
    @State private var dragOffset: CGSize = .zero
    @State private var options: [String] = ["""
The water cycle is a continuous movement of water within the Earth and atmosphere.
                                      
•    Evaporation: Water from oceans, lakes, and rivers turns into water vapor due to the heat of the sun.
                                      
•    Condensation: The water vapor cools and forms clouds in the atmosphere.
                                      
•    Precipitation: When clouds are saturated, water falls back to Earth in the form of rain, snow, or hail.
                                      
•    Infiltration: Water is absorbed by the soil, replenishing groundwater supplies.
""","""
•    What is the water cycle?
        
•    Evaporation process?
                             
•    What forms clouds?
                             
•    How does precipitation occur?
                             
•    What is infiltration?
                             
•    What happens to water after precipitation?
""","""
The water cycle describes the continuous movement of water between the Earth and atmosphere, driven by processes like evaporation, condensation, precipitation, and infiltration. Water evaporates from bodies of water, forms clouds, falls back to the Earth as precipitation, and eventually either infiltrates into the ground or flows over the surface as runoff. This cycle is vital for maintaining Earth’s water supply.                                     
"""]
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack(spacing: geometry.size.height * 0.05) {
                    ScrollView{
                        Text("Cornel")
                            .font(Font.custom("Chalkduster", size: geometry.size.width * 0.07)) // Fuente ChalkboardSE
                            .padding(.top, geometry.size.height * 0.02)
                        
                        Text(" Read the following reading and match each section where it should go on the sheet").multilineTextAlignment(.center)
                            .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico
                            .foregroundColor(.black) // Color del texto
                            .padding() // Espaciado interno del texto
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white) // Fondo blanco
                                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Sombra
                            )
                            .padding(.horizontal, geometry.size.width * 0.1) // Espaciado horizontal
                            .padding(.bottom, geometry.size.height * 0.05) // Espaciado inferior
                      
                            
                            
                            Text("The water cycle, also known as the hydrological cycle, is the continuous movement of water within the Earth and atmosphere. It involves various processes such as evaporation, condensation, precipitation, and infiltration. The cycle begins when water evaporates from bodies of water like oceans, lakes, and rivers due to the heat of the sun. This water vapor rises into the air and cools, leading to condensation, forming clouds. When the clouds become saturated, precipitation occurs in the form of rain, snow, or hail, returning the water to the Earth’s surface. Some of this water is absorbed by the soil (infiltration), while the rest flows over the ground as surface runoff, eventually making its way back to bodies of water, starting the cycle again.")
                                .font(.system(size: geometry.size.width * 0.03, weight: .thin, design: .serif)) // Ajuste en el tamaño y tipo de letra
                                .multilineTextAlignment(.leading)
                                .lineSpacing(5) // Espaciado entre líneas
                                .padding(20) // Espaciado interno
                                .foregroundColor(.black) // Color del texto
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.5)]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1) // Borde del rectángulo
                                    }
                                )
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10) // Sombra más suave
                                .padding(.horizontal, geometry.size.width * 0.08) // Espaciado horizontal
                                .frame(height: geometry.size.height * 0.6) // Ajusta la altura del contenedor
                                .padding(.bottom, geometry.size.height * 0.05) // Espaciado inferior
                            // Spacer().frame(height: geometry.size.height * 0.3)
                            HStack{
                                HStack {
                                    ForEach(options, id: \.self) { option in
                                        Text(option)
                                            .font(.system(size: geometry.size.width * 0.02)) // Tamaño dinámico
                                            .foregroundColor(.black) // Color del texto
                                            .padding(5) // Espaciado interno del texto
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color.white) // Fondo blanco
                                                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Sombra
                                            )
                                            .frame(width: geometry.size.width * 0.25)
                                            .offset(option == CurrentlyOption ? dragOffset : .zero) // Mover solo el que se arrastra
                                            .gesture(
                                                DragGesture()
                                                    .onChanged { gesture in
                                                        CurrentlyOption = option // Establece el texto que se está arrastrando
                                                        dragOffset = gesture.translation // Cambia el desplazamiento según el arrastre
                                                    }
                                                    .onEnded { _ in
                                                        dragOffset = .zero // Resetea la posición después del arrastre
                                                        CurrentlyOption = nil // Limpia el texto actual
                                                    }
                                            )
                                    }
                                }
                             
                                    .frame(width:geometry.size.width * 0.9 ,alignment : .center)
                               
                                
                            }
                            .frame(width:geometry.size.width * 0.9 ,alignment : .center)
                            
                            Image("Cornel1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.height * 0.4)
                        }
                        
                    }
                } .padding()
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height*0.95, alignment: .center) // Alinea al tope
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Asegura que todo esté alineado arriba
            }
           
        }
    }
struct Option{
    var text: String
    var valueO: Int
}
struct AreaAnswer{
    let content: String // El texto del componente
       let valueA: Int
}
#Preview {
    CornelExerciseView()
}


