//
//  MeView.swift
//  HotProspects
//
//  Created by Mantosh Kumar on 03/11/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@gmail.com"
  
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
       
        NavigationStack {
            Form {
                TextField("Your Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("email id", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: generateQRCode(from: "\(name)\n \(emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            .navigationTitle("Your QR Code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
