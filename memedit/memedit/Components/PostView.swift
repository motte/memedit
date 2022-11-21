//
//  PostView.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import SwiftUI

struct PostView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            if let urlString = self.viewModel.post.data?.url, let url = URL(string: urlString) {
                /// If there is an image.
                AsyncImage(url: url, scale: 1, content: { image in
                    image.resizable().aspectRatio(contentMode: .fit).task {
                        self.viewModel.image = image
                    }
                }, placeholder: {
                    Color(UIColor.systemBackground).opacity(0.4)
                }).frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            VStack {
                Text(.init("r/\(self.viewModel.post.data?.subreddit?.capitalized ?? "*[subreddit missing]*")")).font(.system(size: 20, weight: .medium))
                Spacer()
                HStack(alignment: .bottom, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(.init("u/\(self.viewModel.post.data?.author ?? "*[username missing]*")")).font(.system(size: 20, weight: .bold))
                        Text(.init("\(self.viewModel.post.data?.title ?? "*[no title]*")"))
                    }
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 12) {
                        // FIXME: Need to either add a background to this section, add an outline to the buttons, or change the colors for these buttons.  A mostly white/black meme image will blend with these icons in dark/light mode.
                        Button(action: {
                            
                        }, label: {
                            Circle().fill(Color.white).frame(width: 64, height: 64).overlay(
                                Image("ProfilePlaceholder").resizable().scaledToFill().frame(width: 62, height: 62).cornerRadius(40)
                            )
                        })
                        
                        Button(action: {
                            
                        }, label: {
                            VStack(spacing: 2) {
                                Image(systemName: "arrowshape.backward.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40).rotationEffect(Angle(degrees: 90))
                                Text(.init("\(self.viewModel.post.data?.ups ?? 0)")).font(.system(size: 16, weight: .medium))
                            }.foregroundColor(Color(UIColor.label))
                        })
                        
                        Button(action: {}, label: {
                            VStack(spacing: 2) {
                                Image(systemName: "ellipsis.message.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40)
                                Text(.init("\(self.viewModel.post.data?.numComments ?? 0)")).font(.system(size: 16, weight: .medium))
                            }.foregroundColor(Color(UIColor.label))
                        })
                        
                        if let permalink = self.viewModel.post.data?.permalink, let permaURL = URL(string: "https://www.reddit.com\(permalink)") {
                            #warning("The thumbnail image is bugged in iOS 16.1.1.  Adding the preview parameter causes the sharelink sheet to be blank.")
//                            if let thumbnail = self.image {
//                                ShareLink(item: permaURL,
//                                          preview: SharePreview(permalink, image: thumbnail)) {
//                                    VStack(spacing: 2) {
//                                        Image(systemName: "arrowshape.turn.up.right.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40)
//                                        Text("Share").font(.system(size: 16, weight: .medium))
//                                    }
//                                }
//                            } else {
                                ShareLink(item: permaURL) {
                                    VStack(spacing: 2) {
                                        Image(systemName: "arrowshape.turn.up.right.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40)
                                        Text("Share").font(.system(size: 16, weight: .medium))
                                    }.foregroundColor(Color(UIColor.label))
                                }
//                            }
                        }
                    }.frame(minWidth: 0, maxWidth: 80)
                }
            }.padding(.leading, 16).padding(.bottom, 96)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

