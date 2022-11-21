//
//  FeedViewModel.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import Foundation

extension FeedView {
    // MARK:- FeedView's ViewModel
    @MainActor class ViewModel: ObservableObject {
        @Published var subredditName: String = "EarthPorn"
        @Published private(set) var subredditPosts: [RedditPost] = []
        @Published private(set) var originalSubredditPosts: [RedditPost] = [] /// The original order of the posts from Reddit.
        @Published var errorMessage: String = ""
        @Published var isLoading: Bool = true
        @Published var proposedSubredditName: String = ""
        @Published var isEditingSubredditName: Bool = false
        
        init() {
            fetchJSON()
        }
        
        func fetchJSON(name: String = "", useCache shouldUseCache: Bool = false) {
            var rName = self.subredditName
            if name != "" {
                rName = name
            }
            
            guard let url = URL(string: "https://www.reddit.com/r/\(rName).json") else {
                self.errorMessage = "There was an issue with the selected subreddit.  Double check and try again."
                return
            }
            
            self.isLoading = true
            
            let config = URLSessionConfiguration.default
            if shouldUseCache == false { config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData }
            
            /// Remove existing data.
            self.subredditPosts = []
            self.originalSubredditPosts = []
            
            let session = URLSession.init(configuration: config)
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error == nil {
                    if let json = data {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let redditModel = try decoder.decode(Reddit.self, from: json)
                            DispatchQueue.main.async {
                                /// Display the posts in the view.
                                self.subredditPosts = redditModel.data.children
                                self.originalSubredditPosts = redditModel.data.children
                            }
                        } catch {
                            print("Error: The data from Reddit is not as expected.  Please contact us for support.")
                        }
                    } else {
                        /// There was no data.  Not necessarily an error.
                        DispatchQueue.main.async {
                            self.errorMessage = ""
                        }
                        print("There was no data from \(url.absoluteString).")
                    }
                } else {
                    /// There was an error in the process of fetching data.  It could be an invalid URL, lost connection, etc.  Look at the error code.
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to fetch the listing from Reddit.  Please try again."
                    }
                    print("Error: \(String(describing: error))")
                }
                
                DispatchQueue.main.async { self.isLoading = false }
            }).resume()
        }
        
        func changeSubreddit(name: String? = nil) {
            self.subredditName = self.proposedSubredditName
            if let newSubredditName = name {
                self.subredditName = newSubredditName
            }
            self.fetchJSON()
            self.isEditingSubredditName = false
            self.proposedSubredditName = ""
        }
        
        func cancelChangeSubreddit() {
            self.isEditingSubredditName = false
        }
    }
}
