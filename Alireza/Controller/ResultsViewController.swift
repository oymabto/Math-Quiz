//
//  ResultsViewController.swift
//  Alireza
//
//  Created by Alireza on 2023-03-18.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var registerNameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var scorePercentageLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    var results: [MathResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isScrollEnabled = true
        tableView.isUserInteractionEnabled = true
        
        scorePercentageLabel.numberOfLines = 0
        scorePercentageLabel.text = "\(calculateScore()) %"
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell
        
        let result = results[indexPath.row]
        cell.configure(with: result)
        
        return cell
    }
    
    func calculateScore() -> Double {
        let correctAnswers = results.filter { $0.isCorrect }.count
        let totalQuestions = results.count
        let score = Double(correctAnswers) / Double(totalQuestions) * 100
        return round(score * 10) / 10
    }
    
}

