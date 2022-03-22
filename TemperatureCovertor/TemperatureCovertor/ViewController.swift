//
//  ViewController.swift
//  TemperatureCovertor
//
//  Created by Alphonsa Varghese on 21/03/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    //MARK:- OUTLETS
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var degreeTextField: UITextField!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var typePickerView: UIPickerView!
    
    //MARK:- VARIABLES
    let typeArray = ["Fahrenheit","Celcius"]
    var selectedType = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    //MARK:- DELEGATES
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedType = typeArray[row]
    }

    //MARK:- ACTIONS
    
    @IBAction func typeButtonOnClick(_ sender: UIButton) {
        popUpView.isHidden = false
    }
    
    @IBAction func okButtonOnClick(_ sender: UIButton) {
        resultLabel.text = ""
        typeLabel.text = selectedType
        popUpView.isHidden = true
    }
    
    @IBAction func cancelButtonOnClick(_ sender: UIButton) {
        popUpView.isHidden = true
    }
    
    @IBAction func convertButtonOnClick(_ sender: UIButton) {
        degreeTextField.resignFirstResponder()
        guard let degree = degreeTextField.text, !degree.isEmpty else {
            alertBox()
            return
        }
        
        if selectedType == "Fahrenheit" || selectedType == "" {
            let result = celciusConvert(f: Double(degree)!)
            resultLabel.text = "\(result)"+" "+"°"+"C"
        } else {
            let result = fahrenheitConvert(c: Double(degree)!)
            resultLabel.text = "\(result)"+" "+"°"+"F"
        }
    }
    //MARK:- FUNCTIONS
    
    func initialSetUp() {
        typePickerView.delegate = self
        typePickerView.dataSource = self
        popUpView.isHidden = true
        bgView.layer.cornerRadius = 20
        bgView.clipsToBounds = true
        bgView.dropShadow()
        convertButton.layer.cornerRadius = 15
        convertButton.clipsToBounds = true
        resultLabel.text = ""
        degreeTextField.text = ""
        degreeTextField.keyboardType = .numberPad
        
        let tapGestureReco = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss))
        self.view.addGestureRecognizer(tapGestureReco)
    }
    
    func fahrenheitConvert(c:Double) -> Double {
        let F = (c * 9/5) + 32
        return F
    }
    
    func celciusConvert(f:Double) -> Double {
        let C = (f - 32) * 5/9
        return C
    }
    
    func alertBox() {
        let alert = UIAlertController(title: "Alert", message: "Please provide value to convert", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func tapToDismiss() {
        degreeTextField.resignFirstResponder()
    }

}


extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1.5
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
