import SwiftUI
import SwiftData

struct BuildView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = BuildViewModel()
    @State private var habitService = HabitService()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    nameSection
                    emojiSection
                    colorSection
                    frequencySection
                    saveButton
                }
                .padding()
            }
            .frame(maxWidth: 720)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#FFF8F0"))
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Name")
                .font(.headline)
            TextField("e.g. Morning Run", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .font(.body)
        }
    }

    private var emojiSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Icon")
                .font(.headline)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                ForEach(viewModel.availableEmojis, id: \.self) { emoji in
                    Button {
                        viewModel.selectedEmoji = emoji
                    } label: {
                        Image(systemName: emoji)
                            .font(.title3)
                            .frame(width: 44, height: 44)
                            .background(viewModel.selectedEmoji == emoji ? Color(hex: "#8CB369").opacity(0.2) : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var colorSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Color")
                .font(.headline)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                ForEach(viewModel.availableColors, id: \.self) { colorHex in
                    Button {
                        viewModel.selectedColor = colorHex
                    } label: {
                        Circle()
                            .fill(Color(hex: colorHex))
                            .frame(width: 36, height: 36)
                            .overlay(
                                Circle()
                                    .stroke(Color.primary, lineWidth: viewModel.selectedColor == colorHex ? 2 : 0)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var frequencySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Frequency")
                .font(.headline)

            Picker("Frequency", selection: $viewModel.selectedFrequencyKind) {
                ForEach(HabitFrequencyKind.allCases, id: \.self) { kind in
                    Text(kindDisplayText(kind)).tag(kind)
                }
            }
            .pickerStyle(.segmented)

            if viewModel.selectedFrequencyKind == .xPerWeek {
                Stepper("\(viewModel.customWeekCount)x per week", value: $viewModel.customWeekCount, in: 1...6)
                    .padding(.top, 4)
            }

            if viewModel.selectedFrequencyKind == .xPerMonth {
                Stepper("\(viewModel.customMonthCount)x per month", value: $viewModel.customMonthCount, in: 1...28)
                    .padding(.top, 4)
            }
        }
    }

    private func kindDisplayText(_ kind: HabitFrequencyKind) -> String {
        switch kind {
        case .daily: return "Every day"
        case .xPerWeek: return "X/week"
        case .xPerMonth: return "X/month"
        case .everyOtherDay: return "Alt day"
        case .custom: return "Custom"
        }
    }

    private var saveButton: some View {
        Button {
            guard viewModel.canSave else { return }
            habitService.createHabit(
                modelContext: modelContext,
                name: viewModel.name.trimmingCharacters(in: .whitespaces),
                emoji: viewModel.selectedEmoji,
                colorHex: viewModel.selectedColor,
                frequency: viewModel.effectiveFrequency()
            )
            viewModel.reset()
        } label: {
            Text("Create Habit")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.canSave ? Color(hex: "#8CB369") : Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .disabled(!viewModel.canSave)
    }
}
