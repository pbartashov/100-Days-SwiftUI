//
//  MeView.swift
//  HotProspects
//
//  Created by Pavel Bartashov on 16/10/2024.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    
    @AppStorage("name") private var name = Prospect.default.name
    @AppStorage("emailAddress") private var emailAddress = Prospect.default.emailAddress
    
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .textContentType(.name)
                .font(.title)
            
            TextField("Email address", text: $emailAddress)
                .textContentType(.name)
                .font(.title)
            
            Image(uiImage: qrCode)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .contextMenu {
                    let image = Image(uiImage: qrCode)
                    
                    ShareLink(
                        item: image,
                        preview: SharePreview("My QR code", image: image)
                    )
                }
        }
        .navigationTitle("Your code")
        .onAppear(perform: updateQRCode)
        .onChange(of: name, updateQRCode)
        .onChange(of: emailAddress, updateQRCode)
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outpuImage = filter.outputImage,
           let cgImage = context.createCGImage(outpuImage, from: outpuImage.extent)
        {
            return UIImage(cgImage: cgImage)
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    private func updateQRCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
}

#Preview {
    MeView()
}
