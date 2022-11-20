//
//  FeedView.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            List(self.viewModel.subredditPosts, id: \.id) { post in
                VStack {
                    Text(.init("\(post.data?.subredditNamePrefixed ?? "*[subreddit missing]*")"))
                    Text(.init("\(post.data?.url ?? "")"))
                    Text(.init("u/\(post.data?.author ?? "*[username missing]*")"))
                    Text(.init("\(post.data?.title ?? "*[no title]*")"))
                    Text(.init("\(post.data?.ups ?? 0)"))
                    Text(.init("\(post.data?.numComments ?? 0)"))
                    Text(.init("\(post.data?.permalink ?? "")"))
                }
            }
            if self.viewModel.errorMessage != "" { Text("\(self.viewModel.errorMessage)") }
            if self.viewModel.isLoading == true { ProgressView() }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
