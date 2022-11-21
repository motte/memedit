//
//  FeedView.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import SwiftUI

struct FeedView: View {
    @FocusState var focused: Bool
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            /// A continuous scroll of posts.
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(self.viewModel.subredditPosts, id: \.id) { post in
                        if post.data?.hidden != true {
                            PostView(viewModel: PostView.ViewModel(post: post))
                        }
                    }
                }
            }
            
            /// Name of the subreddit.
            VStack {
                if self.viewModel.isEditingSubredditName == false {
                    Text(.init("r/\(self.viewModel.subredditName)")).padding(.all, 8).contentShape(RoundedRectangle(cornerRadius: 8)).contextMenu {
                        Button(action: {
                            self.viewModel.changeSubreddit(name: "SpacePorn")
                        }, label: {
                            Label("r/SpacePorn", systemImage: "moon.stars.fill")
                        })
                        Button(action: {
                            self.viewModel.changeSubreddit(name: "iPhoneWallpapers")
                        }, label: {
                            Label("r/iPhoneWallpapers", systemImage: "lock.iphone")
                        })
                        Button(action: {
                            self.viewModel.changeSubreddit(name: "Pic")
                        }, label: {
                            Label("r/Pic", systemImage: "photo")
                        })
                        Button(action: {
                            self.viewModel.changeSubreddit(name: "EarthPorn")
                        }, label: {
                            Label("r/EarthPorn", systemImage: "globe.americas.fill")
                        })
                        Button(action: {
                            self.viewModel.changeSubreddit(name: "Images")
                        }, label: {
                            Label("r/Images", systemImage: "photo.stack")
                        })
                        Button(action: {
                            self.viewModel.changeSubreddit(name: "Memes")
                        }, label: {
                            Label("r/Memes", systemImage: "fish.fill")
                        })
                    }.onTapGesture {
                        withAnimation { self.viewModel.isEditingSubredditName = true }
                        self.focused = true
                    }
                } else {
                    HStack {
                        TextField("", text: self.$viewModel.proposedSubredditName).focused(self.$focused)
                        Button(action: {
                            withAnimation { self.viewModel.changeSubreddit() }
                        }, label: {
                            Image(systemName: "checkmark.circle.fill").foregroundColor(Color.green)
                        })
                        
                        Button(action: {
                            withAnimation { self.viewModel.cancelChangeSubreddit() }
                        }, label: {
                            Image(systemName: "xmark.circle.fill").foregroundColor(Color.red)
                        })
                    }.padding(.horizontal, 16)
                }
                Spacer()
            }.font(.system(size: 20, weight: .medium))
            
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
