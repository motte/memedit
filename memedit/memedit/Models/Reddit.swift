//
//  Reddit.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import Foundation

struct Reddit: Codable, Identifiable {
    var id: UUID = UUID()
    var kind: String = ""
    var data: RedditData
    
    enum CodingKeys: CodingKey {
        case kind, data
    }
    
    // TODO: Consider moving RedditData and its childrend to their own files.
    struct RedditData: Codable {
        var after: String?
        var before: String?
        var children: [RedditPost] = []
        var dist: Int = 0
        var modhash: String?
    }
}

struct RedditPost: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var kind: String? = ""
    var data: RedditPostData?
    
    enum CodingKeys: CodingKey {
        case kind, data
    }
    
    init() {}
}


// TODO: Consider adding/removing what we encode/decode here based on what we actually need.
struct RedditPostData: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var subreddit: String?
    var authorFullname: String?
    var title: String? = ""
    var subredditNamePrefixed: String? = ""
    var hidden: Bool? = false
    var name: String? = ""
    var ups: Int?
    var created: Double?
    var author: String? = ""
    var thumbnail: String? = ""
    var url: String? = "" /// Media URL
    var permalink: String? = ""
    var isVideo: Bool? = false
    var numComments: Int?
    
    enum CodingKeys: CodingKey {
        case subreddit, authorFullname, title, subredditNamePrefixed, hidden, name, ups, created, author, thumbnail, url, permalink, isVideo
    }
    
}
