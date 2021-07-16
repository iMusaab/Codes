//
//  LikeAnimation.swift
//  Codes
//
//  Created by Musab Aljarba on 06/12/1442 AH.
//

import SwiftUI

struct LikeAnimation: View {
    var body: some View {
        
        VStack {
            LottieView(fileName: "like").frame(width: 50, height: 50, alignment: .center)
        }
    }
}

struct LikeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LikeAnimation()
    }
}
