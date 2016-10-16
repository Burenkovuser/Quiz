//
//  ViewWilthButton.swift
//  Quiz
//
//  Created by Vasilii Burenkov on 07/10/16.
//  Copyright © 2016 Vasilii Burenkov. All rights reserved.
//

import UIKit

protocol ViewWilthButtonDelegate:class {
    func buttonWithTitlePressed(title:String)
}

class ViewWilthButton: UIView {

    var delegate:ViewWilthButtonDelegate?
    
    //текст
    @IBOutlet var topText:UILabel!
    
    //картинка
    @IBOutlet var imageView:UIImageView!
    
    @IBOutlet var button1:UIButton!
    @IBOutlet var button2:UIButton!
    @IBOutlet var button3:UIButton!
    @IBOutlet var button4:UIButton!
    
    @IBAction func buttonPressed(button:UIButton){
        
        delegate?.buttonWithTitlePressed(button.titleForState(UIControlState.Normal)!)
    }
    
    func show(show:Bool, animated:Bool) {
        
        let duration:NSTimeInterval = animated ? 0.3 : 0
        let backgroundColor = show ? UIColor.whiteColor() : UIColor.purpleColor()
        
        
         //Анимация вьюхи, на которой лежат все остальные представления
        UIView.animateWithDuration(duration, animations:  { () -> Void in
            let alpha = show ? 1 : 0
            self.alpha = CGFloat(alpha)
            self.backgroundColor = backgroundColor
            
        } ){(completed) -> Void in
            self.showButtons(show, animated: animated)
        }
        
        // Показать заголовок
        let titleDuration: NSTimeInterval = animated ? 0.25 : 0
        
        // по завершению первой анимации запустим следующую
        UIView.animateWithDuration(titleDuration, animations: { () -> Void in
            self.topText.alpha = show ? 1 : 0
            })
        { (compleled) -> Void in
            
            
            UIView.animateWithDuration(titleDuration, animations: { 
                //по завершению показаза заголовка, отобразить картинку
                // изменим ее масштаб по горизотали и по вертикали
                let scale: CGFloat = show ? 1.2 : 0.001
                let transform = CGAffineTransformMakeScale(scale, scale)
                self.imageView.transform = transform
            })
                { (compleled) -> Void in
                    
                    // приведем картинку к исходному размеру если нужно ее показать
                    let finalScaleDuration = animated ? 0.1 : 0
                    UIView.animateWithDuration(finalScaleDuration, animations: { 
                        
                        //получилось что для изображения мы сначала чуть расширили, а потом уменьшили картинку
                        let finalScale:CGFloat = show ? 1.0 : 0.001
                        let transform = CGAffineTransformMakeScale(finalScale, finalScale)
                        self.imageView.transform = transform
                    })

            }
         
        }
    }
    
    func showButtons (show: Bool, animated: Bool) {
        
        let shitXLeft   = show ? 0 : -self.button1.frame.size.width
        let shiftXRight = -shitXLeft
        let duration    = animated ? 0.4 : 0
        
        move(button1, toTranslation: shitXLeft, withDuration: duration, options: [UIViewAnimationOptions.CurveEaseIn])
        move(button3, toTranslation: shitXLeft, withDuration: duration, options: [.CurveEaseOut])
        move(button2, toTranslation: shiftXRight, withDuration:duration, options: [.CurveLinear])
        move(button4, toTranslation: shiftXRight, withDuration: duration, options: [.CurveEaseInOut])
    }
    
    func move(button: UIButton, toTranslation:CGFloat, withDuration: NSTimeInterval, options: UIViewAnimationOptions){
        
        UIView.animateWithDuration(withDuration,
                                   delay: 0,
                                   options: options,
                                   animations: {
                                    let transform = CGAffineTransformMakeTranslation(toTranslation, 0)
                                    button.transform = transform
            },
                                   completion: nil)
    }
    
    func updateTopText(text:String){
        topText.text = text
    }
    
    //передается optional переменная
    //т.е. может быть либо UIImage либо
    //в качестве параметра придет пустота
    func updateImage(picture:UIImage?){
        
        if picture == nil {
            imageView.alpha = 0
            return
        }
        
        imageView.image = picture
        imageView.alpha = 1
    }
    
    func updateButtonsTitles(titles:[String]) {
        
        //перебрать все элементы внутри titles
        //aTitle - это название элемента когда мы будем их все перебирать на каждом шаге
        for aTitle in titles {
            //распечатаем значение каждой строки
            print("one of titles is: \(aTitle)")
        }
        
        let allButtons = [button1,button2,button3,button4]
        
        //index = 0,1,2,...,  до titles.count
        for index in 0..<titles.count {
            //обратимся к элементу массива под номером 
            //от 0 до последнего
            let stringToAdd = titles[index]
            let aButton = allButtons[index]
            
            //задать текст кнопки для самого общего случая
            aButton.setTitle(stringToAdd,
                forState: UIControlState.Normal)
        }
    }
}












