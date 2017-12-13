//
//  RatingControl.swift
//  PhotoFilters
//
//  Created by JerryYin on 07/12/2017.
//  Copyright © 2017 JerryYin. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView{

    //MARK: Proprites
    private var ratingButtons = [UIButton]()
    var rating = 0{
        didSet{
            updateButtonSelectionStatus()
        }
    }
    
    //view 星星尺寸
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height:44.0){
        didSet{
            setupButtons()
        }
    }
    //view 星星数量
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    
    
    //MARK: Initialization 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder){
        super.init(coder: coder)
        setupButtons()
    }
    
    
    //MARK: Private Methods 初始化view方法
    private func setupButtons(){
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for index in 0..<starCount{
            //bundle the image to the button
            let bundle = Bundle(for: type(of: self))
            let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith:self.traitCollection)
            let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith:self.traitCollection)
            let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith:self.traitCollection)

            //create button
            let button = UIButton()
            //ui view
//            button.backgroundColor = UIColor.red
            //status view    [button status: normal, highlighted, focused, selected, and disabled.]
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //set the accessbility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.onRatingButtonClicked(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            // add buttons to array
            ratingButtons.append(button)
        }
        updateButtonSelectionStatus()
    }
    
    private func updateButtonSelectionStatus(){
        for (index, button) in ratingButtons.enumerated(){
              // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    //MARK: Button Action 按键自定义触发事件
    //@objc dynamic
    @objc func onRatingButtonClicked(button:UIButton) {
        print("Buttn pressed 😰")
        //catch the exception       'guard' == 'if not'
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }

        // Calculate the rating of the selected button
        let selectedRating = index + 1

        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    
    
    
}
