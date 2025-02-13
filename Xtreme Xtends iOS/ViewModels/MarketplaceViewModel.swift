// ViewModels/MarketplaceViewModel.swift
import Combine

class MarketplaceViewModel: ObservableObject {
    @Published var allProducts: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var isLoading = false
    @Published var error: String?
    
    // Search & Filter State
    @Published var searchText = ""
    @Published var sortOption: SortOption = .priceLowToHigh
    @Published var showInStockOnly = false
    
    private var cancellables = Set<AnyCancellable>()
    private let shopifyService = ShopifyService.shared
    
    init() {
        // Debounce search input to avoid excessive API calls
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.applyFilters()
            }
            .store(in: &cancellables)
        
        fetchProducts()
    }
    
    func fetchProducts() {
        isLoading = true
        shopifyService.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let products):
                    self?.allProducts = products
                    self?.applyFilters()
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
    
    func loadMoreProducts() {
        // Implement pagination here
    }
    
    func applyFilters() {
        var filtered = allProducts
        
        // Search
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Filter (e.g., in stock)
        if showInStockOnly {
            filtered = filtered.filter { $0.isInStock }
        }
        
        // Sort
        switch sortOption {
        case .priceLowToHigh:
            filtered.sort { $0.price < $1.price }
        case .priceHighToLow:
            filtered.sort { $0.price > $1.price }
        }
        
        filteredProducts = filtered
    }
}

enum SortOption {
    case priceLowToHigh, priceHighToLow
}