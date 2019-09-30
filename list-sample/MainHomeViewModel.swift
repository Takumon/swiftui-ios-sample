//
//  MainHomeViewModel.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/29/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire

struct SearchParams: Encodable {
    var q: String = "cricket"
    var apiKey: String = "105c922b69f045d894fe423b86fbe660"
    var sortBy: String = "publishedAt"
    var from: String = ""
}



let searchUrl = "https://newsapi.org/v2/everything"

class MainHomeViewModel:  ObservableObject {
    @Published var articals: [Article] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<MainHomeViewModel, Never>()
    
    func search(forQuery searchQuery: String) {
        var params: Dictionary<String,String> = [
            "q": "cricket",
            "apiKey": "105c922b69f045d894fe423b86fbe660",
            "sortBy": "publishedAt",
        ]

        if !searchQuery.isEmpty {
            params["q"] = searchQuery
        }

        let today = Date()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -2, to: today)!
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let modifiedDateStr = df.string(from: modifiedDate)
        if !modifiedDateStr.isEmpty {
            params["from"] = modifiedDateStr
        }
        
        Alamofire.request(searchUrl, method: .get, parameters: params).responseJSON { response in
            
            guard response.result.isSuccess else {
              print("Error")
              return
            }
            
            guard let value = response.result.value as? [String: Any],
              let rows = value["articles"] as? [[String: Any]] else {
                print("Error")
                return
            }

            self.articals = rows.map { Article(articleData: $0) }
        }
    }
    
}
