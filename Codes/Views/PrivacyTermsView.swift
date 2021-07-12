//
//  SwiftUIView.swift
//  Codes
//
//  Created by Musab Aljarba on 01/12/1442 AH.
//

import SwiftUI
import PDFKit


struct PrivacyTermsView: View {
    @StateObject var downloadModel = DownloadTaskModel()
    @StateObject private var pdfURLVM = PDFURLListViewModel()
    
    var document: documentType
    
    enum documentType {
        case Privacy
        case termsAndServices
    }
    
    
    var body: some View {
        if downloadModel.PDFSavedSuccefully {
            if let url = downloadModel.url {
            PDFKitView(url: url)
//                .ignoresSafeArea(.all)
            } else {
                Text("فشل الاتصال بالخادم")
            }
            
        } else if pdfURLVM.errorInGettingURL {
            Text("فشل الاتصال بالخادم")
        } else {
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    //                                            .scaleEffect(1.5, anchor: .center)
                    Spacer()
                }
            }
            
            .onAppear(perform: {
//                downloadModel.downloadAPDF()
                pdfURLVM.getPDFURLs()
            })
            .onChange(of: pdfURLVM.urlsSaved, perform: { value in
                if value {
                    switch document {
                    
                    case .Privacy:
                        downloadModel.downloadAPDF(url: pdfURLVM.pdfURls[0].privacyPDFURL)
                    case .termsAndServices:
                        downloadModel.downloadAPDF(url: pdfURLVM.pdfURls[0].TermsAndCondetionsURL)
                    }
                    
                    
                    
                }
            })
        }
        
    }
}

struct PrivacyTermsView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyTermsView(document: .Privacy)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct PDFKitView: View {
    var url: URL

    var body: some View {
        PDFKitRepresentedView(url)
    }
}


