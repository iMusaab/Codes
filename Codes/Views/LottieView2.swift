//
//  LottieView2.swift
//  Codes
//
//  Created by Musab Aljarba on 06/12/1442 AH.
//

import SwiftUI
import Lottie
import UIKit

struct lottieView2: UIViewRepresentable {
    var fileName: String
    
    func makeUIView(context: Context) -> AnimationView {
        
        let view = AnimationView(name: fileName, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        view.play(fromFrame: 24, toFrame: 75)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalTo: view.widthAnchor),
                    view.heightAnchor.constraint(equalTo: view.heightAnchor)
                ])
        
        return view
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
    }
    
    
}
