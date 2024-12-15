//
//  Video.swift
//  laba_6
//
//  Created by Valeriya on 15.12.2024.
//
import Foundation

struct Video: Identifiable {
    let id: String
    let title: String
    let thumbnailURL: String
    let viewCount: String
}

struct YouTubeResponse: Codable {
    struct Item: Codable {
        struct Snippet: Codable {
            let title: String
            let thumbnails: Thumbnails
            struct Thumbnails: Codable {
                let medium: Thumbnail
                struct Thumbnail: Codable {
                    let url: String
                }
            }
        }
        struct Statistics: Codable {
            let viewCount: String
        }
        let id: String
        let snippet: Snippet
        let statistics: Statistics
    }
    let items: [Item]
}

