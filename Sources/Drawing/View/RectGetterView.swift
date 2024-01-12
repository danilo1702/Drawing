//
//  RectGetterView.swift
//
//
//  Created by Danilo Hernandez on 12/01/24.
//

import SwiftUI

struct RectGetterView: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }

    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

#Preview {
    RectGetterView(rect: .constant(CGRect(x: 100, y: 100, width: 100, height: 100)))
}
