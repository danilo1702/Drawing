//
//  UIView+Extensions.swift
//
//
//  Created by Danilo Hernandez on 12/01/24.
//

import Foundation
import SwiftUI

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
