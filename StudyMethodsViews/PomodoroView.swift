import SwiftUI

struct PomodoroView: View {
    @State private var currentFrame1 = 0 // Frame actual para la primera animación
        @State private var currentFrame2 = 0 // Frame actual para la segunda animación
        @State private var currentFrame3 = 0 // Frame actual para la tercera animación
        @State private var currentFrame4 = 0 // Frame actual para la cuarta animación
        @State private var currentFrame5 = 0
    @State private var showDetails = false
    @State private var Pomodoros = false
    @State private var shouldAnimateScale2 = false // Variable para controlar la animación
    @State private var shouldAnimateScale3 = false
    @State private var shouldAnimateScale4 = false
    @State private var shouldAnimateScale5 = false
    @State private var shouldAnimateOpa2 = false
    @State private var shouldAnimateOpa3 = false
    @State private var shouldAnimateOpa4 = false
    @State private var shouldAnimateOpa5 = false
    @State private var completed=false;
    private let totalFrames = 120 // Número total de imágenes en tu animación
    private let frameDuration = 0.03 // Duración de cada frame (en segundos)
    @State private var currentStep = 1 // Comienza con todo visible desde el paso 2
    private let totalSteps = 6 // Número total de pasos
    @Environment(\.presentationMode) var presentationMode // Permite navegar hacia atrás
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @EnvironmentObject var progressModel: StarProgressModel
    @State private var notificationOffset: CGFloat = -800 // Valor inicial fuera de la pantalla
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack(spacing: geometry.size.height * 0.05) {
                    Text("Pomodoro")
                        .font(Font.custom("Rockwell-bold", size: geometry.size.width * 0.15)) // Fuente ChalkboardSE
                        .padding(.top, geometry.size.height * 0.07)
                    if (showDetails){
                        
                        Image(String(format: "Pomodoro_%05d", currentFrame1))
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4) // Mantén las dimensiones del marco
                            .scaleEffect(2.8) // Aumenta la escala de la imagen
                            .onAppear {
                                startAnimation1() // Inicia la animación al cargar la vista
                            }.opacity(currentStep >= 6 || currentStep <= 4 ? 1 : 0.2) //
                            .animation(.easeInOut(duration: 0.5), value: currentStep)
                        Spacer().frame(height: geometry.size.height*0.005)
                        if (Pomodoros){
                            HStack (spacing: geometry.size.height * 0.016){
                                Image(String(format: "Pomodoro_%05d", currentFrame2))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2) // Mantén las dimensiones del marco
                                    .scaleEffect(shouldAnimateScale2  ? 4.3 : 3.5) // Escala condicional
                                    .opacity(shouldAnimateOpa2 ? 1 : 0.2) //

                                    .onAppear {
                                        startAnimation2() // Inicia la animación al cargar la vista
                                    }
                                Image(String(format: "Pomodoro_%05d", currentFrame3))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2) // Mantén las dimensiones del marco
                                    .opacity((shouldAnimateOpa3 || completed) ? 1 : 0.2) // Controla la opacidad

                                    .scaleEffect(shouldAnimateScale3 ? 4.3 : 3.5) // Escala condicional

                                Image(String(format: "Pomodoro_%05d", currentFrame4))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2) // Mantén las dimensiones del marco
                                    .opacity(shouldAnimateOpa4 ? 1 : 0.2) //

