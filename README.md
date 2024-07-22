# Hacking with Swift Coordinators

This project demonstrates how to use coordinators to manage SwiftUI view controllers, based on Paul Hudson's tutorial from Hacking with Swift.

## Overview

In this project, we explore how to wrap a UIKit view controller (specifically `PHPickerViewController`) inside a SwiftUI view using `UIViewControllerRepresentable`. Additionally, we use SwiftUI's coordinators to handle communication between the UIKit view controller and SwiftUI, allowing us to respond to user interactions such as selecting an image or pressing cancel.

## Key Concepts

### SwiftUI Coordinators

- **Coordinator Class**: Acts as a delegate for a UIKit view controller.
- **UIViewControllerRepresentable**: A protocol that allows you to integrate UIKit view controllers into SwiftUI.
- **@Binding Property Wrapper**: Facilitates the communication and state updates between SwiftUI views and UIKit view controllers.

## Implementation Details

1. **ImagePicker Struct**: This struct conforms to `UIViewControllerRepresentable` and wraps a `PHPickerViewController`. It defines the `makeUIViewController` and `updateUIViewController` methods to manage the UIKit view controller's lifecycle.

2. **Coordinator Class**: Nested inside `ImagePicker`, this class conforms to `PHPickerViewControllerDelegate` and handles the communication between the picker and the SwiftUI view. It updates the bound image property when a user selects an image.

## Usage

To use the image picker in your SwiftUI view, you need to create an instance of `ImagePicker` and provide a binding to a `UIImage?` property. When the user selects an image, the coordinator updates this bound property, and the SwiftUI view can react to the change.

### Example

Here's a simple usage example in a SwiftUI view:

```swift
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
            }

            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $image)
        }
    }
}
