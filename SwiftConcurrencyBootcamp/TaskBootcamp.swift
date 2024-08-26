//
//  TaskBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Jackie Lu on 2024/8/26.
//

import SwiftUI

@MainActor
class TaskBootcampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5 * NSEC_PER_SEC)
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            self.image = UIImage(data: data)
            print("IMAGE RETURNED SUCCESSFULLY!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            self.image2 = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("CLICK ME! 🤓") {
                    TaskBootcamp()
                    
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    
    @StateObject private var viewModel = TaskBootcampViewModel()
//    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
//        .onDisappear {
//            fetchImageTask?.cancel()
//        }
//        .onAppear {
//            fetchImageTask = Task {
//                await viewModel.fetchImage()
//            }
//            Task {
//                print(Thread())
//                await viewModel.fetchImage2()
//            }
            
            
            
//            Task(priority: .high) {
////                try? await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
//                await Task.yield()
//                print("high : \(Thread())")
//            }
//            Task(priority: .userInitiated) {
//                print("userInitiated : \(Thread())")
//            }
//            Task(priority: .medium) {
//                print("medium : \(Thread())")
//            }
//            Task(priority: .low) {
//                print("low : \(Thread())")
//            }
//            Task(priority: .utility) {
//                print("utility : \(Thread())")
//            }
//            Task(priority: .background) {
//                print("background : \(Thread())")
//            }
            
//            Task(priority: .low) {
//                print("low : \(Thread())")
//                
//                Task.detached {
//                    print("detached : \(Thread())")
//                }
//            }
//        }
    }
}

#Preview {
    TaskBootcamp()
}
