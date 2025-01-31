//
//  ContentView.swift
//  HackingWithSwiftCoordinators
//
//  Created by Akram Husseini on 22/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var image: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else {
                Text("No Image Selected")
                    .foregroundColor(.gray)
                    .frame(height: 200)
            }

            Button("Select Image") {
                showingImagePicker = true
            }
            .padding()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
