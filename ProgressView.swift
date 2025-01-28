//
//  SwiftUIView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 22/01/25.
//

import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    @Environment(\.colorScheme) var colorScheme // Detecta el modo del sistema (claro u oscuro)
    @State private var levitateTie: Bool = false
    @State private var levitateGlass: Bool = false
    @State private var levitateHat: Bool = false
    @State  var currentPenguinFrame: Int = 0 // Frame actual de la animación

    // Simulación del progreso diario
    @State private var progressData: [Date: (pomodoro: Int, eisenhower: Int, ivyLee: Int)] = {
        var data: [Date: (Int, Int, Int)] = [:]
        let calendar = Calendar.current
        let today = Date()
        
        // Generar datos simulados para los últimos 30 días
        for i in -15...15 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                data[date] = (pomodoro: Int.random(in: 0...5), eisenhower: Int.random(in: 0...3), ivyLee: Int.random(in: 0...4))
            }
        }
        return data
    }()
    
    @State private var selectedDate: Date = Date() // Fecha seleccionada por el usuario
    
    var body: some View {
        GeometryReader { geometry in
                ZStack {
                    VStack {
                        ScrollView {
                            CalendarView(
                                                        progressData: progressModel.progressData, // Usamos progressModel
                                                        selectedDate: $selectedDate
                                                    )
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
                            .cornerRadius(15)
                        HStack (spacing: geometry.size.width * 0.3){
                            
                            
                            VStack(spacing: geometry.size.height * 0.005) {
                                Text("Summary of activities in:")
                                    .font(.headline)
                                Text(formatDate(selectedDate))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                BarChartView(data: progressData[selectedDate] ?? (0, 0, 0))
                                    .frame(height: 200)
                            }
                            VStack{
                                Text("Number")
                                Text("Days of streak")
                            }
                        }
                            Image("PinguinoAnimacion_\(String(format: "%05d", currentPenguinFrame))")
                                .resizable()
                                .scaledToFit()
                             
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.35)
                                .scaleEffect(1.5) // Escala la imagen 1.5 veces su tamaño original
                                .onAppear {
                                    startPenguinAnimation()
                                }
                                .overlay(
                                    ZStack {
                                        Image("Tie")
                                            .resizable() // Permite ajustar el tamaño de la imagen
                                            .scaledToFit() // Mantiene la proporción de la imagen
                                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.1) // Ajusta el tamaño de la imagen
                                            .offset(x: geometry.size.width * 0.01, y: geometry.size.height * 0.03) // Dinámico basado en el
                                            .opacity(
                                                progressModel.star1CompleteOrga &&
                                                progressModel.star2CompleteOrga &&
                                                progressModel.star3CompleteOrga &&
                                                progressModel.star4CompleteOrga ? 1 : 0
                                            )
                                        Image("Glass")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.1)
                                            .offset(x: geometry.size.width * 0.01, y: geometry.size.height * -0.06) // Dinámico basado en el
                                            .opacity(
                                                progressModel.star1CompleteStudy &&
                                                progressModel.star2CompleteStudy &&
                                                progressModel.star3CompleteStudy &&
                                                progressModel.star4CompleteStudy ? 1 : 0
                                            )

                                        Image("Hat")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.1)
                                            .offset(x: geometry.size.width * 0.005, y: geometry.size.height * -0.12) // Dinámico basado en el
                                            .opacity(
                                                progressModel.star1CompleteMemo &&
                                                progressModel.star2CompleteMemo &&
                                                progressModel.star3CompleteMemo ? 1 : 0
                                            )

                                    }
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.15)
                                  
                                )
                        VStack(alignment: .leading) {
                            Text("Study Methods")
                                .font(.title)
                                .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                                .fontWeight(.bold)
                                .frame(width: geometry.size.width * 0.9,height: geometry.size.height * 0.07)
                                .background(colorScheme == .dark ? Color.white.opacity(0.8): Color.black.opacity(0.8))
                            HStack(spacing: geometry.size.width * 0.1) {
                                Star(Nstar: 1, imageIncomplete: Image("StarStudyW"), imageComplete: Image("StarStudy"), isComplete: $progressModel.star1CompleteStudy)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                Star(Nstar: 2, imageIncomplete: Image("StarStudyW"), imageComplete: Image("StarStudy"), isComplete: $progressModel.star2CompleteStudy)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                Star(Nstar: 3, imageIncomplete: Image("StarStudyW"), imageComplete: Image("StarStudy"), isComplete: $progressModel.star3CompleteStudy)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                Star(Nstar: 4, imageIncomplete: Image("StarStudyW"), imageComplete: Image("StarStudy"), isComplete: $progressModel.star4CompleteStudy)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)

                                // Mostrar "Glass" o "?" según el estado de las estrellas
                                if progressModel.star1CompleteStudy &&
                                    progressModel.star2CompleteStudy &&
                                    progressModel.star3CompleteStudy &&
                                    progressModel.star4CompleteStudy {
                                    Image("Glass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                        .offset(y: levitateGlass ? -10 : 10)
                                        .animation(
                                            Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                            value: levitateGlass
                                        )
                                        .onAppear {
                                            levitateGlass = true
                                        }
                                } else {
                                    Text("?")
                                        .font(.system(size: geometry.size.width * 0.1))
                                        .foregroundColor(.gray)
                                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                        .transition(.scale) // Animación suave
                                }
                            }
                            
                            
                            
                        }
                        .frame(width: geometry.size.width * 0.9, alignment: .leading)
                        .border(Color.primary, width: 1) // Agrega un borde azul de grosor 2
                        .cornerRadius(10) // Bordes redondeados
                        VStack(alignment: .leading) {
                            Text("Organization Methods")
                                .font(.title)
                                .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                                .fontWeight(.bold)
                                .frame(width: geometry.size.width * 0.9,height: geometry.size.height * 0.07)
                                .background(colorScheme == .dark ? Color.white.opacity(0.8): Color.black.opacity(0.8))
                            HStack (spacing: geometry.size.width * 0.1){
                                Star(Nstar: 1, imageIncomplete: Image("StarOrgaW"), imageComplete: Image("StarOrga"),isComplete: $progressModel.star1CompleteOrga)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                Star(Nstar: 2, imageIncomplete: Image("StarOrgaW"), imageComplete: Image("StarOrga"),isComplete: $progressModel.star2CompleteOrga)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                Star(Nstar: 3, imageIncomplete: Image("StarOrgaW"), imageComplete: Image("StarOrga"),isComplete: $progressModel.star3CompleteOrga)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                Star(Nstar: 4, imageIncomplete: Image("StarOrgaW"), imageComplete: Image("StarOrga"),isComplete: $progressModel.star4CompleteOrga)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                
                                if progressModel.star1CompleteOrga &&
                                    progressModel.star2CompleteOrga &&
                                    progressModel.star3CompleteOrga &&
                                    progressModel.star4CompleteOrga {
                                    Image("Tie")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                        .offset(y: levitateHat ? -10 : 10)
                                        .animation(
                                            Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                            value: levitateHat
                                        )
                                        .onAppear {
                                            levitateHat = true
                                        }
                                } else {
                                    Text("?")
                                        .font(.system(size: geometry.size.width * 0.1))
                                        .foregroundColor(.gray)
                                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                        .transition(.scale) // Animación suave
                                }
                                
                            }
                            
                            
                        }
                        .frame(width: geometry.size.width * 0.9, alignment: .leading)
                        .border(Color.primary, width: 1) // Agrega un borde azul de grosor 2
                        .cornerRadius(10) // Bordes redondeados
                        
                        VStack(alignment: .leading) {
                            Text("Memorization Methods")
                                .font(.title)
                                .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                                .fontWeight(.bold)
                                .frame(width: geometry.size.width * 0.9,height: geometry.size.height * 0.07)
                                .background(colorScheme == .dark ? Color.white.opacity(0.8): Color.black.opacity(0.8))
                            HStack (spacing: geometry.size.width * 0.15){
                                Star(Nstar: 1, imageIncomplete: Image("StarMemoW"), imageComplete: Image("StarMemo"),isComplete: $progressModel.star1CompleteMemo)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                Star(Nstar: 2, imageIncomplete: Image("StarMemoW"), imageComplete: Image("StarMemo"),isComplete: $progressModel.star2CompleteMemo)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                Star(Nstar: 3, imageIncomplete: Image("StarMemoW"), imageComplete: Image("StarMemo"),isComplete: $progressModel.star3CompleteMemo)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                               
                                
                                if progressModel.star1CompleteMemo &&
                                    progressModel.star2CompleteMemo &&
                                    progressModel.star3CompleteMemo{
                                    Image("Hat")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                        .offset(y: levitateTie ? -10 : 10)
                                        .animation(
                                            Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                            value: levitateTie
                                        )
                                        .onAppear {
                                            levitateTie = true
                                        }
                                } else {
                                    Text("?")
                                        .font(.system(size: geometry.size.width * 0.1))
                                        .foregroundColor(.gray)
                                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.06)
                                        .transition(.scale) // Animación suave
                                }
                                
                            }
                            
                            
                        }
                        .frame(width: geometry.size.width * 0.9, alignment: .leading)
                        .border(Color.primary, width: 1) // Agrega un borde azul de grosor 2
                        .cornerRadius(10) // Bordes redondeados
                        
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height*0.95, alignment: .top) // Alinea al tope
                    .background(
                        Image(colorScheme == .dark ? "Background2" : "Background")
                            .resizable()
                    )
                    .cornerRadius(15)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Asegura que
                }
                
            }
        }
    }
    
    // Formatear la fecha seleccionada
    private func formatDate(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    private func startPenguinAnimation() {
        DispatchQueue.global().async {
            while true {
                for frame in 0..<14 {
                    DispatchQueue.main.async {
                        currentPenguinFrame = frame
                    }
                    Thread.sleep(forTimeInterval: 0.1) // Duración por frame
                }
                // Pausa de 5 segundos al final de la animación
                Thread.sleep(forTimeInterval: 1.5)
            }
        }
    }
  
}


