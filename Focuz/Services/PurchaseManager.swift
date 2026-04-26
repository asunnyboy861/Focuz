import Foundation
import StoreKit

@MainActor
@Observable
final class PurchaseManager {
    var products: [Product] = []
    var isPro: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?

    private var proProduct: Product? {
        products.first { $0.id == ProductID.pro }
    }

    var displayPrice: String {
        proProduct?.displayPrice ?? "$9.99"
    }

    private var transactionListenerTask: Task<Void, Never>?

    init() {
        transactionListenerTask = listenForTransactions()
        Task {
            await loadProducts()
            await updatePurchaseStatus()
        }
    }

    func loadProducts() async {
        do {
            let storeProducts = try await Product.products(for: [ProductID.pro])
            products = storeProducts
        } catch {
            errorMessage = "Failed to load products"
        }
    }

    func purchase() async -> Bool {
        guard let product = proProduct else { return false }
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await updatePurchaseStatus()
                await transaction.finish()
                return true
            case .userCancelled, .pending:
                return false
            @unknown default:
                return false
            }
        } catch {
            errorMessage = "Purchase failed"
            return false
        }
    }

    func restorePurchases() async {
        isLoading = true
        defer { isLoading = false }
        do {
            try await AppStore.sync()
            await updatePurchaseStatus()
        } catch {
            errorMessage = "Restore failed"
        }
    }

    private func listenForTransactions() -> Task<Void, Never> {
        Task { [weak self] in
            for await result in Transaction.updates {
                guard let self else { return }
                if let transaction = try? self.checkVerified(result) {
                    await self.updatePurchaseStatus()
                    await transaction.finish()
                }
            }
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    private func updatePurchaseStatus() async {
        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                if transaction.productID == ProductID.pro {
                    isPro = true
                    return
                }
            }
        }
        isPro = false
    }
}

enum ProductID {
    static let pro = "com.zzoutuo.Focuz.pro"
}

enum StoreError: Error {
    case failedVerification
}
