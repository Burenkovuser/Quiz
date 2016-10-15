//
//  StoreManager.swift
//  Quiz
//
//  Created by Vasilii on 09.10.16.
//  Copyright © 2016 Vasilii Burenkov. All rights reserved.
//

import UIKit

class StoreManager {
    func loadQuestionsByTheme(themeName:String) -> [Question]? {
        
        //найдем путь к файлу с информацией о викторине
        let path = NSBundle.mainBundle().pathForResource("cinema", ofType: "json")
        
        //проверить условие и продолжить дальше если оно выполняется
        guard path != nil else {
            return nil
        }
        
        //загрузим сюда данные
        let data = NSData(contentsOfFile: path!)
        
        guard data != nil else {
            return nil
        }
        
        do {
            
            // преобраздуем байты в объект
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
            
            print(json)
            
            let questionsInfos = json["questions"] as! [NSDictionary]
            
            // создаем массив из Qestion объектов
            var questionsObjects = [Question]()
            
            for info in questionsInfos {
                let qestionObject = Question(json: info)
                questionsObjects.append(qestionObject)
            }
            
            return questionsObjects
            
        }
        catch {
            print("Oopps did not get object from data:\(error)")
            return nil
            
        }
    }
}