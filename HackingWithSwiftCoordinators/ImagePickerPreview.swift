//
//  ImagePickerPreview.swift
//  HackingWithSwiftCoordinators
//
//  Created by Akram Husseini on 22/07/2024.
//

import SwiftUI

struct ImagePickerPreview: View {
    @State private var image: UIImage?

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
            ImagePicker(image: $image)
                .frame(height: 300) // This frame is just to show the ImagePicker in the preview
        }
    }
}

struct ImagePickerPreview_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerPreview()
    }
}
