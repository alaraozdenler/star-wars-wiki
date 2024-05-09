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
            .background(Color(.systemBackground))
            .cornerRadius(5)
            .shadow(color: ((UIViewController().traitCollection.userInterfaceStyle == .light) ? Color(.black) : Color(.white)).opacity(0.2), radius: 5)
            .padding(5)
    }
}
