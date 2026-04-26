import SwiftUI

struct PaywallView: View {
    @State private var purchaseManager = PurchaseManager()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "sparkles")
                    .font(.system(size: 48))
                    .foregroundColor(Color(hex: "#8CB369"))

                Text("Unlock Focuz Pro")
                    .font(.largeTitle.bold())

                Text("One-time purchase. Forever yours.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                VStack(spacing: 16) {
                    ProFeatureRow(icon: "infinity", text: "Unlimited habits")
                    ProFeatureRow(icon: "widget.medium", text: "Advanced widgets")
                    ProFeatureRow(icon: "timer", text: "Live Activity & Dynamic Island")
                    ProFeatureRow(icon: "bell.badge", text: "Multiple reminders per habit")
                    ProFeatureRow(icon: "square.and.arrow.up", text: "Data export (CSV/PDF)")
                    ProFeatureRow(icon: "paintpalette", text: "Custom themes & colors")
                    ProFeatureRow(icon: "hand.tap", text: "Custom sounds & haptics")
                    ProFeatureRow(icon: "chart.bar.fill", text: "Detailed statistics")
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))

                VStack(spacing: 12) {
                    Button {
                        Task {
                            let success = await purchaseManager.purchase()
                            if success {
                                dismiss()
                            }
                        }
                    } label: {
                        if purchaseManager.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Unlock Pro - \(purchaseManager.displayPrice)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#8CB369"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button {
                        Task {
                            await purchaseManager.restorePurchases()
                        }
                    } label: {
                        Text("Restore Purchases")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#8CB369"))
                    }

                    if let error = purchaseManager.errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                Text("Payment will be charged to your Apple ID account at confirmation of purchase. This is a one-time purchase with no recurring charges.")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
        .frame(maxWidth: 720)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#FFF8F0"))
    }
}

struct ProFeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(Color(hex: "#8CB369"))
                .frame(width: 24)
            Text(text)
                .font(.subheadline)
            Spacer()
        }
    }
}
