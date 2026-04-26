import SwiftUI

struct GentleResetView: View {
    let weeklyScore: Double
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 48))
                .foregroundColor(Color(hex: "#8CB369"))

            Text("New Week")
                .font(.largeTitle.bold())

            VStack(spacing: 8) {
                Text("Last week:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                ProgressView(value: weeklyScore)
                    .tint(Color(hex: "#8CB369"))
                    .frame(width: 200)

                Text("\(Int(weeklyScore * 100))%")
                    .font(.title2.bold())
                    .foregroundColor(Color(hex: "#8CB369"))
            }

            Text("You showed up \(Int(weeklyScore * 100))% of the time.\nThat's solid progress.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            Text("Missing one day doesn't erase your progress.")
                .font(.subheadline)
                .italic()
                .foregroundColor(Color(hex: "#8CB369"))

            Button {
                dismiss()
            } label: {
                Text("Let's Go")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#8CB369"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
