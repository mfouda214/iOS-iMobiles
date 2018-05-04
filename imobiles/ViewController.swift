//
//  ViewController.swift
//  imobiles
//
//  Created by Mohamed Sobhi  Fouda on 4/29/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button start
    
    
    @IBAction func TodoList(_ sender: Any) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "todo")
        
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion:nil)
        
        
    }
    
    @IBAction func QRScan(_ sender: Any) {
    
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "scan")
    
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: true, completion:nil)
    
    
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .fullScreen
    }

    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
    let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ViewController.dismissViewController))
    navigationController.topViewController?.navigationItem.rightBarButtonItem = doneButton
    return navigationController
    
    }

    @objc func dismissViewController() {
    self.dismiss(animated: true, completion: nil)
    }


}

