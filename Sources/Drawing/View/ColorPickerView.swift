//
//  ColorPickerView.swift
//
//
//  Created by Danilo Hernandez on 12/01/24.
//

import SwiftUI

struct ColorPickerView: View {
    
    @State var  colors: [Color] = [Color.black]
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
            
                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill : Constants.Icons.circleFill)
                    .foregroundColor(color)
                    .font(.system(size: 16))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(.black))
}
