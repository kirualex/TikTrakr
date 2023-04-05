//
//  TikTrakrApp.swift
//  TikTrakr
//
//  Created by Alexis Creuzot on 04/04/2023.
//

import SwiftUI

@main
struct TikTrakrApp: App {
    var body: some Scene {
        WindowGroup {
            TimerListView()
                .preferredColorScheme(.dark)
        }
    }
}

struct TikTrakrApp_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
            .preferredColorScheme(.dark)
    }
}