struct Star: View {
    let Nstar: Int
       let imageIncomplete: Image
       let imageComplete: Image
    @Binding  var isComplete: Bool
    var body: some View {
        GeometryReader { geometry in
            (isComplete ? imageComplete : imageIncomplete)
                .resizable()
                .scaledToFit()
        }
        
    }
}
struct CalendarView: View {
    let progressData: [Date: (pomodoro: Int, eisenhower: Int, ivyLee: Int)]
    @Binding var selectedDate: Date
    
    // Maneja el mes/año que se está mostrando actualmente.
    @State private var displayedMonth: Date = firstDayOfCurrentMonth()

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 7)

    var body: some View {
        VStack {
            // Barra de navegación para cambiar de mes
            HStack(spacing: 20) {
                Button(action: {
                    displayedMonth = previousMonth(for: displayedMonth)
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Text(monthYearString(for: displayedMonth))
                    .font(.headline)
                
                Button(action: {
                    displayedMonth = nextMonth(for: displayedMonth)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.bottom, 5)

            // La cuadrícula con los días del mes
            LazyVGrid(columns: columns, spacing: 5) {
                // Encabezado de días de la semana
                ForEach(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }

                // Días del mes mostrado (displayedMonth)
                let days = daysInMonth(for: displayedMonth)
                ForEach(days, id: \.self) { date in
                    if let validDate = date {
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(progressColor(for: validDate))
                                    .frame(width: 30, height: 30)
                                    .onTapGesture {
                                        // Solo permitir interacción con días pasados o actuales
                                        if isPastOrToday(date: validDate) {
                                            selectedDate = validDate
                                        }
                                    }
                                    .overlay(
                                        Circle()
                                            .stroke(
                                                selectedDate == validDate ? Color.blue : Color.clear,
                                                lineWidth: 2
                                            )
                                    )
                                    .opacity(isPastOrToday(date: validDate) ? 1.0 : 0.3)
                                
                                Text(dayNumber(for: validDate))
                                    .font(.subheadline)
                                    .foregroundColor(isPastOrToday(date: validDate) ? .white : .gray)
                            }
                        }
                    } else {
                        Spacer() // Espacio vacío para rellenar huecos de la rejilla
                    }
                }
            }
        }
    }
    
    // MARK: - Helpers para calcular días y formatear
    
    /// Devuelve un array de fechas opcionales del mes de `monthDate`, con huecos vacíos al comienzo.
    private func daysInMonth(for monthDate: Date) -> [Date?] {
        guard
            let range = calendar.range(of: .day, in: .month, for: monthDate),
            let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: monthDate))
        else {
            return []
        }
        
        var days: [Date?] = []
        
        // Agregar días vacíos antes del inicio del mes
        if let weekday = calendar.dateComponents([.weekday], from: monthStart).weekday {
            // En muchos calendarios, el primer día es Domingo (1) o Lunes (2).
            // Ajusta según tu preferencia; aquí asumimos que Lunes es el inicio.
            let leadingEmptyDays = weekday == 1 ? 6 : weekday - 2
            days.append(contentsOf: Array(repeating: nil, count: max(0, leadingEmptyDays)))
        }
        
        // Agregar los días reales del mes
        days.append(contentsOf: range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: monthStart)
        })
        
        return days
    }

    /// Retorna el número del día en formato "1", "2", etc.
    private func dayNumber(for date: Date) -> String {
        let day = calendar.component(.day, from: date)
        return "\(day)"
    }

    /// Verifica si `date` es hoy o antes (habilitado).
    private func isPastOrToday(date: Date) -> Bool {
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: date)
        return targetDate <= today
    }

    /// Calcula el color del círculo basado en progressData
    private func progressColor(for date: Date) -> Color {
        guard let progress = progressData[date] else {
            return Color.gray.opacity(0.9)
        }
        
        let totalActivities = progress.pomodoro + progress.eisenhower + progress.ivyLee
        if totalActivities < 3 {
            return .red
        } else if totalActivities < 6 {
            return .yellow
        } else {
            return .green
        }
    }
    
    // MARK: - Helpers para navegar meses
    
    /// Formato "MMM yyyy" (Ej. "Jan 2025")
    private func monthYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy" // "January 2025"
        return formatter.string(from: date)
    }
    
    /// Obtiene el primer día del mes actual
    static func firstDayOfCurrentMonth() -> Date {
        let cal = Calendar.current
        let now = Date()
        let components = cal.dateComponents([.year, .month], from: now)
        return cal.date(from: components) ?? now
    }
    
    /// Mes anterior
    private func previousMonth(for date: Date) -> Date {
        guard let newDate = calendar.date(byAdding: .month, value: -1, to: date) else { return date }
        return newDate
    }
    
    /// Siguiente mes
    private func nextMonth(for date: Date) -> Date {
        guard let newDate = calendar.date(byAdding: .month, value: 1, to: date) else { return date }
        return newDate
    }
}

