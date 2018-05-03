//
//  ProgressController.swift
//  NewWestAr
//
//  Created by Justin Leung on 4/10/18.
//  Copyright © 2018 Justin Leung. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    var artifacts: [Artifact]?
    
    var overlayMode = false
    var overlayView: ArtifactDetailOverlay?
    
    /** View Loaded */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        artifacts = Artifact.getAll()
        
        setupViewsLayout()
        
        artifactCollectionView.dataSource = self
        artifactCollectionView.delegate = self
        
        view.backgroundColor = UIColor(red: 0.97, green: 0.96, blue: 0.98, alpha: 1.0)
        
    }
    
    /** Artifacts Collection View */
    let artifactCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), collectionViewLayout: layout)
        // TODO: - Update this mess to support other screen sizes
        layout.headerReferenceSize = CGSize(width: 375, height: 310)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(red: 0.97, green: 0.96, blue: 0.98, alpha: 1.0)
        collectionView.register(ArtifactCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(ProgressHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        return collectionView
    }()
    
    fileprivate func setupViewsLayout()
    {
        // Artifact Collection View
        
        view.addSubview(artifactCollectionView)
        NSLayoutConstraint.activate([
            artifactCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            artifactCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            artifactCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            artifactCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func showOverlay(artifactName: String, description: String) {
        self.overlayBlurredBackgroundView()
        overlayMode = true
        
        instantiateOverlayContainer(artifactName: artifactName, description: description)
        
        // Set detected artifact back to nil to disable click
    }
    
    func dismissOverlay() {
        
        if let viewWithTag = self.view.viewWithTag(10) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
        
        if let view = self.view.viewWithTag(100) {
            view.removeFromSuperview()
        }else{
            print("No!")
        }
    }
    
    func overlayBlurredBackgroundView() {
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.tag = 100
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        
        view.addSubview(blurredBackgroundView)
    }
    
    func instantiateOverlayContainer(artifactName: String, description: String) {
        overlayView = ArtifactDetailOverlay(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        overlayView!.artifact = artifactName
        overlayView!.artifactDescription = description
        overlayView!.tag = 10
        overlayView!.image = UIImage.init(named: "" + artifactName + "Icon")
        overlayView!.parentController = self
        overlayView?.victoryMessageView.text = description
        debugPrint(description)
        view.addSubview(overlayView!)
    }
    
    /** Hide Status Bar */
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}

extension ProgressViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /** Sets the spacing between collection views. */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /** Sets the number of cells in the collection view. */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artifacts?.count ?? 0
    }
    
    /** Create the sells in the collection view. */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ArtifactCell
        
        let artifact = artifacts![indexPath.item]
        debugPrint(artifact.hint!)
        cell.completed = artifact.completed
        cell.imageName = artifact.title
        
        // Assign artifact details here.
        cell.artifactIcon.image = UIImage(named: artifact.image!)
        cell.artifactTitle.text = artifact.title?.uppercased()
        cell.artifactDescription = artifact.hint!
        cell.artifactSubtitle.text = artifact.completed ? "COLLECTED" : "SCAN TO UNLOCK"
        cell.backgroundColor = UIColor(red: 0.97, green: 0.96, blue: 0.98, alpha: 1.0)
        cell.parentViewController = self
        cell.setupLayout()
        return cell
    }
    
    /** Sets the size of each cell. */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId", for: indexPath) as! ProgressHeaderCell
        
        reusableview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 310)
        return reusableview
    }
}
