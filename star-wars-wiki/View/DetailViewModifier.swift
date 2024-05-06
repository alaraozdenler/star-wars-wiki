//
//  DetailViewModifier.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 06.05.24.
//

import Foundation
import SwiftUI

struct DetailViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
            .background(Color(.white))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .padding(5)
    }
}
