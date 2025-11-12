//
//  GhibliApp.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import SwiftUI

@main
struct GhibliApp: App {
    var body: some Scene {
        WindowGroup {
            FilmListView(viewModel: FilmListViewModel(service: DefaultGhibliService()))
        }
    }
}
