//
//  ProgressHeaderCell.swift
//  NWMuseumAR
//
//  Created by Harrison Milbradt on 2018-05-02.
//  Copyright © 2018 NWMuseumAR. All rights reserved.
//

import UIKit

class ProgressHeaderCell: UICollectionReusableView {
    
    /** Top Container Wrapper */
    lazy var topContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 310)
        container.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Top Page Container"))
        return container
    }()
    
    /** Title */
    let topContainerTitle: UITextView = {
        let title = UITextView()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.textColor = .mainTitleDark
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        title.backgroundColor = nil
        let attributedString = NSMutableAttributedString(string: "ARTIFACTS")
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.alignment = .center
        attributedString.addAttributes([
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.heavy),
            NSAttributedStringKey.kern: 3,
            NSAttributedStringKey.foregroundColor: UIColor(red: 0.26, green: 0.28, blue: 0.37, alpha: 1.0),
            NSAttributedStringKey.paragraphStyle: paragraphStyle
            ], range: NSRange(location: 0, length: attributedString.length))
        title.attributedText = attributedString
        return title
    }()
    
    /** Subtitle */
    let topContainerSubtitle: UITextView = {
        let subtitle = UITextView()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.isEditable = false
        subtitle.isScrollEnabled = false
        subtitle.isSelectable = false
        subtitle.backgroundColor = nil
        subtitle.text = "0 COLLECTED"
        
        let attributedString = NSMutableAttributedString(string: "\(Artifact.countCompleted()) COMPLETED")
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.alignment = .center
        attributedString.addAttributes([
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium),
            NSAttributedStringKey.kern: 2.5,
            NSAttributedStringKey.foregroundColor: UIColor(red: 0.67, green: 0.69, blue: 0.73, alpha: 1.0),
            NSAttributedStringKey.paragraphStyle: paragraphStyle
            ], range: NSRange(location: 0, length: attributedString.length))
        subtitle.attributedText = attributedString
        
        return subtitle
    }()
    
    fileprivate func setupViewsLayout()
    {
        // Top container
        let topContainer = UIView()
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Top Page Container"))
        addSubview(topContainer)
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topContainer.heightAnchor.constraint(equalToConstant: 310)
            ])
        
        // Top title.
        topContainer.addSubview(topContainerTitle)
        NSLayoutConstraint.activate([
            topContainerTitle.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -33),
            topContainerTitle.leftAnchor.constraint(equalTo: topContainer.leftAnchor),
            topContainerTitle.rightAnchor.constraint(equalTo: topContainer.rightAnchor)
            ])
        
        // Number of artifacts collected.
        topContainer.addSubview(topContainerSubtitle)
        NSLayoutConstraint.activate([
            topContainerSubtitle.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -14),
            topContainerSubtitle.leftAnchor.constraint(equalTo: topContainer.leftAnchor),
            topContainerSubtitle.rightAnchor.constraint(equalTo: topContainer.rightAnchor)
            ])
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            setupViewsLayout()
        }
    }
}
