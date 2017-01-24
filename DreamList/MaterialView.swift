//
//  MaterialView.swift
//  DreamList
//
//  Created by Dmytro Aprelenko on 24.01.17.
//  Copyright © 2017 Dmytro Aprelenko. All rights reserved.
//

import UIKit

private var materialKey = false


extension UIView {

    @IBInspectable var materialDesign: Bool {
        
        get {
            return materialKey
        }
        set {
            materialKey = newValue
            
            if materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 2.5
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1.0).cgColor
            }
            else
            {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
}
