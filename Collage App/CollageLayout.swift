//
//  CollageLayout.swift
//  Collage App
//
//  Created by Luis Arias on 08/10/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import UIKit

protocol CollageLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat ) -> CGFloat
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat ) -> CGFloat
}

class CollageLayout: UICollectionViewLayout {
    
    var delegate: CollageLayoutDelegate!
    
    var numberOfColums = 2
    var cellPadding = 5.0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHight = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView?.contentInset
        return collectionView!.bounds.width - (insets!.left + insets!.right)
    }
    
    override func prepare() {
        if cache.isEmpty {
            let columnWidth = 
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        <#code#>
    }

}
