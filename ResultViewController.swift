//
//  ResultViewController.swift
//  Quiz
//
//  Created by Vasilii on 14.10.16.
//  Copyright © 2016 Vasilii Burenkov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var ratingText: UILabel!
    var raiting: Double = 0 {
        didSet {
            if raiting > 1 {
                raiting = 1
            }
            if raiting < 0 {
                raiting = 0
            }
        }
    }
    //значение от 0 до 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateText()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func updateText() {
        switch raiting {
        case 0..<0.1:
            ratingText.text = "Повезет в другой раз"
        case 0.1..<0.4:
            ratingText.text = "Бывало и получше"
        case 0.4..<0.8:
            ratingText.text = "Бывало и похуже"
        default:
            ratingText.text = "Сразу видно чемпиона!"
        }
    }
}
