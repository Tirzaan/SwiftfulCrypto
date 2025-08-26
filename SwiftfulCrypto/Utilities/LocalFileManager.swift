//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/25/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() {}
    
    
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // Create Folder
        createFolderIfNeeded(filderName: folderName)
        
        // Get Path For Image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        // Save Image To Path
        do {
            try data.write(to: url)
        } catch let error {
            print("ERROR Saving Image '\(imageName)': \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(filderName: String) {
        guard let url = getURLForFolder(folderName: filderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("ERROR Creating Folder '\(filderName)': \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
}
