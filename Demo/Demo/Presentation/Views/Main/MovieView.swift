import SwiftUI

struct MovieView: View {
    @StateObject private var viewModel = DIContainer.shared.makeMovieViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.data.isEmpty {
                    ProgressView("Loading movies...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error).foregroundColor(.red)
                        Button("Retry") {
                            viewModel.fetchMovies()
                        }
                    }
                } else {
                    List(viewModel.data) { movie in
                        HStack(spacing: 15) {
                            AsyncImage(url: URL(string: movie.thumbnailUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                         .aspectRatio(contentMode: .fill)
                                case .failure:
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                            
                            Text(movie.title)
                                .font(.headline)
                                .lineLimit(2)
                        }
                        .padding(.vertical, 5)
                    }
                    .refreshable {
                        viewModel.fetchMovies()
                    }
                }
            }
            .navigationTitle("Movies")
        }
        .onAppear {
            if viewModel.data.isEmpty {
                viewModel.fetchMovies()
            }
        }
    }
}
