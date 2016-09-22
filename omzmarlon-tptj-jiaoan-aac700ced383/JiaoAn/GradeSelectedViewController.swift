//
//  GradeSelectedViewController.swift
//  JiaoAn
//
//  Created by Marlon Ou on 2016-01-03.
//  Copyright (c) 2016 TPTJ. All rights reserved.
//

import UIKit

class GradeSelectedViewController: UIViewController {
    
    //from grade selection view, taping on certain image sets name var
    //from question view, the name var is determined by current problem sets' title information
    //For progress bar or difficulty infomation: when the UIImage is determined, when which grade we are in. Pull from database for the information
    
    
    
    
    @IBOutlet weak var displayImage: UIImageView!
    var name : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if name != nil{
            displayImage.image = UIImage(named: name!)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toLevelTest(sender: AnyObject) {
        name = "levelTest"
       performSegueWithIdentifier("selectedToQView", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        selectedToQViewQuestionProvider(segue, grade: name!)
    }
    
    private func selectedToQViewQuestionProvider(segue : UIStoryboardSegue, grade : String){
        if segue.identifier ==  "selectedToQView"{
            let desView = segue.destinationViewController as! QuestionViewController
            switch grade {
            case "grade 7":
                desView.problemSet = Grade7().problemSetArray
            case "grade 8":
                desView.problemSet = Grade8().problemSetArray
            case "grade 9":
                desView.problemSet = Grade9().problemSetArray
            case "levelTest":
                desView.problemSet = ProblemBank.shiZhen
            default:
                print("***Error")
            }
        }
        
    }
    
    @IBAction func practiceTapGesture(sender: AnyObject) {
        performSegueWithIdentifier("selectedToQView", sender: sender)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}






