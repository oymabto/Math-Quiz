//
//  Question.swift
//  Alireza
//
//  Created by Alireza on 2023-03-17.
//

import Foundation

enum MathOperation: CaseIterable {
    case addition, subtraction, multiplication, division
}

struct MathQuestion {
    let operation: MathOperation
    let firstOperand: Int
    let secondOperand: Int
    let answer: Answer
    
    enum Answer {
        case value(Double)
        case error
    }
    
    static func generateRandom() -> MathQuestion {
        let operation = MathOperation.allCases.randomElement()!
        let firstOperand = Int.random(in: -9...9)
        let secondOperand = Int.random(in: -9...9)
        var answer: Answer
        
        switch operation {
        case .addition:
            answer = .value(Double(firstOperand + secondOperand))
        case .subtraction:
            answer = .value(Double(firstOperand - secondOperand))
        case .multiplication:
            answer = .value(Double(firstOperand * secondOperand))
        case .division:
            if secondOperand == 0 {
                answer = .error
            } else {
                let result = Double(firstOperand) / Double(secondOperand)
                answer = .value(result.rounding(toDecimal: 2))
            }
        }
        
        return MathQuestion(operation: operation, firstOperand: firstOperand, secondOperand: secondOperand, answer: answer)
    }
    
    func getQuestionText() -> String {
        let secondOperandString = secondOperand < 0 ? "(\(secondOperand))" : "\(secondOperand)"
        switch operation {
        case .addition:
            return "\(firstOperand) + \(secondOperandString)"
        case .subtraction:
            return "\(firstOperand) - \(secondOperandString)"
        case .multiplication:
            return "\(firstOperand) * \(secondOperandString)"
        case .division:
            return "\(firstOperand) ÷ \(secondOperandString)"
        }
    }
}
extension Double {
    func rounding(toDecimal decimal: Int) -> Double {
        let divisor = pow(10.0, Double(decimal))
        return (self * divisor).rounded() / divisor
    }
}


