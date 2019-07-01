//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Denis Bystruev on 27/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multiLabels: [UILabel]!
    
    @IBOutlet var rangeStackView: UIStackView!
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet var progressView: UIProgressView!
    
    // MARK: - Properties
    var answersChosen = [Answer]()
    var questionIndex = 0
    var questions: [Question]!
    
    var currentQuestion: Question {
        return questions[questionIndex]
    }
    
    var currentAnswers: [Answer] {
        return currentQuestion.answers
    }

    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = Question.all
        updateUI()
    }
    
    // MARK: - Custom Methods
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        let progress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        questionLabel.text = currentQuestion.text
        progressView.setProgress(progress, animated: true)
        
        switch currentQuestion.type {
            
        case .single:
            updateSingleStack(with: currentAnswers)
            
        case .multiple:
            updateMultipleStack(with: currentAnswers)
            
        case .ranged:
            updateRangedStack(with: currentAnswers)
        }
    
    }
    
    func updateSingleStack(with answers: [Answer]) {
        singleStackView.isHidden = false
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: [])
        }
    }
    
    func updateMultipleStack(with answers: [Answer]) {
        multipleStackView.isHidden = false
        for (label, answer) in zip(multiLabels, answers) {
            label.text = answer.text
        }
    }
    
    func updateRangedStack(with answers: [Answer]) {
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
        rangeStackView.isHidden = false
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ResultsSegue" else { return }
        let destination = segue.destination as! ResultsViewController
        destination.responses = answersChosen
    }
    
    // MARK: - Actions
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        guard let answerIndex = singleButtons.firstIndex(of: sender) else { return }
        let answer = currentAnswers[answerIndex]
        answersChosen.append(answer)
        
        nextQuestion()
    }
    
    @IBAction func multipleButtonPressed(_ sender: UIButton) {
        for (index, view) in multipleStackView.arrangedSubviews.enumerated() {
            guard let stackView = view as? UIStackView else { continue }
            guard let switchView = stackView.arrangedSubviews.last as? UISwitch else { continue }
            if switchView.isOn {
                let answer = currentAnswers[index]
                answersChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed(_ sender: UIButton) {
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        let answer = currentAnswers[index]
        answersChosen.append(answer)
        
        nextQuestion()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let numberOfSteps = Float(currentAnswers.count - 1)
        let step = 1 / numberOfSteps
        let index = round(rangedSlider.value * numberOfSteps)
        sender.value = step * index
    }
}
