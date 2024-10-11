//
//  ContentView.swift
//  Instafilter
//
//  Created by Pavel Bartashov on 7/10/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {

    @Environment(\.requestReview) private var requestReview

    @AppStorage("filterCount") private var filterCount = 0

    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var showingFilters = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()

    private var context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                PhotosPicker(selection: $photosPickerItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView(
                            "No Picture",
                            systemImage: "photo.badge.plus",
                            description: Text("Tap to import a photo")
                        )
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: photosPickerItem, loadImage)

                Spacer()

                VStack {
                    HStack {
                        Text("Intensity")

                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                    }
                    .padding(.vertical)

                    HStack {
                        Text("Radius")

                        Slider(value: $filterRadius, in: 0...200)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                    .padding(.vertical)

                    HStack {
                        Button("Change filter", action: changeFilter)

                        Spacer()

                        if let processedImage {
                            ShareLink(
                                item: processedImage,
                                preview: SharePreview("Instafilter image", image: processedImage)
                            )
                        }

                    }
                }
                .disabled(processedImage == nil)
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Photo effect process") { setFilter(CIFilter.photoEffectProcess()) }
                Button("Photo effect mono") { setFilter(CIFilter.photoEffectMono()) }
                Button("xRay") { setFilter(CIFilter.xRay()) }
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    private func changeFilter() {
        showingFilters = true
    }

    private func loadImage() {
        Task {
            guard
                let imageData = try await photosPickerItem?.loadTransferable(type: Data.self),
                let inputImage = UIImage(data: imageData)
            else {
                return
            }

            let beginImage = CIImage(image: inputImage)

            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

            applyProcessing()
        }
    }

    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }

        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }

        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }

        guard
            let outputImage = currentFilter.outputImage,
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
        else {
            return
        }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }

    @MainActor
    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()

        filterCount += 1

        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
