//
//  MainHomeView.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/29/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI

struct MainHomeView: View {
    @State private var searchQuery: String = "cricket"
    @EnvironmentObject var viewModel: MainHomeViewModel
    
    
    var todayStr: String {
        let df = DateFormatter()
        df.dateFormat = "EEE, dd MMM yyyy"
        return df.string(from: Date())
    }
    
    var placeholderKey: LocalizedStringKey {
        return LocalizedStringKey("Search")
    }
    
    var body: some View {
        NavigationView {
            List{
                SearchBarView(text: $searchQuery, placeholder: placeholderKey, onCommit: search)

                ForEach(viewModel.articals, id: \.self) { artcl in
                    NavigationLink(destination: NewsDetailView(article: artcl)) {
                        NewsRowView(article: artcl)
                    }
                }.navigationBarTitle(todayStr)
            }
            .navigationBarTitle(Text(todayStr))
        }.onAppear(perform: search)
    }
    
    private func search() {
        viewModel.search(forQuery: searchQuery)
    }
}

#if DEBUG
struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}
#endif
