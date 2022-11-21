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
                            ZStack {
                                if let urlString = post.data?.url, let url = URL(string: urlString) {
                                    AsyncImage(url: url, scale: 1, content: { image in
                                        image.resizable().aspectRatio(contentMode: .fit)
                                    }, placeholder: {
                                        Color(UIColor.systemBackground).opacity(0.4)
                                    }).frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                VStack {
                                    Text(.init("r/\(post.data?.subreddit?.capitalized ?? "*[subreddit missing]*")")).font(.system(size: 20, weight: .medium))
                                    Spacer()
                                    HStack(alignment: .center, spacing: 0) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(.init("u/\(post.data?.author ?? "*[username missing]*")")).font(.system(size: 20, weight: .bold))
                                            Text(.init("\(post.data?.title ?? "*[no title]*")"))
                                        }
                                        Spacer()
                                        VStack(alignment: .center, spacing: 12) {
                                            Button(action: {
                                                
                                            }, label: {
                                                Text(.init("\(post.data?.ups ?? 0)")).font(.system(size: 16, weight: .medium))
                                            })
                                            
                                            Button(action: {
                                                
                                            }, label: {
                                                Text(.init("\(post.data?.ups ?? 0)")).font(.system(size: 16, weight: .medium))
                                            })
                                            
                                            Button(action: {}, label: {
                                                Text(.init("\(post.data?.numComments ?? 0)")).font(.system(size: 16, weight: .medium))
                                            })
                                            
                                            Button(action: {
//                                                post.data?.permalink
                                            }, label: {
                                                Text("Share").font(.system(size: 16, weight: .medium))
                                            })
                                            
                                        }.frame(minWidth: 0, maxWidth: 80).background(.red)
                                    }
                                }.padding(.all, 16).padding(.bottom, 80)
                            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
