//
//  Utility.swift
//  Final_PremSaiKrishna_Kandagattla
//
//  Created by user206624 on 8/17/22.
//

import Foundation
import UIKit

extension UIColor {

   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)

   }
}


func modifyCSSTextField(sender: UITextField){
    sender.layer.cornerRadius = 22
    sender.layer.backgroundColor = UIColor.init(rgbColorCodeRed: 240, green: 240, blue: 240, alpha: 1).cgColor
    sender.clipsToBounds = false
    sender.layer.shadowOpacity = 0.2
    sender.layer.shadowOffset = CGSize(width: 10, height: 13)
}

func modifyCSSImage(sender: UIImageView){
    sender.layer.cornerRadius = 15
    sender.layer.backgroundColor = UIColor.init(rgbColorCodeRed: 240, green: 240, blue: 240, alpha: 1).cgColor
    sender.clipsToBounds = false
    sender.layer.shadowOpacity = 0.2
    sender.layer.shadowOffset = CGSize(width: 10, height: 13)
}

func modifyCSSButton(sender: UIButton, buttonColor : UIColor, textColor: UIColor? = UIColor.white){
    sender.layer.cornerRadius = 10
    sender.layer.backgroundColor = buttonColor.cgColor
    sender.clipsToBounds = false
    sender.layer.shadowOpacity=0.2
    sender.setTitleColor(textColor, for: .normal)
    sender.layer.shadowOffset = CGSize(width: 10, height: 6)
}


func modifyCSSStackView(sender: UIStackView, color: UIColor? = UIColor.init(rgbColorCodeRed: 240, green: 240, blue: 240, alpha: 1)){
    sender.layer.cornerRadius = 10
    sender.layer.backgroundColor = color?.cgColor
    sender.clipsToBounds = false
    sender.layer.shadowOpacity=0.2
    sender.layer.shadowOffset = CGSize(width: 10, height: 13)
}

func modifyCSSUIView(sender: UIView){
    sender.layer.cornerRadius = 10
    sender.layer.backgroundColor = UIColor.init(rgbColorCodeRed: 240, green: 240, blue: 240, alpha: 1).cgColor
    sender.clipsToBounds = false
    sender.layer.shadowOpacity=0.2
    sender.layer.shadowOffset = CGSize(width: 10, height: 13)
}
