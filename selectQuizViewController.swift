//
//  selectQuizViewController.swift
//  Quiz
//
//  Created by Vasilii on 15.10.16.
//  Copyright © 2016 Vasilii Burenkov. All rights reserved.
//

import UIKit

class selectQuizViewController: UIViewController {
    
    //класс из объектов ключ: значение
    var allQuizes: [ [String:AnyObject] ]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allQuizes = loadAllQuizes()

        // Do any additional setup after loading the view.
    }
    
    func loadAllQuizes() -> [ [String:AnyObject] ] {
        let allJSONfinlesPaths = NSBundle.mainBundle().pathsForResourcesOfType("json", inDirectory: nil)
        
        var loadedJSONs = [ [String:AnyObject] ] ()
        //пребрать все пути к файлам JSON
        for aPath in allJSONfinlesPaths {
            let dataAtPath = NSData(contentsOfFile: aPath)
            // попытаемся считать данные из некой директории
            do {//приобразуем их в объект
                let json = try NSJSONSerialization.JSONObjectWithData(dataAtPath!, options: [])
                loadedJSONs.append(json as! [String:AnyObject])
            }
            catch {
                print ("Get not object from from.file \(aPath)")
            }
        }
    
    print ("found json \(loadedJSONs)")
    return loadedJSONs
    }
}



