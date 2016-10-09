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
    var cellPadding: CGFloat = 5.0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView?.contentInset
        return collectionView!.bounds.width - (insets!.left + insets!.right)
    }
    
    override func prepare() {
        if cache.isEmpty {
            let columnWidth = contentWidth / CGFloat(numberOfColums)
            var xOffset = [CGFloat]()
            
            for column in 0..<numberOfColums {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColums)
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = NSIndexPath(item: item, section: 0)
                
                let width = Int(columnWidth) - Int(cellPadding*2)
                let photoHeight = delegate.collectionView(collectionView: collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: CGFloat(width))
                let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: CGFloat(width))
                let height = cellPadding + photoHeight + annotationHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let cgRect = CGRect()
                let insetFrame = cgRect.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, contentWidth)
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColums - 1) ? 0 : column + 1
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        let gcRect = CGRect()
        for attributes in cache {
            if gcRect.intersects(attributes.frame) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    

}








