//
//  ChunkingItemsView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 25/01/25.
//

import SwiftUI

struct ChunkingItemsView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    @Environment(\.colorScheme) var colorScheme
    @State private var isAddingChunking: Bool = false
    @State private var isEditingChunking: Bool = false
    @State private var selectedChunking: ChunkingWord? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fondo
                Image(colorScheme == .dark ? "Background2" : "Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Text("Chunking")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, geometry.size.height * 0.05)

                        Spacer()
                            .frame(width: geometry.size.width * 0.6)
                        Button(action: {
                            isAddingChunking = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: geometry.size.width * 0.06, height: geometry.size.width * 0.06)
                                .foregroundColor(.blue)
                        }
                        .padding(.top, geometry.size.height * 0.05)
                    }
                    .padding(.horizontal)

                    if progressModel.chunkingWords.isEmpty {
                        Text("No chunking words available.")
                            .font(.system(size: geometry.size.width * 0.07))
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ScrollView {
                            HStack(spacing: geometry.size.width * 0.15) {
                                Text("Original")
                                    .font(.system(size: geometry.size.width * 0.02, weight: .bold, design: .default))
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.3)
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                Text("Chunked")
                                    .font(.system(size: geometry.size.width * 0.02, weight: .bold, design: .default))
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.3)
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            }
                            ForEach(progressModel.chunkingWords) { chunking in
                                ChunkingCardView(chunkingWord: chunking, geometry: geometry, onEdit: {
                                    editChunking(chunking)
                                }, onDelete: {
                                    deleteChunking(chunking)
                                })
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                        }
                        .padding(.bottom, geometry.size.height * 0.02)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
            }
            .sheet(isPresented: $isAddingChunking) {
                AddChunkingView()
                    .environmentObject(progressModel)
            }
            .sheet(isPresented: $isEditingChunking) {
                if let chunking = selectedChunking {
                    EditChunkingView(chunking: chunking).environmentObject(progressModel)
                        .environmentObject(progressModel)
                }
            }
        }
    }

    private func editChunking(_ chunking: ChunkingWord) {
        selectedChunking = chunking
        isEditingChunking = true
    }
    private func deleteChunking(_ chunking: ChunkingWord) {
        if let index = progressModel.chunkingWords.firstIndex(where: { $0.id == chunking.id }) {
            progressModel.chunkingWords.remove(at: index)
        }
    }
}
struct ChunkingCardView: View {
    let chunkingWord: ChunkingWord
    let geometry: GeometryProxy
    let onEdit: () -> Void
    let onDelete: () -> Void // Acción para eliminar
    @State private var showChunked: Bool = false // Controla si se muestra la palabra chunked

    var body: some View {
        ZStack(alignment: .center) {
        

          
            HStack(alignment: .center) {
                // Palabra original
                Text(chunkingWord.original)
                    .font(.system(size: geometry.size.width * 0.04, weight: .bold, design: .default))
                    .fontWeight(.bold)
                    .lineLimit(1) // Limita el texto a una sola línea
                    .minimumScaleFactor(0.5) // Reduce el tamaño de la fuente hasta un 50% si es necesario
                    .padding()
                    .frame(width: geometry.size.width * 0.33)
                    .background(Color(hex: "8E4D22"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                Spacer()
                
                // Rectángulo centrado
                Rectangle()
                    .frame(width: geometry.size.width * 0.01, height: geometry.size.height * 0.05)
                    .foregroundColor(.gray) // Color opcional del rectángulo
                
                Spacer()
                
                Text(showChunked ? chunkingWord.chunked : chunkingWord.original)
                    .font(.system(size: geometry.size.width * 0.04, weight: .bold, design: .default))
                    .fontWeight(.bold)
                    .foregroundColor(showChunked ? .green : .white)
                    .padding()
                    .frame(width: geometry.size.width * 0.33)
                    .background(Color(hex: "8E4D22"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                    .lineLimit(1) // Limita el texto a una línea
                    .minimumScaleFactor(0.5) // Escala el texto hasta el 50% de su tamaño original si es necesario
                    .animation(.easeInOut(duration: 1.5), value: showChunked)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.5).delay(0.5)) {
                            showChunked = true
                        }
                    }
                
                Spacer()
                
                // Botones
                VStack (spacing : 30) {
                    Button(action: onEdit) {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.03)
                            .foregroundColor(.blue)
                    }
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.03)
                            .foregroundColor(.red)
                    }
                }
            }
            .frame(width: geometry.size.width * 0.9, alignment: .center)
            .padding()
        }
        .frame(width: geometry.size.width * 0.9)
    }
}

