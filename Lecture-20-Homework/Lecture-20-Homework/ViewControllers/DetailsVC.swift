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
    let openStreetMapIcon = UIImageView()
    let googleMapIcon = UIImageView()
    
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
        setupMapIcons()
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
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.15
        
        styleImage()
        containerView.addSubview(flagImg)
        
        flagImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flagImg.topAnchor.constraint(equalTo: containerView.topAnchor),
            flagImg.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            flagImg.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            flagImg.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 228)
        ])
        
        let mapsStackView = UIStackView(arrangedSubviews: [openStreetMapIcon, googleMapIcon])
        mapsStackView.axis = .horizontal
        mapsStackView.distribution = .fillEqually
        mapsStackView.alignment = .center
        mapsStackView.spacing = 10
        
        let divider1 = createDivider()
            let divider2 = createDivider()
        
        let stackView = UIStackView(arrangedSubviews: [
            containerView,
            flagAltTitle,
            flagAlt,
            divider1,
            infoTitle,
            infoStackView,
            divider2,
            linksTitle,
            mapsStackView
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        let screenSize = UIScreen.main.bounds.size
        let spacing = screenSize.width < 410 ? 8 : 18
        stackView.spacing = CGFloat(spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32)
        ])
        
        createInfoTable()
    }
    
    func setupMapIcons() {
        openStreetMapIcon.isUserInteractionEnabled = true
        googleMapIcon.isUserInteractionEnabled = true
        
        openStreetMapIcon.image = UIImage(named: "map1")
        googleMapIcon.image = UIImage(named: "map2")
        
        let tapOSM = UITapGestureRecognizer(target: self, action: #selector(openOpenStreetMap))
        let tapGoogle = UITapGestureRecognizer(target: self, action: #selector(openGoogleMaps))
        openStreetMapIcon.addGestureRecognizer(tapOSM)
        googleMapIcon.addGestureRecognizer(tapGoogle)
        
        openStreetMapIcon.contentMode = .scaleAspectFit
        googleMapIcon.contentMode = .scaleAspectFit
        openStreetMapIcon.clipsToBounds = false
        googleMapIcon.clipsToBounds = false
        openStreetMapIcon.translatesAutoresizingMaskIntoConstraints = false
        googleMapIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            openStreetMapIcon.widthAnchor.constraint(equalToConstant: 50),
            openStreetMapIcon.heightAnchor.constraint(equalToConstant: 50),
            googleMapIcon.widthAnchor.constraint(equalToConstant: 50),
            googleMapIcon.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func styleLinksStackView() {
        
    }
    
    func initData() {
        if let data = country {
            navigationItem.title = data.name.common
            loadImage(from: data.flags.png)
            flagAltTitle.text = "About the flag:"
            flagAlt.text = data.flags.alt
            infoTitle.text = "Basic information:"
            updateInfoTable(with: data)
            linksTitle.text = "Useful links:"
        } else {
            print("404 not found")
        }
    }
    
    func styleImage() {
        flagImg.contentMode = .scaleAspectFill
        flagImg.clipsToBounds = true
        flagImg.layer.cornerRadius = 30
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
    
    func createDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        return divider
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
    
    @objc func openOpenStreetMap() {
        guard let country = country, let url = URL(string: country.maps.openStreetMaps) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func openGoogleMaps() {
        guard let country = country, let url = URL(string: country.maps.googleMaps) else { return }
        UIApplication.shared.open(url)
    }
    
}

#Preview {
    DetailsVC()
}

