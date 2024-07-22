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

### ImagePicker Struct

The `ImagePicker` struct wraps a `PHPickerViewController` and manages its lifecycle. It uses a coordinator to handle communication between the picker and SwiftUI.

```swift
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
       ​⬤
