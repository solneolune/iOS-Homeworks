//
//  CountryDetailsViewController.swift
//  Lecture-21-Homework
//
//  Created by Barbare Tepnadze on 25.04.24.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    // MARK: - Properties
    private var country: Country?
    private let viewModel: CountryDetailsViewModel
    
    // MARK: - Elements
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let flagImg: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 60, height: 60))
        return imageView
    }()
    private let flagAltTitle = UILabel()
    private let flagAlt =  UILabel()
    private let infoTitle = UILabel()
    private let linksTitle = UILabel()
    private let infoStackView = UIStackView()
    private let openStreetMapIcon = UIImageView()
    private let googleMapIcon = UIImageView()
    
    // MARK: - Inits
    init(selectedCountry: Country) {
        self.viewModel = CountryDetailsViewModel(country: selectedCountry)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        initSetUp()
    }
    
    // MARK: - Setup and Styling
    func updateUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func initSetUp() {
        setupScrollView()
        initMapIcons()
        styleMapIcons()
        styleTitleLabels([flagAltTitle, infoTitle, linksTitle])
        initStackView()
        styleImage()
        styleInfoStack()
        styleFlagAltText()
        initPageContent()
        createInfoTable()
        updateInfoTable()
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
        let divider1 = createDivider()
        let divider2 = createDivider()
        
        let spacer1 = createSpacerView(height: 24)
        let spacer2 = createSpacerView(height: 24)
        let spacer3 = createSpacerView(height: 24)
        
        let spacer4 = createSpacerView(height: 20)
        let spacer5 = createSpacerView(height: 20)
        
        let stackView = UIStackView(arrangedSubviews: [
            containerView,
            spacer1,
            flagAltTitle,
            flagAlt,
            spacer4,
            divider1,
            spacer2,
            infoTitle,
            infoStackView,
            spacer5,
            divider2,
            spacer3,
            linksTitle
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        let screenSize = UIScreen.main.bounds.size
        let spacing = screenSize.width < 410 ? 12 : 22
        stackView.spacing = CGFloat(spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32),
            
            // 🆘 სთექვიუს საერთო სფეისინგს რომ ვუწერ, მაგიტომ ვეღარ ვშვები ხოლმე ამეებს ვეღარასდროს?
//            flagAltTitle.topAnchor.constraint(equalTo: stackView.arrangedSubviews[0].bottomAnchor, constant: 24),
//            infoTitle.topAnchor.constraint(equalTo: stackView.arrangedSubviews[3].bottomAnchor, constant: 24),
//            linksTitle.topAnchor.constraint(equalTo: stackView.arrangedSubviews[6].bottomAnchor, constant: 24)
        ])
        
        styleContainerView()
        
        let linksStackView = initLinksStackView()
        stackView.addArrangedSubview(linksStackView)
    }
    
    func initPageContent() {
        navigationItem.title = viewModel.countryName
        loadImage(from: viewModel.flagImageURL)
        flagAltTitle.text = "About the flag:"
        flagAlt.text = viewModel.flagAltText
        infoTitle.text = "Basic information:"
        linksTitle.text = "Useful links:"
    }
    
    func createDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = .separator
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        return divider
    }
    
    func createSpacerView(height: CGFloat) -> UIView {
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spacerView.heightAnchor.constraint(equalToConstant: height)
        ])
        return spacerView
    }
    
    func styleContainerView() {
        containerView.layer.shadowColor = UIColor.label.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.15
        containerView.translatesAutoresizingMaskIntoConstraints = false
        styleImage()
        containerView.addSubview(flagImg)
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 228),
            flagImg.topAnchor.constraint(equalTo: containerView.topAnchor),
            flagImg.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            flagImg.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            flagImg.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func styleImage() {
        flagImg.contentMode = .scaleAspectFill
        flagImg.clipsToBounds = true
        flagImg.layer.cornerRadius = 30
        flagImg.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleTitleLabels(_ labels: [UILabel]) {
        for label in labels {
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func styleFlagAltText() {
        flagAlt.numberOfLines = 0
        flagAlt.textAlignment = .left
        flagAlt.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    func initMapIcons() {
        openStreetMapIcon.isUserInteractionEnabled = true
        googleMapIcon.isUserInteractionEnabled = true
        openStreetMapIcon.image = UIImage(named: "map1")
        googleMapIcon.image = UIImage(named: "map2")
        let tapOSM = UITapGestureRecognizer(target: self, action: #selector(openOpenStreetMap))
        let tapGoogle = UITapGestureRecognizer(target: self, action: #selector(openGoogleMaps))
        openStreetMapIcon.addGestureRecognizer(tapOSM)
        googleMapIcon.addGestureRecognizer(tapGoogle)
    }
    
    func styleMapIcons() {
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
    
    func initLinksStackView() -> UIStackView {
        let mapsStackView = UIStackView(arrangedSubviews: [openStreetMapIcon, googleMapIcon])
        mapsStackView.axis = .horizontal
        mapsStackView.distribution = .fillEqually
        mapsStackView.alignment = .center
        mapsStackView.spacing = 0
        return mapsStackView
    }
    
    func styleInfoStack() {
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.alignment = .fill
        infoStackView.spacing = 15
    }
    
    func createInfoTable() {
        let titles = [
            "Native name:",
            "Spelling:",
            "Capital:",
            "Currency:",
            "Region:",
            "Neighbors:"
        ]
        
        for title in titles {
            let rowView = createRow(title: title, value: "")
            infoStackView.addArrangedSubview(rowView)
        }
    }
    
    func updateInfoTable() {
        for (i, rowStackView) in infoStackView.arrangedSubviews.enumerated() {
            guard let rowStackView = rowStackView as? UIStackView,
                  let valueLabel = rowStackView.arrangedSubviews.last as? UILabel else {
                continue
            }
            let details: [(String, String)] = [
                ("Native name:", viewModel.nativeName),
                ("Spelling:", viewModel.spelling),
                ("Capital:", viewModel.capitals),
                ("Currency:", viewModel.currencies),
                ("Region:", viewModel.region),
                ("Neighbors:", viewModel.neighbors)
            ]
            guard i < details.count else {
                continue
            }
            valueLabel.text = details[i].1
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

    
    // MARK: -  UI Action Functions
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
        guard let url = viewModel.openStreetMapsURL else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func openGoogleMaps() {
        guard let url = viewModel.googleMapsURL else { return }
        UIApplication.shared.open(url)
    }
    
}
