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
        initStackView()
        styleImage()
        styleInfoStack()
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
            infoStackView
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
        flagImg.clipsToBounds = true
        flagImg.layer.cornerRadius = 30
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
        let spellings = country.altSpellings.joined(separator: ", ") ?? "Unavailable"
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
        titleLabel.font = .systemFont(ofSize: 16)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 16)
        valueLabel.textAlignment = .right
        
        let rowStackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        rowStackView.distribution = .equalSpacing
        
        return rowStackView
    }
    
    
    
    // MARK: - ACTION FUNCTIONS
    
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
