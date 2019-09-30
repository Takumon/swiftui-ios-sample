//
//  NewsImageView.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/29/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI

struct NewsImageView: View {
    var image: Image
    
    var body: some View {
        image
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 1))
        .shadow(radius: 10)
    }
}

#if DEBUG
struct NewsImageView_Previews: PreviewProvider {
    static var previews: some View {
        NewsImageView(image: Image(systemName: "photo"))
    }
}
#endif
