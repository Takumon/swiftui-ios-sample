//
//  Article.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/29/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import Foundation

let defaultText: String = "N/A"

struct Article: Hashable {
    var sourceId: String = defaultText
    var sourceName: String = defaultText
    var author: String = defaultText
    var title: String = defaultText
    var description: String = defaultText
    var url: String = defaultText
    var urlToImage: String = defaultText
    var publishedAt: String = defaultText
    var content: String = defaultText
    
    var publishData: Date? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return df.date(from: self.publishedAt)
    }
    var publishedDateStr: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return df.string(from: self.publishData!)
    }
    var imageUrl: URL? {
        return URL(string: urlToImage)
    }
    
    init(articleData: Dictionary<String, Any>) {
        if articleData.keys.count == 0 { return }

        if let source = articleData["source"] as? Dictionary<String, String> {
            if let obj = source["id"] {self.sourceId = obj}
            if let obj = source["name"] {self.sourceName = obj}
        }
        if let obj = articleData["author"] as? String { self.author = obj }
        if let obj = articleData["title"] as? String  { self.title = obj }
        if let obj = articleData["description"] as? String  { self.description = obj }
        if let obj = articleData["url"] as? String  { self.url = obj }
        if let obj = articleData["urlToImage"] as? String  { self.urlToImage = obj }
        if let obj = articleData["publishedAt"] as? String  { self.publishedAt = obj }
        if let obj = articleData["content"] as? String  { self.content = obj }
    }
    
    
    static func getModels(articlesStr: String) -> [Article] {

        let articlesData = Data(articlesStr.utf8)
           
        do {
            if let articles = try JSONSerialization.jsonObject(with: articlesData, options: []) as? Array<Dictionary<String, Any>> {
                return articles.map { Article(articleData: $0)}
            }
        } catch let err {
            // TODO Error Handling
            print(err.localizedDescription)
        }
        return []
    }

    static func getDefault() -> Article {
        let defaultArticleData: [String: Any] = ["source": [
            "id": nil,
            "name": "Firstpost.com"
        ],
        "author": "Press Trust of India",
        "title": "RBI rate cuts unlikely to push credit demand as NBFC crisis deepens, banks look for growth capital: Report",
        "description": "Credit growth is unlikely to pick up despite the three successive rate cuts by the central bank due to the capital constraints at banks and the deepening crisis in the non-banking lenders sector, warns a report The post RBI rate cuts unlikely to push credit d…",
        "url": "https://www.firstpost.com/business/rbi-rate-cuts-unlikely-to-push-credit-demand-as-nbfc-crisis-deepens-banks-look-for-growth-capital-report-6773751.html",
        "urlToImage": "https://images.firstpost.com/wp-content/uploads/2018/06/rupee-bundles-reuters3.jpg",
        "publishedAt": "2019-06-07T10:37:36Z",
        "content": "Mumbai: Credit growth is unlikely to pick up despite the three successive rate cuts by the central bank due to the capital constraints at banks and the deepening crisis in the non-banking lenders sector, warns a report.\r\nThe Reserve Bank had cut its key polic… [+2920 chars]"
        ] as [String: Any]
        
        return Article(articleData: defaultArticleData)
    }

}
