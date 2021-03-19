//
//  LoginFormView.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class LoginFormView: BaseViewController, LoginFormViewContract {

	var presenter: LoginFormPresenterContract!

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var repeatEmailTexfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    @IBOutlet weak var acceptTermsSwitch: UISwitch!
    @IBOutlet weak var acceptTermsLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // swiftlint:disable:next weak_delegate
    private var textFieldsDelegate: UITextFieldDelegate! = LoginFormTextFieldDelegate()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }

    private func setupView() {
        nameTextfield.tag = 0
        nameTextfield.delegate = textFieldsDelegate
        emailTextField.tag = 1
        emailTextField.delegate = textFieldsDelegate
        repeatEmailTexfield.tag = 2
        repeatEmailTexfield.delegate = textFieldsDelegate
        passwordTextfield.tag = 3
        passwordTextfield.delegate = textFieldsDelegate
        repeatPasswordTextfield.tag = 4
        repeatPasswordTextfield.delegate = textFieldsDelegate

    }
    @IBAction func aceptedTermPressed(_ sender: UISwitch) {
    }
    @IBAction func registerPressedButton(_ sender: UIButton) {
    }
    @IBAction func loginPressedButton(_ sender: UIButton) {
    }
}

class LoginFormTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextTextField = textField.superview?.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
}
