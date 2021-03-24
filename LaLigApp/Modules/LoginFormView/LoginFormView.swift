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
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var errorPhoneLabel: UILabel!
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
    @IBOutlet weak var scrollViewRef: UIScrollView!
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    
    private func setupView() {
        nameTextfield.tag = 0
        nameTextfield.delegate = textFieldsDelegate
        phoneNumberTextfield.tag = 1
        phoneNumberTextfield.delegate = textFieldsDelegate
        emailTextField.tag = 2
        emailTextField.delegate = textFieldsDelegate
        repeatEmailTexfield.tag = 3
        repeatEmailTexfield.delegate = textFieldsDelegate
        passwordTextfield.tag = 4
        passwordTextfield.delegate = textFieldsDelegate
        repeatPasswordTextfield.tag = 5
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
        guard self.nameTextfield.text!.count >= 5 else {
            return self.errorNameLabel.text = "Introduce a valid name, minimun 6 letters".localizedString()
        }
        guard self.emailTextField.text != "" else {
            return self.errorMailLabel.text = "Introduce a valid mail".localizedString()
        }
        guard self.emailTextField.text == self.repeatEmailTexfield.text else {
            return self.errorMailLabel2.text = "Email does not match".localizedString()
        }
        guard self.passwordTextfield.text != "" else {
            return self.errorPassLabel.text = "Introduce a valid password".localizedString()
        }
        let patern = "[A-Z]"
        guard self.passwordTextfield.text?.range(of: patern, options: .regularExpression) != nil else {
            return self.errorPassLabel.text = "Password must contain one capital letter".localizedString()
        }
        
        guard passwordTextfield.text == repeatPasswordTextfield.text else {
            return self.errorPassLabel2.text = "Password does not match".localizedString()
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
    
    @objc func keyboardWillShow(notification: NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey]
                                        // swiftlint:disable force_cast
                                        as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = self.scrollViewRef.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        self.scrollViewRef.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification: NSNotification) {

        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        self.scrollViewRef.contentInset = contentInset
    }
}

class LoginFormTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        return true
    }
    // MARK: Esto es solo un ejemplo de como comprobar que los datos
    // introducidos del usuario son correctos para un número
    // de teléfono en el delegado.
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == textField.viewWithTag(1) {
            let patern = "[0-9]"
            if textField.text?.range(of: patern, options: .regularExpression) != nil && textField.text!.count >= 9 {
                textField.resignFirstResponder()
            } else {
                textField.text = ""
                textField.resignFirstResponder()
            }
        }
    }
}
