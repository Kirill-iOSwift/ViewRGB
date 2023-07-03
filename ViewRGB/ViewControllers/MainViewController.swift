//
//  MainViewController.swift
//  ViewRGB
//
//  Created by Кирилл on 01.07.2023.
//

import UIKit

protocol ISettingsViewControllerDeligate {
    func changeColor(for modelColor: ModelColor)
}

final class MainViewController: UIViewController {
    
    private var modelColor = ModelColor(red: 1, green: 1, blue: 1)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingViewController else { return }
        settingVC.modelColor = modelColor
        settingVC.deligate = self
    }
}

// MARK: - SettingsViewControllerDeligate

extension MainViewController: ISettingsViewControllerDeligate {
    
    func changeColor(for modelColor: ModelColor) {
        self.modelColor = modelColor
        view.backgroundColor = UIColor(
            red: modelColor.red,
            green: modelColor.green,
            blue: modelColor.blue,
            alpha: 1
        )
    }
}
