////
////  DownloadTaskModel.swift
////  Codes
////
////  Created by Musab Aljarba on 30/11/1442 AH.
////
//

import Foundation
import FirebaseStorage
import Firebase
import PDFKit

class DownloadTaskModel: ObservableObject {
    // Create a reference with an initial file path and name
    let storage = Storage.storage()
    
    @Published var PDFSavedSuccefully = false
    @Published var url: URL?
    
    
    
    func downloadAPDF(url: String) {
        
        let pathReference = storage.reference(forURL: url)

        let tmporaryDirectoryURL = FileManager.default.temporaryDirectory
        let localURL = tmporaryDirectoryURL.appendingPathComponent("sample.pdf")
        
        let downloadTask = pathReference.write(toFile: localURL) { url, error in
          if let error = error {
            // Uh-oh, an error occurred!
            print("Error in retriving pdf file")
          } else {
            // Local file URL for "images/island.jpg" is returned
            if let url = url {
                print("url found:", url)
                self.PDFSavedSuccefully = true
                self.url = url
                
            }
          }
        }
            
    }
    

}
