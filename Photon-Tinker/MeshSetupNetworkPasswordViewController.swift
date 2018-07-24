//
//  MeshSetupNetworkPasswordViewController.swift
//  Particle
//
//  Created by Ido Kleinman on 7/19/18.
//  Copyright © 2018 spark. All rights reserved.
//

import UIKit

class MeshSetupNetworkPasswordViewController: MeshSetupViewController, UITextFieldDelegate {
    
    @IBOutlet weak var networkPasswordTextField: UITextField!
    @IBAction func joinNetworkButtonTapped(_ sender: Any) {
        self.textFieldDidEndEditing(self.networkPasswordTextField)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.networkPasswordTextField.becomeFirstResponder()
        self.networkPasswordTextField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if let pwd = textField.text {
            if pwd.count < 6 {
                // TODO: enforce more things ?
                self.flowError(error: "Network Password must be 6 characters or more", severity: .Warning, action: .Dialog)
            } else {
                self.flowManager!.networkPassword = pwd
            }
        }
    }
    
    override func authSuccess() {
        self.performSegue(withIdentifier: "joiningNetwork", sender: self)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MeshSetupAddToNetworkViewController else {
            return
        }
        
        vc.flowManager = self.flowManager
    }}
