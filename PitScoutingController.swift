//
//  SecondViewController.swift
//  FRCScoreSheet
//
//  Created by Austin Bennett on 8/17/16.
//  Copyright © 2016 Austin Bennett. All rights reserved.
//

import UIKit

class PitScoutingController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var teamNumb: UITextField!
    @IBOutlet weak var robotWeight: UITextField!
    @IBOutlet weak var robotPosition: UISegmentedControl!
    @IBOutlet weak var robotHeight: UITextField!
    @IBOutlet weak var robotWidth: UITextField!
    @IBOutlet weak var robotDepth: UITextField!
    @IBOutlet weak var robotImage: UIImageView!
    
    let instanceDataManager = LocalizedData.localizedData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.teamNumb.delegate = self;
        self.robotWeight.delegate = self;
        self.robotHeight.delegate = self;
        self.robotWidth.delegate = self;
        self.robotDepth.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func submitButton(sender: UIButton) {
        //Make everything an integer, except for the image
        let teamNumberInteger = Int((teamNumb.text)!)
        let robotWeightInteger = Int((robotWeight.text)!)
        let robotPositionInteger = robotPosition.selectedSegmentIndex
        let robotHeightInteger = Int((robotHeight.text)!)
        let robotWidthInteger = Int((robotWidth.text)!)
        let robotDepthInteger = Int((robotDepth.text)!)
        
        //Add data to LocalizedData
        instanceDataManager.addPitScout(teamNumber: teamNumberInteger!, robotImageLocation: "", robotWeight: robotWeightInteger!, robotPosition: robotPositionInteger, robotHeight: robotHeightInteger!, robotWidth: robotWidthInteger!, robotDepth: robotDepthInteger!)
        
        //Reset data fields
        teamNumb.text = ""
        robotWeight.text = ""
        robotPosition.selectedSegmentIndex = 0
        robotHeight.text = ""
        robotWidth.text = ""
        robotDepth.text = ""
    }
}

