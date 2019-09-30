//
//  NewsRowView.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/29/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI

struct NewsRowView: View {
    let article: Article
    
    var body: some View {
        HStack {
            Image("ic_news_placeholder")
            .frame(width: 55.0, height: 41.0, alignment: Alignment.center)
            .scaledToFit()
            .clipped()
            
            VStack(alignment: .leading) {
                Text(article.title).font(.headline)
                Text(article.description).font(.subheadline).lineLimit(2)
            }
        }
    }
}


#if DEBUG
struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(article: Article.getDefault())
    }
}
#endif

