//
//  LogInViewController.swift
//  Lecture-22-Homework
//
//  Created by Barbare Tepnadze on 26.04.24.
//

import UIKit

class LogInViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: LogInViewModel
    private let baseFontSize: CGFloat = 13
    private var fontScalingFactor: CGFloat {
        screenWidthScalingFactor()
    }
    
    // MARK: - UI Elements
    private let profileImageView = UIImageView(image: UIImage(named: "addPhoto"))
    private let addPhotoButton = UIButton(type: .custom)
    private let nameLabel = UILabel()
    private let nameInput = UITextField()
    private let passwordLabel = UILabel()
    private let passwordInput: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        return textField
    }()
    private let repeatPasswordLabel = UILabel()
    private let repeatPasswordInput: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        return textField
    }()
    private let loginButton = UIButton()
    
    // MARK: - Initialization
    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        initPageContent()
        initSetUp()
        bindViewModel()
    }
    
    // MARK: - UI Setup
    private func updateUI() {
        view.backgroundColor = .systemBackground
    }
    
    func initSetUp() {
        initStackView()
        stylePhotoButton()
        styleTitleLabels([nameLabel, passwordLabel, repeatPasswordLabel])
        styleInputs([nameInput, passwordInput, repeatPasswordInput])
        styleLogInButton()
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            addPhotoButton,
            nameLabel,
            nameInput,
            getSpacerView(height: 10),
            passwordLabel,
            passwordInput,
            getSpacerView(height: 10),
            repeatPasswordLabel,
            repeatPasswordInput,
            getSpacerView(height: 30),
            loginButton
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        let screenSize = UIScreen.main.bounds.size
        let spacing = screenSize.width < 410 ? 13 : 18
        stackView.spacing = CGFloat(spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func getSpacerView(height: CGFloat) -> UIView {
        let spacerView = UIView()
        spacerView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacerView
    }
    
    private func screenWidthScalingFactor() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth >= 428 {
            return 1.2
        } else if screenWidth >= 390 {
            return 1.1
        } else {
            return 1.0
        }
    }
    
    func initPageContent() {
        nameLabel.text = "მომხმარებლის სახელი"
        passwordLabel.text = "პაროლი"
        repeatPasswordLabel.text = "გაიმეორეთ პაროლი"
        nameInput.placeholder = "შეიყვანეთ მომხმარებლის სახელი"
        passwordInput.placeholder = "შეიყვანეთ პაროლი"
        repeatPasswordInput.placeholder = "განმეორებით შეიყვანეთ პაროლი"
        loginButton.setTitle("შესვლა", for: .normal)
    }
    
    func styleTitleLabels(_ labels: [UILabel]) {
        for label in labels {
            label.numberOfLines = 0
            label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: baseFontSize * fontScalingFactor, weight: .semibold))
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func styleInputs(_ inputs: [UITextField]) {
        for input in inputs {
            input.layer.borderWidth = 0
            input.layer.cornerRadius = 22.5
            input.clipsToBounds = true
            if self.traitCollection.userInterfaceStyle == .dark {
                input.backgroundColor = UIColor(rgb: 0x4B4B4D)
            } else {
                input.backgroundColor = UIColor(rgb: 0xEFEFEF)
            }
            input.translatesAutoresizingMaskIntoConstraints = false;
            input.heightAnchor.constraint(equalToConstant: 45).isActive = true
        }
        styleInputPlaceholders(inputs)
    }
    
    private func styleInputPlaceholders(_ inputs: [UITextField]) {
        for input in inputs {
            if let placeholder = input.placeholder {
                let placeholderAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.lightGray,
                    .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: baseFontSize * fontScalingFactor)),
                    .paragraphStyle: {
                        let paragraphStyle = NSMutableParagraphStyle()
                        paragraphStyle.firstLineHeadIndent = 14
                        return paragraphStyle
                    }()
                ]
                input.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
            }
        }
    }
    
    func stylePhotoButton() {
        addPhotoButton.setImage(viewModel.selectedProfileImage ?? profileImageView.image, for: .normal)
        addPhotoButton.imageView?.contentMode = .scaleAspectFit
        addPhotoButton.contentHorizontalAlignment = .fill
        addPhotoButton.contentVerticalAlignment = .fill
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoButton.widthAnchor.constraint(equalToConstant: 132),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 132),
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoButton.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -40)
        ])
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
        addPhotoButton.layer.cornerRadius = 66
        addPhotoButton.layer.masksToBounds = true
    }
    
    func styleLogInButton() {
        loginButton.titleLabel?.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: baseFontSize * fontScalingFactor, weight: .semibold))
        loginButton.backgroundColor = UIColor(rgb: 0x3888FF)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 22.5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    // MARK: - UI Actions
    @objc private func loginButtonTapped() {
        guard let name = nameInput.text, !name.isEmpty,
              let password = passwordInput.text, !password.isEmpty,
              let repeatPassword = repeatPasswordInput.text, !repeatPassword.isEmpty else {
            return
        }
        
        if password == repeatPassword {
            viewModel.saveUser(name: name, password: password)
            let countriesListViewController = CountriesViewController()
            navigationController?.pushViewController(countriesListViewController, animated: true)
        } else {
            print("Wrong Password")
        }
    }
    
    @objc private func addPhotoButtonTapped() {
        viewModel.selectProfileImage { [weak self] selectedImage in
            DispatchQueue.main.async {
                if let selectedImage = selectedImage {
                    self?.addPhotoButton.setImage(selectedImage, for: .normal)
                    print("Profile image selected and set.")
                } else {
                    print("No image selected.")
                }
            }
        }
    }
    
    // MARK: - Bind to Model
    private func bindViewModel() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        if viewModel.firstTimeLoggedIn {
            if let user = viewModel.retrieveUser() {
                nameInput.text = user.name
                passwordInput.text = user.password
                print("User retrieved: \(user)")
            } else {
                print("Failed to retrieve user.")
            }
        }
    }
}

