//
//  ResultTableViewCell.swift
//  Alireza
//
//  Created by Alireza on 2023-03-20.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var resultLabel: UILabel!

    func configure(with result: MathResult) {
        let resultText = """
        Question: \(result.question.getQuestionText())
        Right Answer: \(result.question.answer)
        Your Answer: \(result.userAnswer) -
        """
        
        let resultStatus = result.isCorrect ? " Right" : " Wrong"
        let textColor = result.isCorrect ? UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0) : UIColor.red
        
        let resultTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.black
        ]
        
        let resultStatusAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: textColor
        ]
        
        let attributedResultText = NSMutableAttributedString(string: resultText, attributes: resultTextAttributes)
        let attributedResultStatus = NSAttributedString(string: resultStatus, attributes: resultStatusAttributes)
        
        attributedResultText.append(attributedResultStatus)
        
        resultLabel.numberOfLines = 0
        resultLabel.attributedText = attributedResultText
    }

}

