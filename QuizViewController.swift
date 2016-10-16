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
    
    @IBOutlet weak var pointsLable: UILabel!
    
    var question:Question?
    var victorina: [Question]?
    var earnedPoints = 0 {
        // каждый раз, когда значение заработанных очков изменилось будем обновлять текст
        didSet {
            if oldValue == earnedPoints {
                print("Значение изменилось")
                return
            }
            if (earnedPoints < 0) {
                earnedPoints = 0
            }
            setupPointsLable()
        }
    }
    
    //MARK: - View LifeCycle
    
    //в этот момент лучше всего зняться загрузкой требовательных операций чего-то, что потребует большого 
    //количества времени
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        prepareToAnimate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        quizView.show(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        quizView.show(false, animated: true)
    }
    
    func prepareToAnimate() {
        quizView.show(false, animated:false)
    }
    
    //MARK: - Setup
    

    func setup() {
        title = "Кино"
        self.view.backgroundColor = UIColor.orangeColor()
        
        setupModel()
        setupViewWithQuestion(question!)
    }
    
    func setupModel() {
        
        if victorina != nil {
            question = victorina?.first
            return
        }
        
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
    
    func setupPointsLable() {
        let totalQuestionsCount = victorina!.count
        let result = "Очков набрано  + \(earnedPoints) из \(totalQuestionsCount)"
        pointsLable.text = result
    }
}


extension QuizViewController: ViewWilthButtonDelegate {
    func buttonWithTitlePressed(title: String) {
        
        if question!.isCorrectAnswer(title) {
            print("You winner")
            earnedPoints += 1
           
        } else {
        print("Sorry. Go back to school")
        }
        
        let nextQuestion: Question
        var index = victorina?.indexOf({ $0 === question! })
        index! += 1
        
        //Пока не дошли до последнего вопроса будем показыать следующий
        if index < victorina?.count {
            nextQuestion = victorina![index!]
            question = nextQuestion
            setupViewWithQuestion(question!)
            return
        }
        
        let result = Double(earnedPoints) / Double(victorina!.count)
        //запустим переход к новому вьюконтроллеру
        performSegueWithIdentifier("Show Raiting", sender: result)
    }
    //перед переходом на новый экран вызывается этот метод, где мы можем получить 
    //информацию о следующем контролллере
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is ResultViewController {
            let nextViewController = segue.destinationViewController as! ResultViewController
            nextViewController.raiting = sender as! Double
        }
    }
}
























