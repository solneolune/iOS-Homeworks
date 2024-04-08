//
//  ViewController.swift
//  Lecture-14-Homework
//
//  Created by Barbare Tepnadze on 07.04.24.
//

import UIKit

    // MARK: - Extras
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
} // შეუცვლელად მოვიპარე აქედან: https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values



class ViewController: UIViewController {

    // MARK: - Elements
    let logoImg: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "lock.laptopcomputer"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        return imageView
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "მოგესალმებით!"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = UIColor(rgb: 0x101010)
        return label
    }()
    
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.text = "ამ აპლიკაციის გამოყენების საუკეთესო გზა თქვენს ანგარიშზე შესვლაა, თუ არ გაქვთ ანგარიში გააკეთეთ, თუ არ გსურთ გაკეთება დასტოვეთ აქაურობა და წაშალეთ აპლიკაცია."
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    
    let subHeading: UILabel = {
       let label = UILabel()
        label.text = "ავტორიზაცია"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x33A5E5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "სრული სახელი"
        return label
    }()
    
    
    let nameInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "მაგ: ქეთინო ფერი"
        return textField
    }()
    
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "ელ. ფოსტა"
        return label
    }()
    
    
    let emailInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "მაგ: kusuna@mail.ru"
        return textField
    }()
    
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "პაროლი"
        return label
    }()
    
    
    let passwordInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "მაგ: busuna123, jajanaIsMyKumiri2010"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("შესვლა", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(rgb: 0x33A5E5)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    
    let orDivider: UIStackView = {
        func createLineView() -> UIView {
            let line = UIView()
            line.backgroundColor = UIColor(rgb: 0xD9D9D9)
            line.heightAnchor.constraint(equalToConstant: 1).isActive = true
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }
        
        let line1 = createLineView()
        let line2 = createLineView()

        let orLabel = UILabel()
        orLabel.text = "ან"
        orLabel.textAlignment = .center
        orLabel.textColor = UIColor.black
        orLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        
        let stackView = UIStackView(arrangedSubviews: [
            line1,
            orLabel,
            line2,
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = -40
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    

    let googleButton: UIButton = {
        let button = UIButton(type: .system)
        let imgAttachment = NSTextAttachment()
        imgAttachment.image = UIImage(systemName: "g.circle.fill")?.withTintColor(.black)
        let imgString = NSAttributedString(attachment: imgAttachment)
        let space = NSAttributedString(string: "   ")
        let attributedStr = NSAttributedString(string: "გამოიყენეთ გუგული")
        let fullString = NSMutableAttributedString(attributedString: imgString)
        fullString.append(space)
        fullString.append(attributedStr)
        // სოუსი: https://stackoverflow.com/questions/58341042/is-it-possible-to-use-sf-symbols-outside-of-uiimage
        
        button.setAttributedTitle(fullString, for: .normal)
        button.backgroundColor = UIColor(rgb: 0xF0F0F0)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    let fbButton: UIButton = {
        let button = UIButton(type: .system)
        let imgAttachment = NSTextAttachment()
        imgAttachment.image = UIImage(systemName: "f.circle.fill")?.withTintColor(.black)
        let imgString = NSAttributedString(attachment: imgAttachment)
        let space = NSAttributedString(string: "   ")
        let attributedStr = NSAttributedString(string: "გამოიყენეთ ფეიზბურგი")
        let fullString = NSMutableAttributedString(attributedString: imgString)
        fullString.append(space)
        fullString.append(attributedStr)
        button.setAttributedTitle(fullString, for: .normal)
        button.backgroundColor = UIColor(rgb: 0xF0F0F0)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
        checkInputs()
    }
    
    
    // MARK: - Functions
    func initSetUp() {
        view.backgroundColor = .systemBackground
        let stackView = UIStackView(arrangedSubviews: [
            logoImg,
            titleLabel,
            infoLabel,
            subHeading,
            divider,
            nameLabel,
            nameInput,
            emailLabel,
            emailInput,
            passwordLabel,
            passwordInput,
            loginButton,
            orDivider,
            googleButton,
            fbButton
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        let screenSize = UIScreen.main.bounds.size
        let spacing = screenSize.width < 410 ? 8 : 18 // 430-ია 15 პრო-მაქსის ლოგიკური სიგანე, მაგრამ 11 პრო მაქსი 414-ია ამიტომ უფრო დაბალი ზღვარი ვამჯობინე
        stackView.spacing = CGFloat(spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        divider.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        let buttons = [loginButton, googleButton, fbButton]
        styleButtons(buttons)
        
        let inputs = [nameInput, emailInput, passwordInput]
        styleInputs(inputs)
    }
    
    
    func styleButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.addAction(UIAction(handler: { [weak self] _ in self?.informUser()}), for: .touchUpInside)
            /* სოუსები:
             https://stackoverflow.com/questions/8341543/how-to-add-action-for-uibutton
             https://www.biteinteractive.com/control-target-and-action-in-ios-14/
             */
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.layer.cornerRadius = 12
            button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        }
    }
    
    
    func styleInputs(_ inputs: [UITextField]) {
        for input in inputs {
            input.layer.borderWidth = 1
            input.layer.borderColor = UIColor(rgb: 0xDDDDDD).cgColor
            input.borderStyle = .roundedRect
        }
    }

    
    func informUser() {
        let alertController = UIAlertController(title: "⚠️", message: "ღილაკი მიუწვდომელია. გთხოვთ დააკლიკოთ სამუშაო საათებში, ორშაბათიდან პარასკევის ჩათვლით, 10:00-დან 17:00-მდე 😙", preferredStyle: .alert)
        let acception = UIAlertAction(title: "ბოდიში", style: .default, handler: nil)
        alertController.addAction(acception)
        present(alertController, animated: true, completion: nil)
    } // სოუსი: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    
    
    func checkInputs() {
        emailInput.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            guard let email = emailInput.text else {
                return
            }
            
            if isEmailValid(email) {
                emailInput.layer.borderColor = UIColor(rgb: 0xDDDDDD).cgColor
            } else {
                emailInput.layer.borderColor = UIColor.red.cgColor
            }
        }, for: .editingChanged) // ან editingDidEnd, არ იყო მითითებული როდის უნდა მომხდარიყო
        
        passwordInput.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            guard let password = passwordInput.text else {
                return
            }
            
            if isPasswordValid(password) {
                passwordInput.layer.borderColor = UIColor(rgb: 0xDDDDDD).cgColor
            } else {
                passwordInput.layer.borderColor = UIColor.red.cgColor
            }
        }, for: .editingChanged)
    }
    
    
    func isEmailValid(_ value: String) -> Bool {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    } // სოუსი: https://www.youtube.com/watch?v=5Rn6JJAuyK0&t=470s
    
    func isPasswordValid(_ value: String) -> Bool {
        let regularExpression = "^.{6,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
}


#Preview {
    ViewController()
}
