//
//  QuizViewController.swift
//  Quiz
//
//  Created by Vasilii Burenkov on 07/10/16.
//  Copyright © 2016 Vasilii Burenkov. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizView: ViewWilthButton!
    
    var question:Question?
    var victorina: [Question]?
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    func setup() {
        self.view.backgroundColor = UIColor.orangeColor()
        
        setupModel()
        setupViewWithQuestion(question!)
    }
    
    func setupModel() {
        let storeManager = StoreManager()
        victorina = storeManager.loadQuestionsByTheme("theme")
        question = victorina?.first
        
            }
    
    func setupViewWithQuestion(aQuestion:Question) {
        
        quizView.updateTopText(aQuestion.text)
        quizView.updateImage(aQuestion.image)
        quizView.updateButtonsTitles(aQuestion.answers)
        
        quizView.delegate = self
    }
}


extension QuizViewController: ViewWilthButtonDelegate {
    func buttonWithTitlePressed(title: String) {
        
        if question!.isCorrectAnswer(title) {
            print("You winner")
            return
        }
        print("Sorry. Go back to school")
    }
}
























