//
//  AddButton.swift
//  Codes
//
//  Created by Musab Aljarba on 08/10/1442 AH.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        
            Image(systemName: "plus")
                .foregroundColor(Color(#colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)))
                .font(.system(size: 12, weight: .semibold))
//                .padding(5)
                .frame(width: 25, height: 25)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)).opacity(0.1), radius: 3, x: 0, y: 3)
                
        
       
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
