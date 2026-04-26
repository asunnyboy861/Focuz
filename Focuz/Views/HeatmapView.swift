import SwiftUI

struct HeatmapView: View {
    let cells: [HeatmapCell]
    let color: Color

    private let columns = 13
    private let cellSize: CGFloat = 12
    private let spacing: CGFloat = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("90-Day Overview")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(cellSize), spacing: spacing), count: columns), spacing: spacing) {
                    ForEach(cells.reversed()) { cell in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(cell.completed ? color.opacity(0.3 + cell.intensity * 0.7) : Color.gray.opacity(0.1))
                            .frame(width: cellSize, height: cellSize)
                    }
                }
            }

            HStack {
                Text("Less")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                ForEach(0..<5) { level in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(color.opacity(Double(level) / 4.0 * 0.7 + 0.1))
                        .frame(width: cellSize, height: cellSize)
                }
                Text("More")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}
