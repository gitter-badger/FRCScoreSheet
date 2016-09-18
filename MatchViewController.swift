//
//  SecondViewController.swift
//  FRCScoreSheet
//
//  Created by Austin Bennett on 8/17/16.
//  Copyright © 2016 Austin Bennett. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UITextFieldDelegate {
    
    //Top section of data
    @IBOutlet weak var teamNumb:UITextField!
    @IBOutlet weak var matchNumb:UILabel!
    @IBOutlet weak var matchNumbStepper:UIStepper!
    
    //Autonomous section of Current Match
    @IBOutlet weak var reachedDef:UISegmentedControl!
    @IBOutlet weak var autoCrossedDef:UISegmentedControl!
    @IBOutlet weak var autoLowGoalGoals:UISegmentedControl!
    @IBOutlet weak var autoHighGoalGoals:UISegmentedControl!
    
    //Teleop section of Current Match
    @IBOutlet weak var teleopCrossedDef:UISegmentedControl!
    @IBOutlet weak var teleopLowGoalGoals:UISegmentedControl!
    @IBOutlet weak var teleopHighGoalGoals:UISegmentedControl!
    @IBOutlet weak var challengedTower:UISegmentedControl!
    @IBOutlet weak var scaledTower:UISegmentedControl!
    @IBOutlet weak var fouls:UISegmentedControl!
    
    //Data Manager from LocalizedData.swift
    let dataManager = LocalizedData.localizedData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.teamNumb.delegate = self;
    }
    
    @IBAction func submitButton(sender: UIButton) {
        /*
        var teamNumber:Int
        var matchNumber:Int
        var autoReachDef:Bool
        var autoCrossDef:Bool
        var autoLowGoal:Int
        var autoHighGoal:Int
        var teleopCrossDef:Int
        var teleopLowTower:Int
        var teleopHighTower:Int
        var teleopChallengedTower:Bool
        var teleopScaledTower:Bool
        var foul:Int
        */
        var teamNumber:Int
        //if teamNumb.text == nil {
            teamNumber = 0
        //} else {
        //    teamNumber = Int(teamNumb.text!)!
        //}
        dataManager.addScoreData(teamNumber:teamNumber, matchNumber:0, autoReachDef:(reachedDef.selectedSegmentIndex == 1), autoCrossDef:(autoCrossedDef.selectedSegmentIndex == 1), autoLowGoal:autoLowGoalGoals.selectedSegmentIndex, autoHighGoal:autoHighGoalGoals.selectedSegmentIndex,teleopCrossDef:teleopCrossedDef.selectedSegmentIndex, teleopLowTower:teleopLowGoalGoals.selectedSegmentIndex, teleopHighTower:teleopHighGoalGoals.selectedSegmentIndex, teleopChallengedTower:(challengedTower.selectedSegmentIndex == 1), teleopScaledTower:(scaledTower.selectedSegmentIndex == 1), foul:fouls.selectedSegmentIndex)
        
        //Adjust header fields:
        //TODO: reset teamNumb UITextField
        //matchNumb.text = (Int(matchNumb)+1) + ""
        matchNumbStepper.value += 1
        
        //reset auto fields:
        reachedDef.selectedSegmentIndex = 0
        autoCrossedDef.selectedSegmentIndex = 0
        autoLowGoalGoals.selectedSegmentIndex = 0
        autoHighGoalGoals.selectedSegmentIndex = 0
        
        //reset teleop fields:
        teleopCrossedDef.selectedSegmentIndex = 0
        teleopLowGoalGoals.selectedSegmentIndex = 0
        teleopHighGoalGoals.selectedSegmentIndex = 0
        challengedTower.selectedSegmentIndex = 0
        scaledTower.selectedSegmentIndex = 0
        fouls.selectedSegmentIndex = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

