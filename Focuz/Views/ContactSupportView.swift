import SwiftUI

struct ContactSupportView: View {
    @State private var email = ""
    @State private var message = ""
    @State private var name = ""
    @State private var topic = "General"
    @State private var isSubmitting = false
    @State private var showSuccess = false
    @State private var showError = false
    @Environment(\.dismiss) private var dismiss

    private let topics = ["General", "Bug Report", "Feature Request", "Billing", "Other"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Topic") {
                    Picker("Topic", selection: $topic) {
                        ForEach(topics, id: \.self) { t in
                            Text(t).tag(t)
                        }
                    }
                }

                Section("Your Info") {
                    TextField("Name (optional)", text: $name)
                    TextField("Email (required)", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }

                Section("Message") {
                    TextEditor(text: $message)
                        .frame(minHeight: 100)
                }

                Section {
                    Button {
                        submitFeedback()
                    } label: {
                        if isSubmitting {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Submit")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(email.isEmpty || message.isEmpty || isSubmitting)
                }
            }
            .navigationTitle("Contact Support")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .alert("Message Sent", isPresented: $showSuccess) {
                Button("OK") { dismiss() }
            } message: {
                Text("We'll get back to you soon.")
            }
            .alert("Error", isPresented: $showError) {
                Button("OK") { }
            } message: {
                Text("Failed to send. Please try again.")
            }
        }
    }

    private func submitFeedback() {
        isSubmitting = true
        guard let url = URL(string: "https://feedback-board.iocompile67692.workers.dev") else {
            isSubmitting = false
            showError = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any?] = [
            "topic": topic,
            "name": name.isEmpty ? nil : name,
            "email": email,
            "message": message
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body.compactMapValues { $0 })

        URLSession.shared.dataTask(with: request) { _, response, _ in
            DispatchQueue.main.async {
                isSubmitting = false
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    showSuccess = true
                } else {
                    showError = true
                }
            }
        }.resume()
    }
}
