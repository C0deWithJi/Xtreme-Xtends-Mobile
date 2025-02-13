import SwiftUI

struct FilterSortButton: View {
    @ObservedObject var viewModel: MarketplaceViewModel
    @State private var showFilters = false

    var body: some View {
       Button {
        showFilters.toggle()
       } label: {
        Image(systemName: "slider.horizontal.3 ")
       }
       .sheet(isPresented: $showFilters) {
        FilterSortView(viewModel: viewModel)
       }
    }
}

struct FilterSortView: View {
    @ObservedObject var viewModel: MarketplaceViewModel

    var body: some View {
        NavigationView {
            Form {
                Section("Sort By") {
                    Picker("Sort", selection: $viewModel.sortOption) {
                        Text("Price: Low to High").tag(SortOption.priceLowToHigh)
                        Text("Price: High to Low").tag(SortOption.priceHighToLow)
                    }
                }

                Section("Filters") {
                    Toggle("In Stock", isOn: $viewModel.showInStockOnly)
                }
            }
            .navigationTitle("Filter & Sort")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.applyFilters()
                    }
                }
            }
        }
    }
}