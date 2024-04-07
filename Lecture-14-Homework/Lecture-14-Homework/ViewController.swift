//
//  ViewController.swift
//  Lecture-14-Homework
//
//  Created by Barbare Tepnadze on 07.04.24.
//

import UIKit

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
        label.font = UIFont.boldSystemFont(ofSize: 25) //🆘 change
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
        textField.borderStyle = .roundedRect
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
        textField.borderStyle = .roundedRect
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
        textField.borderStyle = .roundedRect
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
        button.addTarget(ViewController.self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let orDivider: UIStackView = {
        
        func createLineView() -> UIView {
            let line = UIView()
            line.backgroundColor = UIColor.black
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
        orLabel.font = UIFont.systemFont(ofSize: 16)
        
        let stackView = UIStackView(arrangedSubviews: [
            line1,
            orLabel,
            line2,
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = -40 // ეს დავივიწყოთ, ვითომ არ დამიწერია, მაინც ოფშენალია
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    

    let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("გამოიყენეთ გუგული", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(rgb: 0x33A5E5)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(ViewController.self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let fbButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("გამოიყენეთ ფეიზბურგი", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(rgb: 0x33A5E5)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(ViewController.self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
    }
    
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
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
    }

    
    @objc func loginButtonTapped() {
        informUser()
    }
    
    func informUser() {
        let alertController = UIAlertController(title: "⚠️", message: "ღილაკი მიუწვდომელია. გთხოვთ დააკლიკოთ სამუშაო საათებში, ორშაბათიდან პარასკევის ჩათვლით, 10:00-დან 17:00-მდე 😙", preferredStyle: .alert)
        let acception = UIAlertAction(title: "ბოდიში", style: .default, handler: nil)
        alertController.addAction(acception)
        present(alertController, animated: true, completion: nil)
    } // სოუსი: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    
}


#Preview {
    ViewController()
}
