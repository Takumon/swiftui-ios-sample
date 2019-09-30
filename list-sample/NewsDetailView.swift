//
//  NewsDetailView.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/29/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI

struct NewsDetailView: View {
    
    let article: Article
        
    var body: some View {
        VStack {
            Image("ic_news_placeholder")
                .frame(width: UIScreen.main.bounds.width - 100, height: (UIScreen.main.bounds.width - 100)  * 0.5 as CGFloat, alignment: Alignment.center)
                .scaledToFill()
            
            Text(verbatim: article.title)
            
            HStack {
                Image(uiImage:  #imageLiteral(resourceName: "ic_publish"))
                    .frame(width: CGFloat(20.0), height: CGFloat(20.0), alignment: Alignment.center)
                Text(article.publishedDateStr)
            }
            .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            
            HStack {
                Image(uiImage:  #imageLiteral(resourceName: "ic_author"))
                    .frame(width: CGFloat(20.0), height: CGFloat(20.0), alignment: Alignment.center)
                Text(article.sourceName)
                    .font(.subheadline)
            }
            .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))

            Text(article.description)
                .lineLimit(100)
                .font(.subheadline)
                .padding(.top, CGFloat(16.0))
        }
        .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
        .offset(x: 0, y: -180)
        .padding(.bottom, -180)
    
    }
}


#if DEBUG
struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(article: Article.getDefault())
    }
}
#endif

