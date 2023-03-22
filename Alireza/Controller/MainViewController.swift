//
//  MainViewController.swift
//  Alireza
//
//  Created by Alireza on 2023-03-18.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var massageLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var userAnswerTF: RestrictedTextField!
    
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet weak var floatButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var negativeButton: UIButton!
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var errorButton: UIButton!
    
    @IBOutlet weak var autoGenerateSwitch: UISwitch!
    
    
    private var currentQuestion: MathQuestion?
    private var results: [MathResult] = []
    private var currentQuestionValidated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNewQuestion()
        autoGenerateSwitch.isOn = false
        userAnswerTF.delegate = self
        updateButtonsState(validateEnabled: true)
    }
    
    @IBAction func autoGenerateSwitchChanged(_ sender: UISwitch) {
    }
    
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if let numberText = sender.titleLabel?.text {
            userAnswerTF.addCharacter(numberText)
        }
    }
    
    
    @IBAction func floatButtonPressed(_ sender: UIButton) {
        userAnswerTF.addCharacter(".")
    }
    
    @IBAction func negativeButtonPressed(_ sender: UIButton) {
        userAnswerTF.addCharacter("-")
    }
    
    @IBAction func generatebuttonpressed(_ sender: UIButton) {
        generateNewQuestion()
        updateButtonsState(validateEnabled: true)
    }
    
    @IBAction func errorButtonPressed(_ sender: UIButton) {
        if let question = currentQuestion, !currentQuestionValidated {
            if case .error = question.answer {
                handleValidation(isCorrect: true)
            } else {
                handleValidation(isCorrect: false)
            }
        }
    }
    
    
    @IBAction func validateButtonPressed(_ sender: UIButton) {
        guard let question = currentQuestion, !currentQuestionValidated else { return }
        
        let userAnswer = Double(userAnswerTF.text ?? "") ?? 0.0
        let isCorrect: Bool
        
        switch question.answer {
        case .value(let correctAnswer):
            isCorrect = correctAnswer == userAnswer
        case .error:
            isCorrect = false
        }
        
        handleValidation(isCorrect: isCorrect)
    }
    
    private func handleValidation(isCorrect: Bool) {
        massageLabel.text = isCorrect ? "Right" : "Wrong"
        massageLabel.textColor = isCorrect ? UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0) : UIColor.red
        
        let result = MathResult(question: currentQuestion!, userAnswer: userAnswerTF.text ?? "", isCorrect: isCorrect)
        results.append(result)
        
        currentQuestionValidated = true
        
        if autoGenerateSwitch.isOn {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.generateNewQuestion()
                self.updateButtonsState(validateEnabled: true)
            }
        } else {
            updateButtonsState(validateEnabled: false)
        }
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        userAnswerTF.text = ""
        
    }
    
    
    @IBAction func scoreButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showResults", sender: self)
        
    }
    
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            exit(0)
        }
    }
    
    private func updateButtonsState(validateEnabled: Bool) {
        validateButton.isEnabled = validateEnabled
        generateButton.isEnabled = !validateEnabled
        
        if autoGenerateSwitch.isOn {
            scoreButton.isEnabled = true
            clearButton.isEnabled = true
        } else {
            scoreButton.isEnabled = !validateEnabled
            clearButton.isEnabled = !validateEnabled
        }
    }
    
    private func generateNewQuestion() {
        currentQuestion = MathQuestion.generateRandom()
        updateButtonsState(validateEnabled: false)
        currentQuestionValidated = false
        questionLabel.text = currentQuestion?.getQuestionText()
        userAnswerTF.text = ""
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults",
           let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.results = results
        }
    }
    
}