                                    .scaleEffect(shouldAnimateScale4 ? 4.3 : 3.5) // Controla la escala
                                Image(String(format: "Pomodoro_%05d", currentFrame5))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2) // Mantén las dimensiones del marco
                                    .opacity(shouldAnimateOpa5 ? 1 : 0.2) //

                                    .scaleEffect(shouldAnimateScale5 ? 4.3 : 3.5) // Escala condicional

                                
                            }
                            .padding()
                            .frame(width: geometry.size.width*0.88,  alignment: .center)
                            
                        }
                        
                    }else{
                        Text("""
               The Pomodoro Technique is a time management method.
               
                It helps improve focus and productivity by breaking work into manageable intervals (called “Pomodoros”) with short breaks in between.
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
                
                .padding()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height*0.95, alignment: .center) // Alinea al tope
                .background(
                    Image(colorScheme == .dark ? "Background2" : "Background")
                                       .resizable()
                )
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Asegura que todo esté alineado arriba
                VStack(spacing: 15) {
                    Image("StarStudy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80) // Tamaño de la imagen
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // Sombra sutil

                    Text("You've just earned a Study Star!")
                        .font(.headline) // Fuente llamativa pero profesional
                        .multilineTextAlignment(.center) // Alineación centrada
                        .foregroundColor(Color.white) // Texto en blanco
                        .padding(.horizontal, 20) // Espaciado interno para que el texto no esté pegado a los bordes
                }
                
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.9)) // Fondo azul semi-transparente
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
                Spacer().frame(height: geometry.size.height * 0.05) // Altura dinámica del primer Spacer
                if(showDetails){
                    Text("Select a specific task you want to work on and set a timer for 25 minutes.")
                        .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.1)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20)
                       .opacity((currentStep == 2) ? 1 : 0) // Cambia opacidad
                    
                    Spacer().frame(height: geometry.size.height * 0.05) // Altura dinámica del segundo Spac
                    
                    VStack {
                        Text("""
Focus exclusively on the task for those 25 minutes without distractions.
• If an interruption occurs, jot it down quickly to handle it later.
""")
                            .font(.system(size: geometry.size.width * 0.025)) // Tamaño dinámico de fuente
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(20)
                            .frame(width: geometry.size.width*0.55, height:geometry.size.height*0.15)
                            .opacity((currentStep == 3) ? 1 : 0) // Cambia opacida
                        
                        Spacer().frame(height: geometry.size.height * 0.0001) // Altura dinámica del espaciador interno
                        
                        Text("When the timer rings, stop working and take a 5-minute break.")
                            .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(20)
                            .frame(width: geometry.size.width*0.4, height:geometry.size.height*0.15)
                            .opacity((currentStep == 4) ? 1 : 0) // Cambia opacidad
                    }
                    .frame(width: geometry.size.width, alignment: .leading) // Asegura que el VStack use todo el ancho disponible
                    
                    Spacer().frame(height: geometry.size.height * 0.001) // Altura dinámica del tercer Spacer
                    
                    Text("After completing four Pomodoros (100 minutes of work and 15 minutes of short breaks in total), take a longer break of 15–30 minutes.")
                        .font(.system(size: geometry.size.width * 0.03)) // Tamaño dinámico de fuente
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20)
                        .frame(width: geometry.size.width*0.5, height:geometry.size.height*0.2)
                        .opacity((currentStep == 5) ? 1 : 0) // Cambia opacidad
                    
                    
                    
                }
                    
            }
           
        }
           
        .onTapGesture {
            currentStep+=1
            if currentStep > 1  {
                withAnimation(.easeInOut(duration: 1)) { // Animación lenta al ocultar descripción
                    showDetails = true
                }
                
            }
            if (currentStep>=5){
                withAnimation(.easeInOut(duration: 1)) { // Animación lenta al ocultar descripción
                    Pomodoros = true
                }
            }
        }
        .onChange(of: currentStep) { newValue in
            if (newValue == 6 && !progressModel.star1CompleteStudy){
                progressModel.star1CompleteStudy = true // Actualiza el estado
          
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
    }
    
    private func startAnimation1() {
        Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { timer in
            DispatchQueue.main.async {
                currentFrame1 += 1
                if currentFrame1 >= totalFrames {
                    currentFrame1 = 0 // Reinicia la animación
                }
            }
        }
    }

    private func startAnimation2() {
        var timer: Timer? // Variable para almacenar el temporizador
        shouldAnimateOpa2=true
        timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                                    shouldAnimateScale2=true // Activa o desactiva la animación al aparecer
                                }
                currentFrame2 += 1
                if currentFrame2 >= totalFrames {
                    currentFrame2 = 0
                    withAnimation(.easeInOut(duration: 0.5)) {
                                        shouldAnimateScale2=false // Activa o desactiva la animación al aparecer
                                    }
                    timer?.invalidate() // Detener el temporizador
                    startAnimation3() // Inicia la tercera animación
                }
            }
        }
    }

    private func startAnimation3() {
        var timer: Timer? // Variable para almacenar el temporizador
        shouldAnimateOpa3=true
        timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                                    shouldAnimateScale3=true // Activa o desactiva la animación al aparecer
                                }
                currentFrame3 += 1
                if currentFrame3 >= totalFrames {
                    currentFrame3 = 0
                    withAnimation(.easeInOut(duration: 0.5)) {
                        shouldAnimateScale3=false // Activa o desactiva la animación al aparecer
                                    }
                    timer?.invalidate() // Detener el temporizador
                    startAnimation4() // Iniciar la siguiente animación
                }
            }
        }
    }

    private func startAnimation4() {
        var timer: Timer? // Declaramos el temporizador como una variable local
        shouldAnimateOpa4=true
        timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                                    shouldAnimateScale4=true // Activa o desactiva la animación al aparecer
                                }
                currentFrame4 += 1
                if currentFrame4 >= totalFrames {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        shouldAnimateScale4=false // Activa o desactiva la animación al aparecer
                                    }
                    currentFrame4 = 0
                    timer?.invalidate() // Detener el temporizador
                    startAnimation5() // Iniciar la siguiente animación
                }
            }
        }
    }

    private func startAnimation5() {
        var timer: Timer? // Declaramos el temporizador como una variable local
        shouldAnimateOpa5=true
        timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                               shouldAnimateScale5 = true
                           }
                currentFrame5 += 1
                if currentFrame5 >= totalFrames {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        shouldAnimateScale5 = false
                               }
                    currentFrame5 = 0
                    timer?.invalidate() // Detiene el temporizador
                    completed=true;
                    startAnimation2() // Reinicia el ciclo con la primera animación
                }
            }
        }
    }
}

#Preview {
    PomodoroView()
}
 
