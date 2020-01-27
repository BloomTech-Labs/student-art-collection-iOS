//
//  UploadImageOperation.swift
//  Artco
//
//  Created by Mitchell Budge on 1/27/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import Cloudinary

class UploadImageOperation: ConcurrentOperation {
    
    let image: UIImage
    private(set) var imageURL: String?
    
    init(image: UIImage) {
        self.image = image
    }
    
    override func start() {
        state = .isExecuting
        guard let data = image.jpegData(compressionQuality: 0.01) else { fatalError() }
        
        Cloudinary.shared.cloudinary.createUploader().upload(data: data, uploadPreset: "smasd6kx", params: nil, progress: nil).response({ (result, error) in
            
            defer { self.state = .isFinished }
            if self.isCancelled { return }
            
            if let error = error {
                NSLog("Error uploading image to Cloudinary: \(error)")
            }
            
            guard let returnedURL = result?.url else { return }
            self.imageURL = returnedURL
            
            })
    }
    
    override func cancel() {
        guard let data = image.jpegData(compressionQuality: 1) else { fatalError() }
        Cloudinary.shared.cloudinary.createUploader().upload(data: data, uploadPreset: "smasd6kx").cancel()
    }
    
}
