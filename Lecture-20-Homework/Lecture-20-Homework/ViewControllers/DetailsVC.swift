//
//  DetailsVC.swift
//  Lecture-20-Homework
//
//  Created by Barbare Tepnadze on 22.04.24.
//
import UIKit

class DetailsVC: UIViewController {
    // MARK: - Properties
    var country: Country?
    
    // MARK: - Elements
    let scrollView = UIScrollView()
    let flagImg: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 60, height: 60))
        return imageView
    }()
    let flagAltTitle = UILabel()
    let flagAlt =  UILabel()
    let infoTitle = UILabel()
    let linksTitle = UILabel()
    let infoStackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        initSetUp()
        initData()
    }
    
    // MARK: - Setup and Styling
    func initSetUp() {
        setupScrollView()
        initStackView()
        styleImage()
        styleInfoStack()
        styleTitleLabels([flagAltTitle, infoTitle, linksTitle])
        styleFlagAltText()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            flagImg,
            flagAltTitle,
            flagAlt,
            infoTitle,
            infoStackView,
            linksTitle
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        let screenSize = UIScreen.main.bounds.size
        let spacing = screenSize.width < 410 ? 8 : 18
        stackView.spacing = CGFloat(spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        createInfoTable()
    }
    
    func initData() {
        if let data = country {
            navigationItem.title = data.name.common
            loadImage(from: data.flags.png)
            flagAltTitle.text = "About the flag:"
            flagAlt.text = data.flags.alt
            infoTitle.text = "Basic information:"
            updateInfoTable(with: data)
        } else {
            print("404 not found")
        }
    }
    
    func styleImage() {
        flagImg.contentMode = .scaleAspectFill
        flagImg.clipsToBounds = false
        flagImg.layer.cornerRadius = 30
        flagImg.layer.shadowColor = UIColor.black.cgColor
        flagImg.layer.shadowOffset = CGSize(width: 0, height: 4)
        flagImg.layer.shadowRadius = 4
        flagImg.layer.shadowOpacity = 0.15
        flagImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flagImg.heightAnchor.constraint(equalToConstant: 228)            ])
    }
    
    func styleTitleLabels(_ labels: [UILabel]) {
        for label in labels {
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.textAlignment = .left
        }
    }
    
    func styleFlagAltText() {
        flagAlt.numberOfLines = 0
        flagAlt.textAlignment = .left
        flagAlt.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    func styleInfoStack() {
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.alignment = .fill
    }
    
    func createInfoTable() {
        let rows = [("Native name:", ""), ("Spelling:", ""), ("Capital:", ""), ("Currency:", ""), ("Region:", ""), ("Neighbors:", "")]
        for row in rows {
            let rowView = createRow(title: row.0, value: row.1)
            infoStackView.addArrangedSubview(rowView)
        }
    }
    
    func updateInfoTable(with country: Country) {
        let nativeName = country.name.nativeName?["kat"]?.official ?? "Unavailable"
        let spellings = country.altSpellings.joined(separator: ", ")
        let capitals = country.capital?.joined(separator: ", ") ?? "Unavailable"
        let currencies = country.currencies?.map { "\($0.key): \($0.value.name), \($0.value.symbol ?? "No symbol")" }.joined(separator: ", ") ?? "Unavailable"
        let neighbors = country.borders?.joined(separator: ", ") ?? "Unavailable"
        let details: [(String, String)] = [
            ("Native name", nativeName),
            ("Spelling", spellings),
            ("Capital", capitals),
            ("Currency", currencies),
            ("Region", country.region),
            ("Neighbors", neighbors)
        ]
        for (i, detail) in details.enumerated() {
            if let rowStackView = infoStackView.arrangedSubviews[i] as? UIStackView,
               let valueLabel = rowStackView.arrangedSubviews.last as? UILabel {
                valueLabel.text = detail.1
            }
        }
    }
    
    func createRow(title: String, value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textAlignment = .right
        
        let rowStackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        rowStackView.distribution = .equalSpacing
        
        return rowStackView
    }
    
    // MARK: -  Action Functions
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.flagImg.image = image
            }
        }.resume()
    }
}

#Preview {
    DetailsVC()
}

