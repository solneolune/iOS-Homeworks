//
//  ViewController.swift
//  Lecture-13-Homework
//
//  Created by Barbare Tepnadze on 05.04.24.
//

import UIKit

struct Coffee {
    var productName: String
    var ingredients: String
    var rating: Double
    var reviews: Int
    var description: String
    var smallPrice: Double
    var mediumPrice: Double
    var largePrice: Double
}

class ViewController: UIViewController {
    
    @IBOutlet var productPageView: UIView!
    @IBOutlet weak var productPhoto: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var ratingIcon: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var smallSize: UIButton!
    @IBOutlet weak var mediumSize: UIButton!
    @IBOutlet weak var bigSize: UIButton!
    @IBOutlet weak var showPrice: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    
    var isFavored = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBasicDesign()
        styleButtons(to: [smallSize, mediumSize, bigSize])
        
        productTitle.text = cappuccino.productName
        ingredients.text = cappuccino.ingredients
        rating.text = String(cappuccino.rating)
        reviews.text = "(\(cappuccino.reviews))"
        productDescription.text = String(cappuccino.description)
        showPrice.text = "₾ \(cappuccino.mediumPrice)"
        
        let clicker = UITapGestureRecognizer(target: self, action: #selector(heartClicked))
                favorite.isUserInteractionEnabled = true
                favorite.addGestureRecognizer(clicker)
    }
    
    func initBasicDesign() {
        productPhoto.layer.cornerRadius = 16
        divider.backgroundColor = UIColor.systemGray
        //        productTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        //        productTitle.adjustsFontForContentSizeCategory = true
        //        ingredients.font = UIFont.preferredFont(forTextStyle: .subheadline)
        //        ingredients.adjustsFontForContentSizeCategory = true
        buyButton.layer.cornerRadius = 25
        activeButton(to: mediumSize)
    }
    
    func styleButtons(to buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 12
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray.cgColor
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.backgroundColor = nil
        }
    }
    
    func activeButton(to button: UIButton) {
        button.layer.borderColor = UIColor.systemBrown.cgColor
        button.backgroundColor = UIColor.systemBrown
        button.titleLabel?.textColor = UIColor.systemBrown
    }
    
    func deactivateButton() {
        styleButtons(to: [smallSize, mediumSize, bigSize])
        
    }
    
    var cappuccino = Coffee(productName: "კაპუჩინო", ingredients: "შოკოლადით", rating: 4.8, reviews: 230, description: "მოცემული კაპუჩინო არის დაახლოებით 150 მლ. ის შეიცავს 25 მლ. ესპრესოს ყავას, 85 მლ. ახალთახალი მოწველილი ძროხის რძის რძეს, რომელიც სპეც... მეტი", smallPrice: 3.53, mediumPrice: 4.53, largePrice: 5.53)
    
    
    @IBAction func smallSizeChosen(_ sender: UIButton) {
        styleButtons(to: [smallSize, mediumSize, bigSize])
        showPrice.text = String(cappuccino.smallPrice)
        activeButton(to: sender)
    }
    
    
    
    @IBAction func mediumSizeChosen(_ sender: UIButton) {
        styleButtons(to: [smallSize, mediumSize, bigSize])
        showPrice.text = String(cappuccino.mediumPrice)
        activeButton(to: sender)
    }
    
    
    @IBAction func largeSizeChosen(_ sender: UIButton) {
        styleButtons(to: [smallSize, mediumSize, bigSize])
        showPrice.text = String(cappuccino.largePrice)
        activeButton(to: sender)
    }
    
    @objc func heartClicked() {
        isFavored.toggle()
        favoriteItem()
    }
    
    func favoriteItem() {
        
        if isFavored {
            cappuccino.reviews += 1
        } else {
            cappuccino.reviews -= 1
        }
        favorite.image = UIImage(systemName: isFavored ? "heart.fill" : "heart")
        
        reviews.text = "(\(cappuccino.reviews))"
        
    }
}



