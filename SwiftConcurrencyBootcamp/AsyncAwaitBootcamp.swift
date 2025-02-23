//
//  AsyncAwaitBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Jackie Lu on 2024/8/26.
//

import SwiftUI

class AsyncAwaitBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title1 : \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title2 : \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)
                
                let title3 = "Title3 : \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor1() async {
        let author1 = "Author1 : \(Thread())"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let author2 = "Author2 : \(Thread())"
        await MainActor.run {
            self.dataArray.append(author2)

            let author3 = "Author3 : \(Thread())"
            self.dataArray.append(author3)
        }
        
        await doSomething()
    }
    
    func doSomething() async {
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something1 = "Something1 : \(Thread())"
        await MainActor.run {
            self.dataArray.append(something1)

            let something2 = "Something2 : \(Thread())"
            self.dataArray.append(something2)
        }
    }
}

struct AsyncAwaitBootcamp: View {
    
    @StateObject private var viewModel = AsyncAwaitBootcampViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
            Task {
              await viewModel.addAuthor1()
                
                let finalText = "FINAL TEXT : \(Thread())"
                viewModel.dataArray.append(finalText)
            }
//            viewModel.addTitle1()
//            viewModel.addTitle2()
        }
    }
}

#Preview {
    AsyncAwaitBootcamp()
}