// Vista de la gráfica de barras
struct BarChartView: View {
    let data: (pomodoro: Int, eisenhower: Int, ivyLee: Int)
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            BarView(label: "Pomodoro", value: data.pomodoro, color: .red)
            BarView(label: "Eisenhower", value: data.eisenhower, color: .blue)
            BarView(label: "Ivy Lee", value: data.ivyLee, color: .green)
        }
    }
}

struct BarView: View {
    let label: String
    let value: Int
    let color: Color
    
    var body: some View {
        GeometryReader { geomt in
            
            VStack {
                Text("\(value)")
                    .font(.system(size: geomt.size.width * 0.4))
                Rectangle()
                    .fill(color)
                    .frame(width: 30, height: CGFloat(value) * 20) // Altura proporcional al valor
                Text(label)
                    .font(.system(size: geomt.size.width * 0.17))
            }
        }
    }
}

#Preview {
    ProgressView()
        .environmentObject(StarProgressModel()) // Agrega este método
}

import SwiftUI
@MainActor
class StarProgressModel: ObservableObject {
    @AppStorage("star1CompleteStudy") var star1CompleteStudy: Bool = false
    @AppStorage("star2CompleteStudy") var star2CompleteStudy: Bool = false
    @AppStorage("star3CompleteStudy") var star3CompleteStudy: Bool = false
    @AppStorage("star4CompleteStudy") var star4CompleteStudy: Bool = false

