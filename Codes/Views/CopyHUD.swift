//
//  CopyHUD.swift
//  Codes
//
//  Created by Musab Aljarba on 05/10/1442 AH.
//

import SwiftUI

struct HUD: View {
    @ViewBuilder var body: some View {
        Text("تم النسخ")
            .foregroundColor(.black)
            .padding(.horizontal, 10)
            .padding(14)
            .background(
                Color.white
                    .clipShape(Capsule())
                    .shadow(color: Color(.black).opacity(0.22), radius: 12, x: 0, y: 5)
            )
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct CopyHUD_Previews: PreviewProvider {
    static var previews: some View {
        HUD()
    }
}
