//
//  Card.swift
//  Set
//
//  Created by 张龙翔 on 2021/5/15.
//

import Foundation
struct Card: CustomStringConvertible, Equatable {
    var color: Color
    var number: Number
    var shape: Shape
    var fill: Fill
    
    enum Color: String {
        case red = "red"
        case green = "green"
        case purple = "purple"
        var description: String {
            return rawValue
        }
        static let all = [Color.red, .green, .purple]
    }
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        var description: String {
            return String(rawValue)
        }
        static let all = [Number.one, .two, .three]
    }
    
    enum Shape: String {
        case circle = "circle"
        case square = "square"
        case triangle = "triangle"
        var description: String {
            return rawValue
        }
        static let all = [Shape.circle, .square, .triangle]
    }
    
    enum Fill: String {
        case solid = "solid"
        case stripe = "stripe"
        case empty = "empty"
        var description: String {
            return rawValue
        }
        static let all = [Fill.solid, .stripe, .empty]
    }
    
    var description: String {
        return "color: \(color) number: \(number) shape: \(shape) fill: \(fill)"
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.shape == rhs.shape && lhs.number == rhs.number && lhs.fill == rhs.fill
    }
}

