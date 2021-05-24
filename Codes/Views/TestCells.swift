//
//  TestCells.swift
//  Codes
//
//  Created by Musab Aljarba on 06/10/1442 AH.
//

import SwiftUI

struct TestCells: View {
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(spacing: 0) {
            ScrollView {
                VStack {
                    CodesView()
                        .frame(height: 220, alignment: .center)
                    CodeWithVotesView()
                        .frame(height: 200, alignment: .center)
                    CodeWithVotesView()
                        .frame(height: 200, alignment: .center)
                    
                    
                }
            }
            
            }
            
                }
        
            }
    
        }

    

struct TestCells_Previews: PreviewProvider {
    static var previews: some View {
        TestCells()
    }
}
