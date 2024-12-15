//
//  ContentView.swift
//  laba_6
//
//  Created by Valeriya on 08.12.2024.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var apiService = YouTubeAPIService()

    var body: some View {
        NavigationView {
            List(apiService.videos) { video in
                HStack {
                    AsyncImage(url: URL(string: video.thumbnailURL)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 60)
                    .cornerRadius(8)

                    VStack(alignment: .leading) {
                        Text(video.title)
                            .font(.headline)
                            .lineLimit(2)
                            .foregroundColor(.white)
                        Text("\(video.viewCount) views")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()

                    
                    Link(destination: URL(string: "https://www.youtube.com/watch?v=\(video.id)")!) {
                        Image(systemName: "link.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Top 10 Videos")
            .onAppear {
                apiService.fetchPopularVideos()
            }
        }
    }
}

#Preview {
    ContentView()
}
