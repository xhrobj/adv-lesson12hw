//
//  ViewController.swift
//  level2hw12
//
//  Created by M on 12.07.2020.
//  Copyright © 2020 M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - UI Events

    @IBAction func testButtonTapped() {
        let message = validationForm() ? "ok" : "not ok"
        showMessage(message)
    }

    // MARK: -

    private func showMessage(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func validationForm() -> Bool {
        guard
            let lastName = lastNameTextField.text,
            let firstName = firstNameTextField.text,
            let email = emailTextField.text,
            let phone = phoneTextField.text
        else {
            return false
        }

        let nameRegExp = "^([A-Z][A-z]+)|([А-Я][А-я]+)$"

        if lastName.trimmedString.range(of: nameRegExp, options: .regularExpression, range: nil, locale: nil) == nil {
            return false
        }

        if firstName.trimmedString.range(of: nameRegExp, options: .regularExpression, range: nil, locale: nil) == nil {
            return false
        }

        if email.trimmedString.range(of: "^.+@.+\\..{2,}$", options: .regularExpression, range: nil, locale: nil) == nil {
            // NOTE: на мой взгляд, это идельная проверка для емайла -
            // "что-то, потом собака, что-то, потом точка, потом еще что-то не меньше двух символов"
            // (домен первого уровня не может быть меньше двух символов).
            // Наша цель - маякнуть пользователю, если он случайно ошибется -
            // забудет собаку или какую-то часть адреса - и эта простейшая регулярка отлично работает.
            // Нет смысла городить более мудреную проверку - реальных ошибочных кейсов она сильно больше не отловит,
            // зато есть риск, что пользователь не сможет вписать свою почту,
            // например, пример с лекции не примет почту в доменах .рф или в домене .mobile
            return false
        }

        if phone.onlyDigits.count != 11 {
            return false
        }

        return true
    }
}

// MARK: - String

extension String {
    var trimmedString: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var onlyDigits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
