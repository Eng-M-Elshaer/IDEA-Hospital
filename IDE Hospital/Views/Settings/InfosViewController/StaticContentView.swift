//
//  StaticContentView.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

class StaticContentView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var scrollview: UIScrollView!

    // MARK:- Public Methods
    func setup(){
        self.setupLabel()
        self.setupViews()
    }
    func setLabel(text: String){
        self.contentLabel.text = text
    }
}
//MARK:- Private Methods
extension StaticContentView{
    private func setupLabel(){
        contentLabel.font = FontFamily.PTSans.regular.font(size: 15)
        contentLabel.textColor = .white
        contentLabel.numberOfLines = 0
    }
    private func setupViews(){
        self.contentview.backgroundColor = .clear
        self.scrollview.backgroundColor = .clear
    }
}
