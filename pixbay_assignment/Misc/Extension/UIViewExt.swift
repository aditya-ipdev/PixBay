//
//  UIViewExt.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0 
        }get{
           return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            self.layer.shadowColor = newValue!.cgColor
            self.layer.masksToBounds = false;
            self.clipsToBounds = false;
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue!.cgColor
        }
    }
    
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
        * [0,1] range will give undefined results. Animatable. */
       @IBInspectable var shadowOpacity: Float {
           set {
               layer.shadowOpacity = newValue
           }
           get {
               return layer.shadowOpacity
           }
       }
       
       /* The shadow offset. Defaults to (0, -3). Animatable. */
       @IBInspectable var shadowOffset: CGPoint {
           set {
               layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
           }
           get {
               return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
           }
       }
       
       /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
       @IBInspectable var shadowRadius: CGFloat {
           set {
               self.layer.shadowRadius = newValue
               self.layer.masksToBounds = false;
               self.clipsToBounds = false;
           }
           get {
               return layer.shadowRadius
           }
       }
    
    /** Loads instance from nib with the same name. */
    func loadNib<T: UIView>() -> T? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? T
    }
    
    typealias Attributes = (firstAttribute: NSLayoutConstraint.Attribute, constant: CGFloat, toItem: Any?, toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat?)
    
    @discardableResult func createConstraints(attributes: [Attributes], active: Bool) -> [NSLayoutConstraint] {
        guard attributes.count > 0 else {return []}
        translatesAutoresizingMaskIntoConstraints = false
        return attributes.map { attribute -> NSLayoutConstraint in
            let constraint = NSLayoutConstraint(item: self, attribute: attribute.firstAttribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: attribute.toItem, attribute: attribute.toAttribute, multiplier: attribute.multiplier ?? 1.0, constant: attribute.constant)
            constraint.isActive = active
            return constraint
        }
    }
    
}


