//
//  Untitled.swift
//  laba_6
//
//  Created by Valeriya on 08.12.2024.
//
import Foundation

class YouTubeAPIService: ObservableObject {
    @Published var videos: [Video] = []
    private let apiKey = "AIzaSyDu8pitH39Cu2piymBMbJbtrvGp6p-5Ido"
    
    private func makeYouTubeAPIURL() -> URL? {
            let baseURL = "https://www.googleapis.com/youtube/v3/videos"
            var components = URLComponents(string: baseURL)
            components?.queryItems = [
                URLQueryItem(name: "part", value: "snippet,statistics"),
                URLQueryItem(name: "chart", value: "mostPopular"),
                URLQueryItem(name: "maxResults", value: "10"),
                URLQueryItem(name: "key", value: apiKey)
            ]
            return components?.url
        }
        
        func fetchPopularVideos() {
            guard let url = makeYouTubeAPIURL() else { return }
            //print(makeYouTubeAPIURL()?.absoluteString ?? "Invalid URL")

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(YouTubeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.videos = response.items.map {
                            Video(
                                id: $0.id,
                                title: $0.snippet.title,
                                thumbnailURL: $0.snippet.thumbnails.medium.url,
                                viewCount: $0.statistics.viewCount
                            )
                        }
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }.resume()
        }
    }
