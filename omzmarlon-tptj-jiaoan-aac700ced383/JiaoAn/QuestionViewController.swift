//
//  ViewController.swift
//  JiaoAn
//
//  Created by Marlon Ou on 2015-12-22.
//  Copyright (c) 2015 TPTJ. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //typeOtherInfoLabel stores information of title param. Use this to decide display of grade selected view when tap back image view
    
    
    @IBOutlet weak var mainQContainerView: UIView!
    
    @IBOutlet weak var difficultyImage: UIImageView!
    @IBOutlet weak var typeOtherInfoLabel: UILabel!
    @IBOutlet weak var mainQuestionLabel: UILabel!
    
    
    @IBOutlet weak var answerAButton: UIButton!
    
    @IBOutlet weak var answerBButton: UIButton!
    
    @IBOutlet weak var answerCButton: UIButton!
    
    @IBOutlet weak var answerDButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var correctChoice : Int?
    
    var selection : Int?
    
    var numCorrectAnswer : Int = 0
    
    
    var multiple4 : Multiple4Choice?
    //var fillInBlank : ?????
    
    private var jumpToNext : Bool = false
    private var current : Int = 0
    var problemSet : [Question] = []
    func shuffle(){
        //TODO

    }
    
    
    
    let analysis = "analysis: blabla.........."
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        loadQuestion()
        
        numCorrectAnswer = 0
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //Below Section for answer selection
    
    
    @IBOutlet weak var answerResultView: AnswerResultView!
    
    private func curlDownAnimation(view : UIView,animationTime : Float){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        UIView.setAnimationDuration(NSTimeInterval(animationTime))
        UIView.setAnimationTransition(UIViewAnimationTransition.CurlDown, forView: view, cache: false)
        UIView.commitAnimations()
    }
    
    func goBackFunc(alert:UIAlertAction!){
        //Print out you have finished all questions, please hit back button to go back to grade selected view
        self.curlDownAnimation(answerResultView, animationTime: 1.0)
        answerResultView.hidden = false
        //display: completed picture
        //hault question view controller
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("GradeSelectedVC") as! GradeSelectedViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func submitButton(sender: AnyObject) {

        
        if jumpToNext {
            
            
            if current >= problemSet.count{
                let alter = UIAlertController(title: "恭喜你", message: "你已经完成所有题目，共答对\(numCorrectAnswer)/\(problemSet.count)题，点击确定返回上一界面",preferredStyle: .Alert)
                let goBack = UIAlertAction(title: "确定", style: .Default, handler: goBackFunc)
                alter.addAction(goBack)
                presentViewController(alter, animated: true, completion: nil)
            }else{
            
            multiple4 = nil //all Qs set to nil before load. For type recognizing purposes
            loadQuestion()
            
            answerResultView.hidden = true
            
            self.jumpToNext = false
            return //nothing
            }
            
        }else{
        
        
        //To make animation go with view's appearance(unhide it) set the hidden property to false AFTER animation call
        if selection != nil{
            self.curlDownAnimation(answerResultView, animationTime: 1.0)
            answerResultView.hidden = false
            if selection! == correctChoice!{
                answerResultView.answerResultImage.image = UIImage(named: "correct")
                answerResultView.setTextForLabel("correct")
                
                numCorrectAnswer++
                
            }
            else {
                answerResultView.answerResultImage.image = UIImage(named: "wrong")
                answerResultView.setTextForLabel("incorrect")
            }
            
            current++
            self.jumpToNext = true
        }
        }
        

    }
    
    @IBAction func answerAButton(sender: AnyObject) {
        selection = 0
    }
    
    @IBAction func answerBButton(sender: AnyObject) {
        selection = 1
    }
    
    @IBAction func answerCButton(sender: AnyObject) {
        selection = 2
    }
    
    @IBAction func answerDButton(sender: AnyObject) {
        selection = 3
    }
    
    //Above section for answer selection
    
    //Below section for back to grade selected
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let desView = segue.destinationViewController as! GradeSelectedViewController
        desView.name = typeOtherInfoLabel.text!
    }
    
    @IBAction func questionBackTap(sender: AnyObject) {
        performSegueWithIdentifier("questionToSelected", sender: sender)
    }
    
    private func loadQuestion(){
        //clear up information and fill for next question
        let q : Question = self.problemSet[current]
        
        if let t = q as? Multiple4Choice{
            multiple4 = t
        }
        //else, other type of questions?
        
        if multiple4 != nil{
            difficultyImage.image = UIImage(named: multiple4!.difficulty.rawValue)
            typeOtherInfoLabel.text = multiple4!.title
            mainQuestionLabel.text = multiple4!.mainQuestion
            answerAButton.setTitle("A. \(multiple4!.answers[0])", forState: UIControlState.Normal)
            answerBButton.setTitle("B. \(multiple4!.answers[1])", forState: UIControlState.Normal)
            answerCButton.setTitle("C. \(multiple4!.answers[2])", forState: UIControlState.Normal)
            answerDButton.setTitle("D. \(multiple4!.answers[3])", forState: UIControlState.Normal)
            correctChoice = multiple4?.correct
        }
        
        //answer type fill in blank??

    }
    
//    private func finishedAllQsHandler(){
//        if current >= problemSet.count{
//            //Print out you have finished all questions, please hit back button to go back to grade selected view
//            self.curlDownAnimation(answerResultView, animationTime: 1.0)
//            answerResultView.hidden = false
//            //display: completed picture
//            //hault question view controller
//            
//            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("GradeSelectedVC") as! GradeSelectedViewController
//            self.presentViewController(vc, animated: true, completion: nil)
//        }
//    }

}