    @AppStorage("star1CompleteOrga") var star1CompleteOrga: Bool = false
    @AppStorage("star2CompleteOrga") var star2CompleteOrga: Bool = false
    @AppStorage("star3CompleteOrga") var star3CompleteOrga: Bool = false
    @AppStorage("star4CompleteOrga") var star4CompleteOrga: Bool = false

    @AppStorage("star1CompleteMemo") var star1CompleteMemo: Bool = false
    @AppStorage("star2CompleteMemo") var star2CompleteMemo: Bool = false
    @AppStorage("star3CompleteMemo") var star3CompleteMemo: Bool = false

    @AppStorage("progressData") private var progressDataEncoded: Data?
    @AppStorage("tasksData") private var tasksDataEncoded: Data?
    @AppStorage("chunkingData") private var chunkingDataEncoded: Data?
    @AppStorage("pomodorosProgressData") private var pomodorosProgressEncoded: Data?
    @AppStorage("lastPomodoroConfiguration") private var lastPomodoroConfigEncoded: Data?

    // Diccionario de progreso diario
    @Published var progressData: [Date: (pomodoro: Int, eisenhower: Int, ivyLee: Int)] = [:] {
        didSet { saveProgressData() }
    }
    @Published var tasks: [StudyTask] = [] {
        didSet { saveTasks() }
    }
    @Published var chunkingWords: [ChunkingWord] = [] {
        didSet { saveChunkingData() }
    }
    @Published var pomodorosProgress: [PomodorosProgress] = [] {
        didSet { savePomodorosProgress() }
    }
    @Published var lastPomodoroConfiguration: PomodoroConfiguration? {
        didSet { saveLastPomodoroConfiguration() }
    }

