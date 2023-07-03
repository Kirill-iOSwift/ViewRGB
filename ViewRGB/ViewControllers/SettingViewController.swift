//
//  SettingViewController.swift
//  ViewRGB
//
//  Created by Кирилл on 04.06.2023.
//

import UIKit

final class SettingViewController: UIViewController {
    
    //MARK: - IBOulets
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redRange: UILabel!
    @IBOutlet var greenRange: UILabel!
    @IBOutlet var blueRange: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    private let toolBar = UIToolbar()
    
    var modelColor: ModelColor!
    var deligate: ISettingsViewControllerDeligate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolBar.sizeToFit()
        getToolBarDoneButton()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        mainView.layer.cornerRadius = 20
        
        changeSlider()
        setupColor()
        setupRange()
        rangeTextField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    
    @IBAction func sliderAction() {
        setupRange()
        setupColor()
        rangeTextField()
    }
    
    @IBAction func doneButtonPressed() {
        rangeSlider()
        deligate.changeColor(for: modelColor)
        dismiss(animated: true)
    }
}
//MARK: - Private Methods

private extension SettingViewController {
    ///Медод отображения значений слайдеров в лейблах
    func setupRange() {
        redRange.text = String(format: "%.2f", redSlider.value)
        greenRange.text = String(format: "%.2f", greenSlider.value)
        blueRange.text = String(format: "%.2f", blueSlider.value)
    }
    ///Метод изменения цвета mainView
    func setupColor() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    ///Метод изменения значений свойст ModelColor
    func rangeSlider() {
        modelColor.red = CGFloat(redSlider.value)
        modelColor.green = CGFloat(greenSlider.value)
        modelColor.blue = CGFloat(blueSlider.value)
    }
    ///Метод отображения значений сдайдеров в текстовых полях
    func rangeTextField() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    ///Метод изменения значений сладеров
    func changeSlider() {
        redSlider.setValue(Float(modelColor.red), animated: true)
        greenSlider.setValue(Float(modelColor.green), animated: true)
        blueSlider.setValue(Float(modelColor.blue), animated: true)
    }
    
    //MARK: - Show Alerts
    
    func showAlert(textField: UITextField) {
        let alert = UIAlertController(
            title: "Incorect value",
            message: "please enter a value from 0.00 to 1.00",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in textField.text = ""}
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
 //MARK: - ToolBar Done Button
    
    func getToolBarDoneButton() {
            
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        toolBar.setItems([flexSpace ,doneButton], animated: true)
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
        toolBar.barTintColor = .systemGray3
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Double(newValue) else { return }
        if numberValue >= 0.00 && numberValue <= 1.00 {
            switch textField {
            case redTextField:
                modelColor.red = CGFloat(numberValue)
            case greenTextField:
                modelColor.green = CGFloat(numberValue)
            case blueTextField:
                modelColor.blue = CGFloat(numberValue)
            default:
                break
            }
            changeSlider()
            setupColor()
            setupRange()
            rangeTextField()
        } else {
            showAlert(textField: textField)
        }
    }
}
