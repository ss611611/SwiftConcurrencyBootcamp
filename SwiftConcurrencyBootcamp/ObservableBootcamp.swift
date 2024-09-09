 //
//  ObservableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Jackie Lu on 2024/9/9.
//

import SwiftUI

actor TitleDatabase {
    
    func getNewTitle() -> String {
        "Some new title!"
    }
}

@Observable class ObservableViewModel: ObservableObject {
    
    @ObservationIgnored let database = TitleDatabase()
    @MainActor var title: String = "Starting title"
    
    func updateTitle() {
        Task { @MainActor in
            title = await database.getNewTitle()
            print(Thread())
        }
    }
}

struct ObservableBootcamp: View {
    
    @StateObject private var viewModel = ObservableViewModel()
     
    var body: some View {
        Text(viewModel.title)
            .task {
                viewModel.updateTitle()
            }
    }
}

#Preview {
    ObservableBootcamp()
}
