//
//  ConcentrationThemeChooserControllerViewController.swift
//  projectAssignmentOne
//
//  Created by Nikita Skrypchenko  on 1/10/19.
//  Copyright © 2019 Nikita Skrypchenko . All rights reserved.
//

import UIKit

class ConcentrationThemeChooserControllerViewController: UIViewController, UISplitViewControllerDelegate {

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.themeName == nil{
                return false
            }
        }
        return true
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    @IBAction func restart(_ sender: Any) {
        performSegue(withIdentifier: "Choose Theme", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
            if let themeName = (sender as? UIButton)?.currentTitle {
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.username = themeName
                }
            }
        }
    }
    

}
