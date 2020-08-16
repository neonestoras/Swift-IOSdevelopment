//
//  ViewController.swift
//  MadLibs
//
//  Created by nestoras neofytou on 09/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var verbTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var ageTxtField: UITextField!
    
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var numOfPetsLabel: UILabel!
    @IBOutlet weak var animalSelection: UISegmentedControl!
    @IBOutlet weak var sliderNum: UISlider!
    @IBOutlet weak var numOfPetsStepper: UIStepper!
    @IBOutlet weak var happyEndSwitch: UISwitch!
    
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func lessOrMore(_ sender: UISegmentedControl) {
        //if more is selected further controls are revealed, if less then is hidden
        
        if sender.selectedSegmentIndex == 0 {
            containerView.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1 {
            containerView.isHidden = false
        }
        
    }
    
    @IBAction func sliderDidChanged(_ sender: UISlider) {
        //update the lable on the left of the slider
        numLabel.text = "\(Int(sender.value))"
        
    }
    
    @IBAction func stepperDiChange(_ sender: UIStepper) {
        numOfPetsLabel.text = "\(Int(sender.value))"
    }
    
    
    @IBAction func createStoryDidTapped(_ sender: UIButton) {
        // At the age of 21, Bob took a trip to Austin with 3 pets in order to sing with a moose. Bob decided to buy 42. Now they live happily every after.
        
        let animal = animalSelection.titleForSegment(at: animalSelection.selectedSegmentIndex)
        let ending = happyEndSwitch.isOn ? "Now they live happily ever after" : "Things didn't turn out too well..."
        let story = "At the age of \(ageTxtField.text!), \(nameTxtField.text!) took a trip to \(locationTxtField.text!) with \(Int(numOfPetsStepper.value)) pets in order to \(verbTxtField.text!) with a \(animal!). \(nameTxtField.text!) decided to buy \(Int(sliderNum.value)). \(ending)"
        print(story)
        
        let alertController = UIAlertController(title: "My Story", message: story, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    //Dissmis the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