struct AddChunkingView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    @Environment(\.dismiss) var dismiss
    @State private var originalWord: String = ""
    @State private var chunkedWord: String = ""
    @State private var chunkSize: Int?
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Chunking Details")) {
                    TextField("Original Word", text: $originalWord)
                    TextField("Enter lenght of chunks", value: $chunkSize, formatter: NumberFormatter())
                                      .keyboardType(.numberPad) // Configura el teclado numérico
                                      .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationTitle("Lets chunk")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Chunk") {
                    if originalWord.isEmpty  {
                        showAlert = true
                    } else {
                        chunkedWord=generateChunkedWord(original: originalWord, chunkSize: chunkSize ?? 2)
                        saveChunking()
                        dismiss()
                    }
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("The field is required."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func saveChunking() {
        let newChunking = ChunkingWord(original: originalWord, chunked: chunkedWord)
        progressModel.chunkingWords.append(newChunking)
    }
    private func generateChunkedWord(original: String, chunkSize: Int) -> String {
        // Ensure chunkSize is valid
        guard chunkSize > 0 else {
            return original
        }
        
        // Create an array of chunks
        let chunks = stride(from: 0, to: original.count, by: chunkSize).map { startIndex in
            let start = original.index(original.startIndex, offsetBy: startIndex)
            let end = original.index(start, offsetBy: chunkSize, limitedBy: original.endIndex) ?? original.endIndex
            return String(original[start..<end])
        }
        
        // Combine chunks with a separator (e.g., space)
        return chunks.joined(separator: "-")
    }
}

struct EditChunkingView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    @Environment(\.dismiss) var dismiss
    @State var chunking: ChunkingWord
    @State private var originalWord: String = ""
    @State private var chunkSize: Int?
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Chunking")) {
                    // Campo para la palabra original
                    TextField("Original Word", text: $originalWord)
                        .onChange(of: originalWord) { newValue in
                         
                            chunkSize = nil
                        }

                    // Campo para el tamaño del chunk
                    TextField("Enter length of chunks", value: $chunkSize, formatter: NumberFormatter())
                        .keyboardType(.numberPad) // Configura el teclado numérico
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .onAppear {
                // Inicializar los valores al cargar la vista
                originalWord = chunking.original
                chunkSize = originalWord.isEmpty ? nil : chunking.chunked.split(separator: "-").first?.count
            }
            .navigationTitle("Edit Chunking")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    if originalWord.isEmpty || chunkSize == nil || chunkSize! <= 0 {
                        showAlert = true
                    } else {
                        saveChanges()
                        dismiss()
                    }
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("Both Original Word and Chunk Size are required."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func saveChanges() {
        if let index = progressModel.chunkingWords.firstIndex(where: { $0.id == chunking.id }) {
            // Actualiza la palabra original y calcula la nueva chunked
            progressModel.chunkingWords[index].original = originalWord
            progressModel.chunkingWords[index].chunked = generateChunkedWord(original: originalWord, chunkSize: chunkSize ?? 2)
        }
    }

    private func generateChunkedWord(original: String, chunkSize: Int) -> String {
        // Asegura que el tamaño del chunk sea válido
        guard chunkSize > 0 else {
            return original
        }

        // Divide la palabra en chunks
        let chunks = stride(from: 0, to: original.count, by: chunkSize).map { startIndex in
            let start = original.index(original.startIndex, offsetBy: startIndex)
            let end = original.index(start, offsetBy: chunkSize, limitedBy: original.endIndex) ?? original.endIndex
            return String(original[start..<end])
        }

        // Combina los chunks con un separador
        return chunks.joined(separator: "-")
    }
}

#Preview {
    ChunkingItemsView()
        .environmentObject(StarProgressModel())
}
