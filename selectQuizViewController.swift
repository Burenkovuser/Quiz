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
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.destinationViewController is QuizViewController {
            let nextViewController = segue.destinationViewController as! QuizViewController
            let quizJSON  = sender as! [String:AnyObject]
            
            let namt = quizJSON["name"] as! String
            //let question  = quizJSON["questions"]
            
            let questionsInfos = quizJSON["questions"] as! [NSDictionary]
            
            // создаем массив из Qestion объектов
            var questionsObjects = [Question]()
            
            for info in questionsInfos {
                let qestionObject = Question(json: info)
                questionsObjects.append(qestionObject)
            }

            nextViewController.victorina = questionsObjects
            nextViewController.title = namt
            
        }
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

extension selectQuizViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuizes!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuizeCell", forIndexPath: indexPath)
        let quize = quizAtIndexPath(indexPath)
        let name = quize["name"] as! String
        
        cell.textLabel?.text = name
        
        return cell
    }
    
    func quizAtIndexPath(index:NSIndexPath) -> [String : AnyObject] {
        return allQuizes![index.row]
    }
}

extension selectQuizViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedQuizes = quizAtIndexPath(indexPath)
        performSegueWithIdentifier("Show Quize", sender: selectedQuizes)
    }
    
}