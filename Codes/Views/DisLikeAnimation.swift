//
//  DisLikeAnimation.swift
//  Codes
//
//  Created by Musab Aljarba on 06/12/1442 AH.
//

import SwiftUI

struct DisLikeAnimation: View {
    var body: some View {
        VStack {
            LottieView(fileName: "dislike").frame(width: 50, height: 50, alignment: .center)
        }
    }
}

struct DisLikeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        DisLikeAnimation()
    }
}
