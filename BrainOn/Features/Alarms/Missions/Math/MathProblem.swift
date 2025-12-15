//
//  MathProblem.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 14/12/25.
//

import Foundation

struct MathProblem {
    
    let question: String
    let answer: Int
    
    static func generate(difficulty: Difficulty) -> MathProblem {
        switch difficulty {
        case .easy:
            let a = Int.random(in: 5...20)
            let b = Int.random(in: 5...20)
            
            return MathProblem(question: "\(a) + \(b)", answer: a + b)
        case .medium:
            let a = Int.random(in: 10...50)
            let b = Int.random(in: 5...30)
            let c = Int.random(in: 1...10)
            
            return MathProblem(question: "\(a) + \(b) - \(c)", answer: a + b - c)
        case .hard:
            let a = Int.random(in: 2...9)
            let b = Int.random(in: 2...9)
            let c = Int.random(in: 10...50)
            
            return MathProblem(question: "(\(a) x \(b)) + \(c)", answer: a * b + c)
        }
    }
}
