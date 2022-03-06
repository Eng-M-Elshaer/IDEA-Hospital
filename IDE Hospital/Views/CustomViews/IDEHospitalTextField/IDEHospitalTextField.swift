//
//  IDEHospitalTextField.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit

class IDEHospitalTextField: UITextField {
    
    // MARK:- Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layoutIfNeeded()
        setupUI()
    }
    
    var isAddComment: Bool = false
    
    func padingLocaliztioin() -> UIEdgeInsets {
        if LanguageManager.shared().isRTL() {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 50)
        }
        return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 5)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        if !isAddComment {
            return bounds.inset(by: padingLocaliztioin())
        }
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if !isAddComment {
            return bounds.inset(by: padingLocaliztioin())
        }
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        if !isAddComment {
            return bounds.inset(by: padingLocaliztioin())
        }
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
}

// MARK:- Public Methods
extension IDEHospitalTextField {    
    func addImage(image: UIImage) {
        let imageView = UIImageView()
        imageView.layoutIfNeeded()
        imageView.image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        imageView.frame = CGRect(x: 0, y: 0, width: 32, height: self.frame.height)
        imageView.contentMode = .scaleToFill
        leftViewMode = .always
        leftView = imageView
    }
    func addLineView(){
        let lineView = UIView()
        lineView.layoutIfNeeded()
        lineView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1)
        lineView.backgroundColor = .white
        self.addSubview(lineView)
    }
}
    
// MARK:- Private Methods
extension IDEHospitalTextField {
    private func setupUI() {
        backgroundColor = .clear
        textColor = .white
        adjustsFontSizeToFitWidth = true
        font = FontFamily.PTSans.bold.font(size: 15)
        removeBorder()
    }
    private func removeBorder(){
        self.borderStyle = .none
    }
}
