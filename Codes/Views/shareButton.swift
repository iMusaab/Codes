//
//  shareButton.swift
//  Codes
//
//  Created by Musab Aljarba on 13/12/1442 AH.
//

import SwiftUI

struct shareButton: View {
    let activityViewController = SwiftUIActivityViewController()
    @State var uiImage: UIImage
    
    var body: some View {
        VStack {
            Button(action: {
                self.activityViewController.shareImage(uiImage: self.uiImage)
            }) {
                ZStack {
                    Image(systemName:"square.and.arrow.up")
                        .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)).opacity(0.9))
                    activityViewController
                }
            }.frame(width: 20, height: 20, alignment: .center)
        }
    }
}

struct shareButton_Previews: PreviewProvider {
    static var previews: some View {
        shareButton(uiImage: UIImage(imageLiteralResourceName: "AdidasPic"))
    }
}
class ActivityViewController : UIViewController {

    var uiImage:UIImage!

    @objc func shareImage() {
        let vc = UIActivityViewController(activityItems: [uiImage!], applicationActivities: [])
        vc.excludedActivityTypes =  [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        present(vc,
                animated: true,
                completion: nil)
        vc.popoverPresentationController?.sourceView = self.view
    }
}

struct SwiftUIActivityViewController : UIViewControllerRepresentable {

    let activityViewController = ActivityViewController()

    func makeUIViewController(context: Context) -> ActivityViewController {
        activityViewController
    }
    func updateUIViewController(_ uiViewController: ActivityViewController, context: Context) {
        //
    }
    func shareImage(uiImage: UIImage) {
        activityViewController.uiImage = uiImage
        activityViewController.shareImage()
    }
}
