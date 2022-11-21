//
//  PostViewModel.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import SwiftUI

extension PostView {
    // MARK:- PostView's ViewModel
    @MainActor class ViewModel: ObservableObject {
        @Published var post: RedditPost
        @Published var comments: [String] = []
        @Published var image: Image? = nil
        @Published var isLoadingComments: Bool = false
        @Published var isShowingIsolatedImage: Bool = false
        
        init(post: RedditPost) {
            self.post = post
        }
        
        func fetchComments(name: String = "", useCache shouldUseCache: Bool = false) {
            // TODO: Error handling needed for guard.
            guard let url = URL(string: "https://www.reddit.com/r/.json") else { return }
            
            self.isLoadingComments = true
            
            let config = URLSessionConfiguration.default
            if shouldUseCache == false { config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData }
            
            let session = URLSession.init(configuration: config)
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error == nil {
                    if let json = data {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let redditModel = try decoder.decode(Reddit.self, from: json)
                            DispatchQueue.main.async {
                                /// Display and store comments.
                                
                            }
                        } catch {
                            print("Error: The data from Reddit is not as expected.  Please contact us for support.")
                        }
                    } else {
                        /// There was no data.  Not necessarily an error.
                        // TODO: Show an error to the user.
                        print("There was no data from \(url.absoluteString).")
                    }
                } else {
                    /// There was an error in the process of fetching data.  It could be an invalid URL, lost connection, etc.  Look at the error code.
                    // TODO: Show an error to the user.
                    print("Error: \(String(describing: error))")
                }
                
                DispatchQueue.main.async { self.isLoadingComments = false }
            }).resume()
        }
        
        func getUIImage() -> UIImage? {
            if let urlString = self.post.data?.url, let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            } else {
                return nil
            }
        }
        
    }
}