    init() {
        loadProgressData()
        loadTasks()
        loadChunkingData()
        loadPomodorosProgress()
        loadLastPomodoroConfiguration()
    }

    // MARK: - Funciones de guardado y carga
    private func saveProgressData() {
        do {
            let progressArray = progressData.map { (key, value) in
                DailyProgress(date: key, pomodoro: value.pomodoro, eisenhower: value.eisenhower, ivyLee: value.ivyLee)
            }
            let data = try JSONEncoder().encode(progressArray)
            progressDataEncoded = data
        } catch {
            print("Error al guardar el progreso:", error)
        }
    }

    private func loadProgressData() {
        guard let data = progressDataEncoded else { return }
        do {
            let progressArray = try JSONDecoder().decode([DailyProgress].self, from: data)
            var tempDict: [Date: (Int, Int, Int)] = [:]
            for progress in progressArray {
                tempDict[progress.date] = (progress.pomodoro, progress.eisenhower, progress.ivyLee)
            }
            progressData = tempDict
        } catch {
            print("Error al cargar el progreso:", error)
        }
    }

    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            tasksDataEncoded = data
        } catch {
            print("Error al guardar tareas:", error)
        }
    }

    private func loadTasks() {
        guard let data = tasksDataEncoded else { return }
        do {
            tasks = try JSONDecoder().decode([StudyTask].self, from: data)
        } catch {
            print("Error al cargar tareas:", error)
        }
    }

    private func saveChunkingData() {
        do {
            let data = try JSONEncoder().encode(chunkingWords)
            chunkingDataEncoded = data
        } catch {
            print("Error al guardar datos de Chunking:", error)
        }
    }

    private func loadChunkingData() {
        guard let data = chunkingDataEncoded else { return }
        do {
            chunkingWords = try JSONDecoder().decode([ChunkingWord].self, from: data)
        } catch {
            print("Error al cargar datos de Chunking:", error)
        }
    }

    private func savePomodorosProgress() {
        do {
            let data = try JSONEncoder().encode(pomodorosProgress)
            pomodorosProgressEncoded = data
        } catch {
            print("Error al guardar progresos de Pomodoro:", error)
        }
    }

    private func loadPomodorosProgress() {
        guard let data = pomodorosProgressEncoded else { return }
        do {
            pomodorosProgress = try JSONDecoder().decode([PomodorosProgress].self, from: data)
        } catch {
            print("Error al cargar progresos de Pomodoro:", error)
        }
    }

    private func saveLastPomodoroConfiguration() {
        guard let config = lastPomodoroConfiguration else { return }
        do {
            let data = try JSONEncoder().encode(config)
            lastPomodoroConfigEncoded = data
        } catch {
            print("Error al guardar la configuración de Pomodoro:", error)
        }
    }

    private func loadLastPomodoroConfiguration() {
        guard let data = lastPomodoroConfigEncoded else { return }
        do {
            lastPomodoroConfiguration = try JSONDecoder().decode(PomodoroConfiguration.self, from: data)
        } catch {
            print("Error al cargar la configuración de Pomodoro:", error)
        }
    }
}
struct PomodorosProgress: Identifiable, Codable {
    let id: UUID
    let studyTasks: StudyTask?
    let workTimer: TimeInterval?
    let breakTimer: TimeInterval?
    let date: Date
    
