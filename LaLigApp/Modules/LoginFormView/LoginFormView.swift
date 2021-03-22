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
    @IBOutlet weak var errorNameLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorMailLabel: UILabel!
    @IBOutlet weak var repeatEmailTexfield: UITextField!
    @IBOutlet weak var errorMailLabel2: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorPassLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    @IBOutlet weak var errorPassLabel2: UILabel!
    @IBOutlet weak var acceptTermsSwitch: UISwitch!
    @IBOutlet weak var acceptTermsLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    // swiftlint:disable:next weak_delegate
    private var textFieldsDelegate: UITextFieldDelegate! = LoginFormTextFieldDelegate()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
        // MARK: Oculta el teclado cuando tocas fuera de el, introducido como extensión de UIViewController,
        // archivo swift dentro de carpeta extensiones.
        self.hideKeyboardWhenTappedAround()
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

    @IBAction func registerPressedButton(_ sender: UIButton) {
        self.errorNameLabel.text = ""
        self.errorMailLabel.text = ""
        self.errorMailLabel2.text = ""
        self.errorPassLabel.text = ""
        self.errorPassLabel2.text = ""
        guard self.acceptTermsSwitch.isOn else {
            return presenter.showNoTermsAcceptAlert()
        }
        guard self.nameTextfield.text != "" else {
            return self.errorNameLabel.text = "Introduce a valid name"
        }
        guard self.emailTextField.text != "" else {
            return self.errorMailLabel.text = "Introduce a valid mail"
        }
        guard self.emailTextField.text == self.repeatEmailTexfield.text else {
            return self.errorMailLabel2.text = "Email does not match"
        }
        guard self.passwordTextfield.text != "" else {
            return self.errorPassLabel.text = "Introduce a valid password"
        }
        let patern = "[A-Z]"
        guard self.passwordTextfield.text?.range(of: patern, options: .regularExpression) != nil else {
           return self.errorPassLabel.text = "Password must contain one capital letter"
        }
        
        guard passwordTextfield.text == repeatPasswordTextfield.text else {
            return self.errorPassLabel2.text = "Password does not match"
        }
        guard let email = emailTextField.text, let password = passwordTextfield.text else { return }
        // MARK: Implementar mas expresiones regulares para que los datos cumplan mas requisitos, por ejemplo la
        // cantidad de caracteres mínimos que debe contener, o incluir un número en la contraseña,
        // o que el mail contenga un dominio. Si creciese demasiado de las maneras de hacerlo
        // sería con una extensión que contenga una struc con todas estas
        // comprobaciones y expresiones regulares, otra es pasar estas
        // comprobaciones al presenter y obtuviesemos un valor Bool de vuelta
        // que actualice la vista con los posibles errores.
        presenter.registerPressed(email: email, password: password)
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
