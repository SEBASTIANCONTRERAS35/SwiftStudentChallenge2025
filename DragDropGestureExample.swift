/*import SwiftUI
import UniformTypeIdentifiers

struct DragDropGestureExample: View {
    @State private var options: [String] = [
        "Option 1: The water cycle is a continuous movement of water.",
        "Option 2: What is the water cycle?",
        "Option 3: The water cycle describes evaporation, condensation, etc."
    ]
    
    @State private var droppedItems: [String] = [] // Elementos soltados
    @State private var dragOffset: CGSize = .zero // Offset de arrastre
    @State private var currentlyDraggingItem: String? = nil // Elemento actualmente arrastrado
    @State private var isDragging: Bool = false // Estado de arrastre
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Drag and Drop with Gesture")
                    .font(.title)
                    .padding()
                
                // Área de destino para soltar elementos
                VStack {
                    Text("Drop items here")
                        .font(.headline)
                        .foregroundColor(droppedItems.isEmpty ? .gray : .black)
                    
                    ForEach(droppedItems, id: \.self) { item in
                        Text(item)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green.opacity(0.8)))
                    }
                }
                .frame(height: geometry.size.height * 0.3)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue.opacity(0.2))
                        .shadow(radius: 10)
                )
                .onDrop(of: [.plainText], isTargeted: nil) { providers in
                    handleDrop(providers: providers)
                }
                .padding()
                
                // Elementos arrastrables
                HStack(spacing: 20) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .font(.system(size: geometry.size.width * 0.02))
                            .foregroundColor(.black)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                            )
                            .offset(currentlyDraggingItem == option ? dragOffset : .zero)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        isDragging = true
                                        currentlyDraggingItem = option
                                        dragOffset = value.translation
                                    }
                                    .onEnded { _ in
                                        isDragging = false
                                        checkIfDroppedInsideTarget(option: option, geometry: geometry)
                                        dragOffset = .zero
                                    }
                            )
                            .zIndex(currentlyDraggingItem == option ? 1 : 0)
                    }
                }
                .padding()
            }
            .padding()
        }
    }
    
    private func checkIfDroppedInsideTarget(option: String, geometry: GeometryProxy) {
        // Calcula si el elemento se soltó dentro del área de destino
        let targetFrame = CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height * 0.3)
        let draggedFrame = CGRect(
            x: dragOffset.width,
            y: dragOffset.height,
            width: geometry.size.width * 0.3,
            height: geometry.size.height * 0.3
        )
        
        if targetFrame.intersects(draggedFrame) {
            // Si está dentro, agregar al área de destino
            if !droppedItems.contains(option) {
                droppedItems.append(option)
                // Eliminar del área de origen
                options.removeAll(where: { $0 == option })
            }
        }
    }
    
    private func handleDrop(providers: [NSItemProvider]) -> Bool {
        for provider in providers {
            provider.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { (data, error) in
                if let textData = data as? Data, let text = String(data: textData, encoding: .utf8) {
                    DispatchQueue.main.async {
                        if !droppedItems.contains(text) { // Evitar duplicados
                            droppedItems.append(text)
                            // Eliminar del área original
                            if let index = options.firstIndex(of: text) {
                                options.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
        return true
    }
}

#Preview {
    DragDropGestureExample()
}
*/
