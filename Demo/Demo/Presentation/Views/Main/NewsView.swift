import SwiftUI

struct NewsView: View {
    @StateObject private var viewModel = DIContainer.shared.makeNewsViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.data.isEmpty {
                    ProgressView("Loading news...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error).foregroundColor(.red)
                        Button("Retry") {
                            viewModel.fetchNews()
                        }
                    }
                } else {
                    List(viewModel.data) { news in
                        VStack(alignment: .leading) {
                            Text(news.title)
                                .font(.headline)
                                .padding(.bottom, 2)
                            Text(news.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(3)
                        }
                        .padding(.vertical, 5)
                    }
                    .refreshable {
                        viewModel.fetchNews()
                    }
                }
            }
            .navigationTitle("News")
        }
        .onAppear {
            if viewModel.data.isEmpty {
                viewModel.fetchNews()
            }
        }
    }
}
