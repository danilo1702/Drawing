//
//  LineModel.swift
//
//
//  Created by Danilo Hernandez on 12/01/24.
//

import Foundation
import SwiftUI

public struct LineModel {
    public var points = [CGPoint]()
    public var color: Color = .black
    public var lineWidth: Double = 1.0
    public init(points: [CGPoint] = [CGPoint](), color: Color = .black, lineWidth: Double = 1.0) {
        self.points = points
        self.color = color
        self.lineWidth = lineWidth
    }
}

public struct linesModelApi: Codable {
    public var points: [CGPoint]
    public var color: String
    public var lineWidth: Double
    public init(points: [CGPoint], color: String, lineWidth: Double) {
        self.points = points
        self.color = color
        self.lineWidth = lineWidth
    }
}

