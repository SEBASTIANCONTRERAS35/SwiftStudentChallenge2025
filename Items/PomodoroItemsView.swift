//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 26/01/25.
//

import SwiftUI

struct PomodoroItemsView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    @Environment(\.colorScheme) var colorScheme
    @State private var secondsAngle: Double = 0 // Ángulo de la manecilla de segundos
       @State private var minutesAngle: Double = 0 // Ángulo de la manecilla de minutos
       @State private var hoursAngle: Double = 0 // Ángulo de la manecilla de horas
    @State private var previousSecond: Int = 0 // Control del segundo previo para detectar reinicio
    @State private var currentTime = Date() // Hora actual para el reloj digital
    @State private var isSettingsOpen = false // Estado para abrir configuraciones
    @State private var isPomodoroActive: Bool = false
    @State private var isBreakActive: Bool = true
    @State private var isBreakLargeActive: Bool = true
    @State private var showStopConfirmation = false // Estado para mostrar el popover
    @State private var shadowIntensity: Double = 1 // Intensidad de la sombra
    @State private var isBlinking = false // Controla el parpadeo
    @State private var showPomodoroInfo = false // Estado para mostrar la PomodoroView
    @State private var remainingTime: Int = 0 // Tiempo restante en segundos
    @State private var lastAngleSecond: Double = 0
    @State private var lastAngleMinute: Double = 0
    @State private var NPomodors: Int = 0
    @State private var countdown: Int? = nil // Variable para el contador

       let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let blinkTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect() // Temporizador para parpadeo
    var workTimer: Int {
           (progressModel.lastPomodoroConfiguration?.workDuration ?? 25) * 60 // Convertir a segundos
       }

       var breakTimer: Int {
           (progressModel.lastPomodoroConfiguration?.breakDuration ?? 5) * 60 // Convertir a segundos
       }
    var breakLargeTimer: Int {
        (progressModel.lastPomodoroConfiguration?.breakLargeDuration ?? 30) * 60
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(colorScheme == .dark ? "Background2" : "Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack (alignment: .center){
                    HStack{
                        Text("Pomodoro")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, geometry.size.height * 0.05)
                       
                            .frame(width: geometry.size.width * 0.25)
                        Spacer()
                            .frame(width: geometry.size.width * 0.001)
                        Button(action: {
                                                  showPomodoroInfo = true
                                              }) {
                                                  Image(systemName: "questionmark.circle.fill")
                                                      .resizable()
                                                      .frame(width: geometry.size.width * 0.05, height: geometry.size.width * 0.05)
                                                      .foregroundColor(.blue)
                                                      .padding(.top, geometry.size.height * 0.05)
                                              }
                                              .sheet(isPresented: $showPomodoroInfo) {
                                                  PomodoroView().environmentObject(progressModel)
                                                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                                              }
                        Spacer()
                            .frame(width: geometry.size.width * 0.4)
                        Button(action: {
                                              isSettingsOpen = true
                                          }) {
                                              Image(systemName: "gearshape.fill")
                                                  .resizable()
                                                  .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                                  .foregroundColor(.green)
                                                  .padding(8)
                                                  
                                                  .cornerRadius(10)
                                                  .padding(.top, geometry.size.height * 0.05)
                                          }
                                          .popover(isPresented: $isSettingsOpen) {
                                              SettingsView()
                                                  .environmentObject(progressModel)
                                                  .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                                          }
                    }
                    .frame(width: geometry.size.width * 0.9,alignment: .leading)
                   
                    ZStack (alignment: .center){
                        Image("PomodoroWAnim")
                                                   .resizable()
                                                   .scaledToFit()
                                                   .frame(width: geometry.size.width * 0.6)
                        ZStack (alignment: .center) {
                            // Manecilla de horas (oculta cuando Pomodoro está activo)
                            if !isPomodoroActive {
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(
                                        width: geometry.size.width * 0.017, // Ancho relativo
                                        height: geometry.size.height * 0.075 // Altura relativa
                                    )
                                    .offset(y: -geometry.size.height * 0.04) // Ajusta la posición
                                    .rotationEffect(.degrees(hoursAngle)) // Ángulo de las horas
                                    .animation(.easeInOut(duration: 0.5), value: hoursAngle)
                            }

                            // Manecilla de minutos
                            Rectangle()
                                .fill(Color.white)
                                .frame(
                                    width: geometry.size.width * 0.008, // Ancho relativo
                                    height: geometry.size.height * 0.1 // Altura relativa
                                )
                                .offset(y: -geometry.size.height * 0.05) // Ajusta la posición
                                .rotationEffect(.degrees(minutesAngle)) // Ángulo de los minutos
                                .animation(.easeInOut(duration: 0.5), value: minutesAngle)

                            // Manecilla de segundos
                            Rectangle()
                                .fill(Color.green)
                                .frame(
                                    width: geometry.size.width * 0.006, // Ancho relativo
                                    height: geometry.size.height * 0.12 // Altura relativa
                                )
                                .offset(y: -geometry.size.height * 0.05) // Ajusta la posición
                                .rotationEffect(.degrees(secondsAngle)) // Ángulo de los segundos
                                .animation(.linear(duration: 1), value: secondsAngle)

                            // Centro del reloj
                            Circle()
                                .fill(Color.black)
                                .frame(width: geometry.size.width * 0.05, height: geometry.size.width * 0.05)
                            if let countdownValue = countdown {
                                ZStack {
                                    Color.black.opacity(0.8) // Fondo oscuro
                                        .ignoresSafeArea()
                                    
                                    Text("\(countdownValue)")
                                        .font(.system(size: geometry.size.width * 0.2, weight: .bold, design: .monospaced))
                                        .foregroundColor(.white)
                                        .transition(.scale) // Transición suave
                                }
                                .zIndex(1) // Asegura que esté sobre otros elementos
                            }

                        }
                        .onReceive(timer) { _ in
                            if isPomodoroActive {
                                updatePomodoroClock() // Usa el temporizador de Pomodoro
                            } else if (!isPomodoroActive && countdown == nil){
                                updateClock() // Usa el reloj normal
                            }
                        }
                        .offset(y: geometry.size.width * 0.042 )
                        .frame(width : geometry.size.width * 0.3, height: geometry.size.height * 0.2)
                        .onReceive(timer) { _ in
                            updateClock() // Animación rápida
                        }
                     
                        
                        
                    }
                    .frame(width: geometry.size.width * 0.9 , height: geometry.size.height * 0.5)
                 
                    if (!isPomodoroActive) {
                        // Mostrar la hora actual
                        Text(getFormattedTime()) // Hora actual
                            .font(.system(size: geometry.size.width * 0.12, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(20)
                            .shadow(color: .green.opacity(0.7), radius: 10, x: 0, y: 5)
                            .onReceive(timer) { _ in
                                currentTime = Date() // Actualizar la hora actual
                            }
                    } else {
                        ZStack {
                            if !isBreakLargeActive {
                                // Modo inactivo normal (Focus o Break)
                                Text(isBreakActive ? formatTime(workTimer) : formatTime(breakTimer)) // Tiempo del modo inactivo
                                    .font(.system(size: geometry.size.width * 0.08, weight: .bold, design: .monospaced))
                                    .foregroundColor(.gray)
                                    .padding()
                                    .background(Color.black.opacity(0.5)) // Fondo con opacidad reducida
                                    .cornerRadius(20)
                                    .offset(y: isBreakActive ? 40 : -20) // Mover según estado
                                    .zIndex(0) // Mantener detrás del tiempo activo
                                    .animation(.easeInOut(duration: 0.5), value: isBreakActive)

                                // Modo activo
                                Text(formatRemainingTime()) // Tiempo restante formateado
                                    .font(.system(size: geometry.size.width * 0.12, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.8)) // Fondo más opaco
                                    .cornerRadius(20)
                                    .shadow(color: isBreakActive ? .green.opacity(0.7) : .red.opacity(0.7), radius: 10, x: 0, y: 5)
                                    .offset(y: isBreakActive ? -20 : 40) // Mover según estado
                                    .zIndex(isBreakActive ? 1 : 0) // Traer al frente si está activo
                                    .animation(.easeInOut(duration: 0.5), value: isBreakActive)
                            } else {
                                // Modo Break Grande
                                Text(formatTime(progressModel.lastPomodoroConfiguration?.breakLargeDuration ?? 30 * 60)) // Tiempo del modo inactivo
                                    .font(.system(size: geometry.size.width * 0.08, weight: .bold, design: .monospaced))
                                    .foregroundColor(.gray)
                                    .padding()
                                    .background(Color.black.opacity(0.5)) // Fondo con opacidad reducida
                                    .cornerRadius(20)
                                    .offset(y: 40) // Posición fija para el modo Break Grande
                                    .zIndex(0) // Mantener detrás del tiempo activo
                                    .animation(.easeInOut(duration: 0.5), value: isBreakLargeActive)

                                Text(formatRemainingTime()) // Tiempo restante formateado
                                    .font(.system(size: geometry.size.width * 0.12, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.8)) // Fondo más opaco
                                    .cornerRadius(20)
                                    .shadow(color: isBreakActive ? .white.opacity(0.7) : .red.opacity(0.7), radius: 10, x: 0, y: 5)
                                    .offset(y: -20) // Posición fija para el tiempo activo
                                    .zIndex(1) // Traer al frente
                                    .animation(.easeInOut(duration: 0.5), value: isBreakLargeActive)
                            }
                        }
                        .onReceive(timer) { _ in
                            if remainingTime > 0 {
                                remainingTime -= 1 // Reducir tiempo restante
                            } else {
                                if (NPomodors==3){
                                    withAnimation(.easeInOut(duration : 1)){
                                        isBreakLargeActive = true
                                    }
                                   
                                }
                                if (isBreakActive){
                                    NPomodors += 1
                                    print ("Pomodoro: \(NPomodors)")
                                }
                                if (!isBreakLargeActive){
                                    togglePomodoroMode() // Alternar entre Focus y Break
                                }
                               
                            }
                        }
                    }
                    Spacer().frame(height: geometry.size.height * 0.04)
                    if (!isPomodoroActive) {
                        
                        Button(action: {
                            startCountdown() // Iniciar el contador antes del Pomodoro
                        }) {
                            Text("Start Pomodoro")
                                .font(.system(size: geometry.size.width * 0.05, weight: .bold, design: .monospaced))
                                .foregroundColor(Color(hex: "145410"))
                                .padding()
                                .background(Color.green.opacity(0.8))
                                .cornerRadius(20)
                                .shadow(color: .green.opacity(0.7), radius: 10, x: 0, y: 5)
                        }

                    }
                        if isPomodoroActive{
                            ZStack {
                                // Break activo
                                Text("Break")
                                    .font(.system(size: geometry.size.width * 0.05, weight: .bold, design: .monospaced))
                                    .foregroundColor(isBreakActive ? Color.green : Color.gray)
                                    .padding()
                                    .background(isBreakActive ? Color.white.opacity(0.8) : Color.gray.opacity(0.3)) // Fondo blanco si activo
                                    .cornerRadius(20)
                                    .shadow(color: .green.opacity(isBreakActive ? shadowIntensity : 0.2), radius: isBreakActive ? 15 : 5, x: 0, y: 5)
                                    .opacity(isBreakActive ? 1 : 0.3) // Más visible si activo
                                    .offset(y: isBreakActive ? 0 : 50) // Mover hacia abajo si no está activo
                                    .zIndex(isBreakActive ? 1 : 0) // Traer al frente si está activo
                                    .animation(.easeInOut(duration: isBreakActive ? 0.5 : 0.3), value: isBreakActive) // Animación suave

                                // Focus activo
                                Text("Focus")
                                    .font(.system(size: geometry.size.width * 0.05, weight: .bold, design: .monospaced))
                                    .foregroundColor(!isBreakActive ? Color.red : Color.gray)
                                    .padding()
                                    .background(!isBreakActive ? Color.white.opacity(0.8) : Color.gray.opacity(0.3)) // Fondo blanco si activo
                                    .cornerRadius(20)
                                    .shadow(color: .red.opacity(!isBreakActive ? shadowIntensity : 0.2), radius: !isBreakActive ? 15 : 5, x: 0, y: 5)
                                    .opacity(!isBreakActive ? 1 : 0.3) // Más visible si activo
                                    .offset(y: !isBreakActive ? 0 : 50) // Mover hacia abajo si no está activo
                                    .zIndex(!isBreakActive ? 1 : 0) // Traer al frente si está activo
                                    .animation(.easeInOut(duration: !isBreakActive ? 0.5 : 0.3), value: isBreakActive) // Animación suave
                            }
                            .onReceive(blinkTimer) { _ in
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    shadowIntensity = shadowIntensity == 0.7 ? 0.2 : 0.7 // Alterna entre intensidades para parpadeo
                                }
                            }
                            .animation(.easeInOut(duration: 0.5), value: isBreakActive) // Animación global
                                   
                            Spacer().frame(height: geometry.size.height * 0.04)
                            
                            Button(action: {
                                           showStopConfirmation = true
                                       }) {
                                           Text("Stop Pomodoro")
                                               .font(.system(size: geometry.size.width * 0.05, weight: .bold, design: .monospaced))
                                               .foregroundColor(Color (hex: "A80606"))
                                               .padding()
                                               .background(Color.red.opacity(0.8))
                                               .cornerRadius(20)
                                               .shadow(color: .red.opacity(0.7), radius: 10, x: 0, y: 5)
                                       }
                                       .popover(isPresented: $showStopConfirmation) {
                                                      VStack {
                                                          Text("Are you sure you want to stop?")
                                                              .font(.headline)
                                                              .padding(.bottom, 20)

                                                          HStack(spacing: 20) {
                                                              Button(action: {
                                                                  // Acción para confirmar detener
                                                                  isPomodoroActive = false
                                                                  showStopConfirmation = false
                                                              }) {
                                                                  Text("Yes, Stop")
                                                                      .font(.system(size: 18, weight: .bold))
                                                                      .foregroundColor(.white)
                                                                      .padding()
                                                                      .background(Color.red)
                                                                      .cornerRadius(10)
                                                              }

                                                              Button(action: {
                                                                  // Acción para cancelar
                                                                  showStopConfirmation = false
                                                              }) {
                                                                  Text("Cancel")
                                                                      .font(.system(size: 18, weight: .bold))
                                                                      .foregroundColor(.white)
                                                                      .padding()
                                                                      .background(Color.gray)
                                                                      .cornerRadius(10)
                                                              }
                                                          }
                                                      }
                                                      .padding()
                                                      .frame(width: 300, height: 200)
                                                  }
                         
                            
                        }
                    
                                           
                }
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height, alignment: .topLeading)
            }
            .frame(width : geometry.size.width ,height: geometry.size.height)
           
        }
    }
    private func startCountdown() {
        var timer: Timer? // Declaramos el temporizador como una variable local
        minutesAngle = 0
        secondsAngle = 0
        countdown = 3 // Inicia en 3
        var counter = 3

      timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async { // Asegúrate de que todas las modificaciones ocurran en el hilo principal
                counter -= 1
                countdown = counter

                if counter == 0 {
                    timer?.invalidate()
                    countdown = nil
                    withAnimation(.easeInOut(duration: 1)) {
                        isBreakActive = false
                        isPomodoroActive = true
                        remainingTime = isBreakActive ? breakTimer : workTimer
                    }
                }
            }
        }
    }
    private func formatRemainingTime() -> String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds) // Formato MM:SS
    }
    private func togglePomodoroMode() {
          isBreakActive.toggle()
          remainingTime = isBreakActive ? breakTimer : workTimer
      }
    private func formatTime(_ timeInSeconds: Int) -> String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    private func updateClock() {
        let calendar = Calendar.current
        let now = Date()

        // Obtener las unidades de tiempo actuales
        let seconds = calendar.component(.second, from: now)
        let minutes = Double(calendar.component(.minute, from: now))
        let hours = Double(calendar.component(.hour, from: now) % 12) // Ajustar para formato de 12 horas

        // Detectar si los segundos pasaron de 59 a 0 para hacer una rotación más rápida
        let fastRotation = seconds < previousSecond
        previousSecond = seconds // Actualizar el segundo previo

        withAnimation(fastRotation ? .linear(duration: 0.0001) : .linear(duration: 1)) {
            secondsAngle = Double(seconds) * 6 // Cada segundo son 6°
            minutesAngle = (minutes + Double(seconds) / 60) * 6 // Cada minuto son 6°, más la fracción de segundos
            hoursAngle = (hours + minutes / 60) * 30 // Cada hora son 30°, más la fracción de minutos
        }
        
    }
    private func getFormattedTime() -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "HH:mm:ss" // Formato de 24 horas
           return formatter.string(from: currentTime)
       }
    private func updatePomodoroClock() {
        secondsAngle = lastAngleSecond
        minutesAngle = lastAngleMinute
        // Determina cuántos segundos TOTales tiene la fase actual (work o break).
        let phaseTotalSeconds = isBreakActive ? breakTimer : workTimer
        
        // Cuánto hemos avanzado en la fase actual.
        // (ej. si te quedan 100s de un break de 300s, has avanzado 200s).
        let elapsedTime = phaseTotalSeconds - remainingTime

        // Calcula el porcentaje de progreso en la fase actual [0.0 ... 1.0].
        let fraction = Double(elapsedTime) / Double(phaseTotalSeconds)

        withAnimation(.linear(duration: 1)) {
            // 1) Actualizas la aguja de segundos (gira 360° cada 60s, si así lo deseas).
            secondsAngle = (Double(elapsedTime % 60) / 60.0) * 360.0

            // 2) Para la aguja de minutos, asigna el ángulo dependiendo de la fase:
            if isBreakActive {
                // En el descanso, la aguja va de 135° a 180° (45° totales).
                // 135° + (fraction * 45°).
                minutesAngle = 135.0 + (fraction * 45.0)
            } else {
                // En el trabajo, la aguja va de 0° a 135° (135° totales).
                // fraction * 135°.
                minutesAngle = fraction * 142.0
            }
        }
        lastAngleMinute = minutesAngle
        lastAngleSecond = secondsAngle
    }
}

    struct SettingsView: View {
        @Environment(\.dismiss) var dismiss
        @EnvironmentObject var progressModel: StarProgressModel

        @State private var workTimer: String = ""
        @State private var breakTimer: String = ""
        @State private var selectedSound: String = ""
        @State private var breakLargeTimer: String = ""

        let availableSounds = ["Default", "Chime", "Bell", "Ping", "None"]

        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Pomodoro Settings")) {
                        Picker("Select Sound", selection: $selectedSound) {
                            ForEach(availableSounds, id: \ .self) { sound in
                                Text(sound)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    Section(header: Text("Timers")) {
                        HStack {
                            Text("Work Timer (min):")
                                .fontWeight(.bold)
                            TextField("Enter minutes", text: $workTimer)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }

                        HStack {
                            Text("Break Timer (min):")
                                .fontWeight(.bold)
                            TextField("Enter minutes", text: $breakTimer)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack {
                            Text("Break Large Timer (min):")
                                .fontWeight(.bold)
                            TextField("Enter minutes", text: $breakLargeTimer)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                }
                .navigationTitle("Settings")
                .onAppear {
                    loadSettings()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            saveSettings()
                            dismiss()
                        }
                    }
                }
            }
        }

        private func loadSettings() {
            workTimer = String(progressModel.lastPomodoroConfiguration?.workDuration ?? 25)
            breakTimer = String(progressModel.lastPomodoroConfiguration?.breakDuration ?? 5)
            selectedSound = progressModel.lastPomodoroConfiguration?.sound ?? "Default"
            breakLargeTimer = String(progressModel.lastPomodoroConfiguration?.breakLargeDuration ?? 30)
        }

        private func saveSettings() {
            if let work = Int(workTimer), let breakTime = Int(breakTimer), let breakLargeTime = Int(breakLargeTimer){
                progressModel.lastPomodoroConfiguration = PomodoroConfiguration(
                    workDuration: work,
                    breakDuration: breakTime,
                    soundEffect: true,
                    sound: selectedSound,
                    breakLargeDuration: breakLargeTime
                )
            }
        }
    }


#Preview {
    PomodoroItemsView()
}
