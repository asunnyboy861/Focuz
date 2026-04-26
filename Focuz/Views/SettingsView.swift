import SwiftUI

struct SettingsView: View {
    @AppStorage("useCloudKit") private var useCloudKit = false
    @AppStorage("hasSeenWeeklyReset") private var hasSeenWeeklyReset = false
    @State private var showPaywall = false
    @State private var showSupport = false

    private let supportURL = "https://asunnyboy861.github.io/Focuz-pages/support.html"
    private let privacyURL = "https://asunnyboy861.github.io/Focuz-pages/privacy.html"
    private let termsURL = "https://asunnyboy861.github.io/Focuz-pages/terms.html"

    var body: some View {
        NavigationStack {
            List {
                proSection
                syncSection
                aboutSection
                legalSection
            }
            .scrollContentBackground(.hidden)
            .background(Color(hex: "#FFF8F0"))
            .navigationTitle("Settings")
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
            .sheet(isPresented: $showSupport) {
                ContactSupportView()
            }
        }
    }

    private var proSection: some View {
        Section {
            Button {
                showPaywall = true
            } label: {
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundColor(Color(hex: "#F4A261"))
                    Text("Upgrade to Pro")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    private var syncSection: some View {
        Section("Sync & Backup") {
            Toggle("iCloud Sync", isOn: $useCloudKit)

            if useCloudKit {
                Text("Your data will sync across all your devices")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                Text("Data is stored locally on this device")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }

    private var aboutSection: some View {
        Section("About") {
            HStack {
                Text("Version")
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                    .foregroundColor(.secondary)
            }

            Button {
                showSupport = true
            } label: {
                HStack {
                    Image(systemName: "envelope")
                    Text("Contact Support")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .foregroundColor(.primary)
            }
        }
    }

    private var legalSection: some View {
        Section("Legal") {
            Link(destination: URL(string: privacyURL)!) {
                HStack {
                    Image(systemName: "hand.raised")
                    Text("Privacy Policy")
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Link(destination: URL(string: termsURL)!) {
                HStack {
                    Image(systemName: "doc.text")
                    Text("Terms of Use")
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Link(destination: URL(string: supportURL)!) {
                HStack {
                    Image(systemName: "questionmark.circle")
                    Text("Support")
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
