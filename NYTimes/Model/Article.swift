//
//  Article.swift
//  NYTimes
//
//  Created by Raja Indirajith on 11/07/2025.
//


import Foundation


// MARK: - Article
struct Article: Decodable, Identifiable {
    let id: Int
    let url: String
    let publishedDate: String
    let updated: String
    let byline: String
    let title: String
    let abstract: String
    let media: [Media]
   
    enum CodingKeys: String, CodingKey {
        case id, url, updated, byline, title, abstract, media
        case publishedDate = "published_date"
    }
    
   
    init(id: Int, url: String, publishedDate: String, updated: String, byline: String, title: String, abstract: String, media: [Media]) {
        self.id = id
        self.url = url
        self.publishedDate = publishedDate
        self.updated = updated
        self.byline = byline
        self.title = title
        self.abstract = abstract
        self.media = media
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
       
       // "yyyy-MM-dd"
        publishedDate = try container.decode(String.self, forKey: .publishedDate)

        // "yyyy-MM-dd HH:mm:ss"
        updated = try container.decode(String.self, forKey: .updated)
        
        byline = try container.decode(String.self, forKey: .byline)
        title = try container.decode(String.self, forKey: .title)
        abstract = try container.decode(String.self, forKey: .abstract)
        media = try container.decode([Media].self, forKey: .media)
    }
    
    // if update date not available, then will use publish date
    var lastModifiedDate: Date {
       
        if  !updated.isEmpty {
            return  DateFormatter.nytDateTimeFormatter.date(from: updated)!
        }else {
            return  DateFormatter.nytDateFormatter.date(from: publishedDate)!
        }
    }
    
    var dateToDisplay: String {
        return DateFormatter.displayFormatter.string(from: lastModifiedDate)
    }
    
    // if we want to use 1 day age, 2 day ago,, it will support for 7 days,
    //after that it will show in display date formate then we can use this method
    var timeAgoOrDate: String {
        let now = Date()
        let calendar = Calendar.current
        if let days = calendar.dateComponents([.day], from: lastModifiedDate, to: now).day,
           days <= 7 {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full // or .abbreviated / .short
            return formatter.localizedString(for: lastModifiedDate, relativeTo: now)
        } else {
            return DateFormatter.displayFormatter.string(from: lastModifiedDate)
        }
    }
    
    var thumbnailURL: URL? {
       mediaURL(for: "Standard Thumbnail")
    }

    var mediumURL: URL? {
       mediaURL(for: "mediumThreeByTwo210")
    }

    var largeURL: URL? {
       mediaURL(for: "mediumThreeByTwo440")
    }

    func mediaURL(for format: String) -> URL? {
        guard let mediaItem = media.first else { return nil }
        guard let urlString = mediaItem.mediaMetadata.first(where: { $0.format == format })?.url else { return nil }
        return URL(string: urlString)
    }
}



struct Media: Decodable {
    let type: String
    let subtype: String
    let mediaMetadata: [MediaMetadata]

    init(type: String, subtype: String, mediaMetadata: [MediaMetadata]) {
        self.type = type
        self.subtype = subtype
        self.mediaMetadata = mediaMetadata
    }
    
    enum CodingKeys: String, CodingKey {
        case type, subtype
        case mediaMetadata = "media-metadata"
    }
}


struct MediaMetadata: Decodable {
    let url: String
    let format: String
    let height: Int
    let width: Int
    
    init(url: String, format: String, height: Int, width: Int) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}
