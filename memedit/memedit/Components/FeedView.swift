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
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(self.viewModel.subredditPosts, id: \.id) { post in
                        if post.data?.hidden != true {
                            PostView(viewModel: PostView.ViewModel(post: post))
                        }
                    }
                }
            }
            if self.viewModel.errorMessage != "" { Text("\(self.viewModel.errorMessage)") }
            if self.viewModel.isLoading == true { ProgressView() }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
