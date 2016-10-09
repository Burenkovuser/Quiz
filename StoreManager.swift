//
//  StoreManager.swift
//  Quiz
//
//  Created by Vasilii on 09.10.16.
//  Copyright © 2016 Vasilii Burenkov. All rights reserved.
//

import UIKit

class StoreManager {
    func loadQuestionsByTheme(themeName:String) -> [Question] {
        
       let question = Question(text: "Как звали няню Пушкина?",
                            answers: ["Вася",
                                "Арина Радионовна",
                                "Виолетта Акардионовна",
                                "Александра Юрьевна"],
                            correctAnswer: "Арина Радионовна",
                            imageName: "1")
        
        return [question]
    }

}
