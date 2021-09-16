//
//  StretchyHeaderLayout.swift
//  Movies
//
//  Created by msc on 25.05.2021.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)

        layoutAttributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {

                guard let collectionView = collectionView else { return }

                let contentOffsetY = collectionView.contentOffset.y

                if contentOffsetY > 0 {
                    return
                }

                let height = attributes.frame.height - contentOffsetY
                let width = collectionView.frame.width

                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height - 16)
            }
        })

        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
