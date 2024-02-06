//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by FANG-LIN HE on 05.02.2024.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .foregroundStyle(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
            
    }
}

#Preview {
    ThemeView(theme: .buttercup)
}
