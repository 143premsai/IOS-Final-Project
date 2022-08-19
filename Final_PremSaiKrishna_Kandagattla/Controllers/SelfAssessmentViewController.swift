//
//  SelfAssessmentViewController.swift
//  Final_PremSaiKrishna_Kandagattla
//
//  Created by user206624 on 8/17/22.
//

import UIKit

class SelfAssessmentViewController: UIViewController {
    
    

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var travelBtns: UIStackView!
    @IBOutlet weak var TravelYes: UIButton!
    @IBOutlet weak var TravelNo: UIButton!
    @IBOutlet weak var symptomsBtns: UIStackView!
    @IBOutlet weak var SymptomYes: UIButton!
    @IBOutlet weak var SymptomNo: UIButton!
    @IBOutlet weak var ErrorMessage: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    
    var travel_ans: Bool!
    var symptom_ans: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorMessage.text = nil
        // Do any additional setup after loading the view.
        modifyCSSTextField(sender: Name)
        modifyCSSTextField(sender: age)
        
        modifyCSSButton(sender: submitBtn, buttonColor: UIColor.init(rgbColorCodeRed: 0, green: 128, blue: 255, alpha: 1))
        
        let tapDimissKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard));
        view.addGestureRecognizer(tapDimissKeyboard);
    }
    

    // override dismiss keyboard after edit done
    @objc func dismissKeyboard() {
            view.endEditing(true)
     }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func TravelYesBtnAction(_ sender: Any) {
        dismissKeyboard()
        travel_ans = true
        TravelYes.isSelected = true
        TravelNo.isSelected = false
        
    }
    
    @IBAction func TravelNoBtnAction(_ sender: Any) {
        dismissKeyboard()
        travel_ans = false
        TravelYes.isSelected = false
        TravelNo.isSelected = true
    }
    
    @IBAction func SymptomYesBtnAction(_ sender: Any) {
        dismissKeyboard()
        symptom_ans = true
        SymptomYes.isSelected = true
        SymptomNo.isSelected = false
    }
    
    @IBAction func SymptomNoBtnAction(_ sender: Any) {
        dismissKeyboard()
        symptom_ans = false
        SymptomYes.isSelected = false
        SymptomNo.isSelected = true
    }
    @IBAction func submit(_ sender: Any) {
        dismissKeyboard()
        ErrorMessage.text = nil
        if(Name.text == ""){
            ErrorMessage.text = "Please enter your name"
            return
        } else if (age.text == ""){
            ErrorMessage.text = "Please enter your age"
            return
        } else if(travel_ans == nil) {
            ErrorMessage.text = "Please select Travel"
            return
        } else if (symptom_ans == nil){
            ErrorMessage.text = "Please select the Symptom"
            return
        }
        
        
        if (symptom_ans){
            let alert = UIAlertController.init(title: "Covid-19", message: "Please Call 911 or go directly to your nearest emergency department ", preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "Back", style: .cancel, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController.init(title: "Covid-19", message: "Contact nearest doctor for help", preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "Back", style: .cancel, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
