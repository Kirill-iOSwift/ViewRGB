//
//  ViewController.swift
//  ViewRGB
//
//  Created by Кирилл on 04.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOulets
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redRange: UILabel!
    @IBOutlet var greenRange: UILabel!
    @IBOutlet var blueRange: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 20
        setupRedSlider()
    }
    
    //MARK: - IBActions
    
    @IBAction func redSliderAction() {
        
        setupRadRande()
        
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    //MARK: - Private Methods
    
    private func setupRadRande(){
        
        redRange.text = String(format: "%.2f", redSlider.value)
        greenRange.text = String(format: "%.2f", greenSlider.value)
        blueRange.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setupRedSlider() {
        
        redSlider.minimumValue = 0
        redSlider.maximumValue = 1
        
        
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 1
    }
}

