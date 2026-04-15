import Foundation

enum Endpoint {
    case news
    case movies
    
    var url: URL? {
        switch self {
        case .news:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")
        case .movies:
            return URL(string: "https://jsonplaceholder.typicode.com/photos")
        }
    }
}
