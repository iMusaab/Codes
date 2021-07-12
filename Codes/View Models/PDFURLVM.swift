//
//  PDFURLVM.swift
//  Codes
//
//  Created by Musab Aljarba on 01/12/1442 AH.
//

import Foundation

class PDFURLListViewModel: ObservableObject {
    private var fireStoreManager: FirestoreManager = FirestoreManager()
    
    @Published var pdfURls: [PdfURLViewModel] = []
    
    @Published var urlsSaved = false
    
    @Published var errorInGettingURL = false
    

    
    func getPDFURLs() {

        
        fireStoreManager.getTermsDocument { result in
            switch result {
            case .success(let pdfUrls):
                if let pdfUrls = pdfUrls {
                    DispatchQueue.main.async {
                        self.pdfURls = pdfUrls.map(PdfURLViewModel.init)
                        print("PDFurls saved successfully")
                        self.urlsSaved = true
                    }
                }
            case .failure(let error):
                print("error loading urls", error.localizedDescription)
                self.errorInGettingURL = true
            }
        }
    }
    
    
    
    
}

struct PdfURLViewModel: Identifiable {
    
    
    let PdfURL: PDFURL
    
    var id: String { // has been named id instead of storeid in order to conform to identifible
        PdfURL.id ?? ""
    }
    
    var TermsAndCondetionsURL: String {
        PdfURL.TermsAndCondetionsURL
    }
    
    var privacyPDFURL: String {
        PdfURL.privacyPDFURL
    }

}
