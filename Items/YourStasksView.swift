//
//  YourTasksView.swift
//  StudyMethods
//
//  Created by Emilio Contreras on 25/01/25.
//

import SwiftUI

struct YourTasksView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    @Environment(\.colorScheme) var colorScheme
    @State private var isAddingTask: Bool = false
    @State private var isEditingTask: Bool = false
    @State private var selectedTask: StudyTask? = nil

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
                        Text("Your Tasks")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, geometry.size.height * 0.05)

                        Spacer()

                        Button(action: {
                            isAddingTask = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: geometry.size.width * 0.06, height: geometry.size.width * 0.06)
                                .foregroundColor(.blue)
                        }
                        .padding(.top, geometry.size.height * 0.05)
                    }
                    .padding(.horizontal)

                    if progressModel.tasks.isEmpty {
                        Text("No tasks available.")
                            .font(.system(size: geometry.size.width * 0.07))
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ScrollView {
                            ForEach(progressModel.tasks) { task in
                                TaskCardView(task: task, geometry: geometry) {
                                    editTask(task)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                        }
                        .padding(.bottom, geometry.size.height * 0.02)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
            }
            .sheet(isPresented: $isAddingTask) {
                AddTaskView()
                    .environmentObject(progressModel)
            }
            .sheet(isPresented: $isEditingTask) {
                if let task = selectedTask {
                    EditTaskView(task: task)
                        .environmentObject(progressModel)
                }
            }
        }
    }

    private func editTask(_ task: StudyTask) {
        selectedTask = task
        isEditingTask = true
    }
}

struct TaskCardView: View {
    let task: StudyTask
    let geometry: GeometryProxy
    let onEdit: () -> Void

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(task.name)
                        .font(.headline)
                        .fontWeight(.bold)

                    Spacer()

                    Button(action: onEdit) {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.blue)
                    }
                }

                if !task.details.isEmpty {
                    Text(task.details)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack {
                    if let eisenStatus = task.eisenStatus {
                        Text("Eisen: \(eisenStatus)")
                            .font(.caption)
                            .padding(4)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(5)
                    }

                    if let kanbanStatus = task.kanbanStatus {
                        Text("Kanban: \(kanbanStatus)")
                            .font(.caption)
                            .padding(4)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(5)
                    }
                }

                Text("Start: \(formattedDate(task.startTime))")
                    .font(.footnote)

                if let endTime = task.endTime {
                    Text("End: \(formattedDate(endTime))")
                        .font(.footnote)
                        .foregroundColor(.red)
                } else {
                    Text("End: No deadline")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .frame(width: geometry.size.width * 0.9)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct AddTaskView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    @Environment(\.dismiss) var dismiss
    @State private var taskName: String = ""
    @State private var taskDetails: String = ""
    @State private var eisenStatus: String? = nil
    @State private var kanbanStatus: String? = nil
    @State private var endTime: Date? = nil
    @State private var showAlert: Bool = false // Mostrar alerta si los campos están vacíos

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $taskName)
                    TextField("Details", text: $taskDetails)
                }

                Section(header: Text("Status")) {
                    TextField("Eisenhower Status", text: Binding(
                        get: { eisenStatus ?? "" },
                        set: { eisenStatus = $0 }
                    ))
                    TextField("Kanban Status", text: Binding(
                        get: { kanbanStatus ?? "" },
                        set: { kanbanStatus = $0 }
                    ))
                }

                Section(header: Text("Dates")) {
                    if let validEndTime = endTime {
                        DatePicker("End Time", selection: Binding(
                            get: { validEndTime },
                            set: { endTime = $0 }
                        ), displayedComponents: [.date, .hourAndMinute])
                    } else {
                        Button("Add End Date") {
                            endTime = Date()
                        }
                        .foregroundColor(.blue)
                    }

                    if endTime != nil {
                        Button("Clear End Date") {
                            endTime = nil
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Add New Task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    if taskName.isEmpty {
                        showAlert = true
                    } else {
                        saveTask()
                        dismiss()
                    }
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("Task name is required."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func saveTask() {
        let newTask = StudyTask(
            name: taskName,
            details: taskDetails,
            eisenStatus: eisenStatus,
            kanbanStatus: kanbanStatus,
            startTime: Date(),
            endTime: endTime
        )
        progressModel.tasks.append(newTask)
    }
}

struct EditTaskView: View {
    @EnvironmentObject var progressModel: StarProgressModel
    @Environment(\.dismiss) var dismiss
    @State var task: StudyTask

    var body: some View {
        NavigationView {
            AddTaskView() // Reutilizamos la vista de agregar tarea
        }
    }
}

#Preview {
    YourTasksView()
        .environmentObject(StarProgressModel())
}