    init(id: UUID = UUID(), studyTasks: StudyTask?, workTimer: TimeInterval, breakTimer: TimeInterval, date: Date) {
        self.id = id
        self.studyTasks = studyTasks
        self.workTimer = workTimer
        self.breakTimer = breakTimer
        self.date = date
    }
}
struct PomodoroConfiguration: Identifiable, Codable {
    let id: UUID
    var workDuration: Int
    var breakDuration: Int
    var soundEffect: Bool
    var sound: String
    var breakLargeDuration: Int // Duración del descanso largo

    init(id: UUID = UUID(), workDuration: Int, breakDuration: Int, soundEffect: Bool, sound: String, breakLargeDuration: Int = 15) {
        self.id = id
        self.workDuration = workDuration
        self.breakDuration = breakDuration
        self.soundEffect = soundEffect
        self.sound = sound
        self.breakLargeDuration = breakLargeDuration
    }

    // Decodificador personalizado
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        workDuration = try container.decode(Int.self, forKey: .workDuration)
        breakDuration = try container.decode(Int.self, forKey: .breakDuration)
        soundEffect = try container.decode(Bool.self, forKey: .soundEffect)
        sound = try container.decode(String.self, forKey: .sound)
        breakLargeDuration = try container.decodeIfPresent(Int.self, forKey: .breakLargeDuration) ?? 15 // Valor predeterminado
    }
}

struct StudyTask: Identifiable, Codable {
    let id: UUID
    var name: String
    var details: String
    var eisenStatus: String?
    var kanbanStatus: String?
    var startTime: Date
    var endTime: Date?

    // Constructor simplificado
    init(
        id: UUID = UUID(),
        name: String,
        details: String,
        eisenStatus: String? = "Not Specified",
        kanbanStatus: String? = "Not Specified",
        startTime: Date,
        endTime: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.details = details
        self.eisenStatus = eisenStatus
        self.kanbanStatus = kanbanStatus
        self.startTime = startTime
        self.endTime = endTime
    }
}
struct ChunkingWord: Identifiable, Codable {
    let id: UUID
    var original: String
    var chunked: String

    init(original: String, chunked: String) {
        self.id = UUID()
        self.original = original
        self.chunked = chunked
    }
}
struct DailyProgress: Codable {
    let date: Date
    var pomodoro: Int
    var eisenhower: Int
    var ivyLee: Int
}
