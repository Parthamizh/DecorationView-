//
//  decorationView.swift
//  decoratorview
//
//  Created by ev_mac18 on 26/04/18.
//  Copyright © 2018 ev_mac18. All rights reserved.
//// Parthiban Ios Developer


import UIKit

class decorationView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ atts: UICollectionViewLayoutAttributes) {

        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 12))
        lbl.text = "decorView using flowlayout,Tis is lbl on decor view"
        lbl.backgroundColor = UIColor.lightGray
        self.addSubview(lbl)
    }
}


class CollectionViewFlowLayout: UICollectionViewFlowLayout {

    
    private let timeLine = "decorationView"
    private let overlayValue: CGFloat = 4
    private let timeLineHeight: CGFloat = 10
    
    
    private let eventHeignt: CGFloat = 50
    private var timeLineSpace: CGFloat {
        return eventHeignt - 2 * overlayValue
    }
    
    private var decorationViewLeftInset: CGFloat {
        return 16
    }
    
    private var hours: Int {
        return 24
    }
    
    private var leftEventInset: CGFloat {
        return 40 + decorationViewLeftInset
    }
    
    private var numberOfItems: Int {
        return collectionView!.numberOfItems(inSection: 0)
    }
    
    private var collectionViewWidth: CGFloat {
        return collectionView!.bounds.width
    }
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var decorationAttributes: [UICollectionViewLayoutAttributes] {
        var attributes: [UICollectionViewLayoutAttributes] = []
        for item in 0..<hours {
            let indexPath = IndexPath(item: item, section: 0)
            if let decatts = self.layoutAttributesForDecorationView(ofKind:self.timeLine, at: indexPath) {
                attributes.append(decatts)
            }
        }
        return attributes
    }
    

    
    override func prepare() {
        super.prepare()
        register(decorationView.self, forDecorationViewOfKind: "decorationView")

    }
    
    override func layoutAttributesForDecorationView( ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let atts = UICollectionViewLayoutAttributes(forDecorationViewOfKind:timeLine, with:indexPath)

        print("indexpath",indexPath.item)
        print(indexPath.item  % 7)
        if (indexPath.item  % 7) == 0
        {
            if (indexPath.item == 0)
            {
                atts.frame = CGRect(x: 0, y: ((50 * (indexPath.item + 1)) + (20 * (indexPath.item/7))), width: Int(collectionViewWidth), height: 20)
                print("frame",atts.frame)
            }
            else
            {
             atts.frame = CGRect(x: 0, y: ((50 * ((indexPath.item/7) + 1)) + (20 * (indexPath.item/7))) , width: Int(collectionViewWidth), height: 20)
            print("frame",atts.frame)
            }
        }

        let lbl = UILabel(frame: atts.frame)
        lbl.text = "hello world"
        //superclass?.addSubview(lbl)
        
        return atts
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        

        
        for i : Int in 0..<numberOfItems {
            
            let indexPath = NSIndexPath(item: i, section: 0)//NSIndexPath(forItem: i, inSection: 0)
            let attributes = self.layoutAttributesForItem(at: indexPath as IndexPath)//self.layoutAttributesForItem(at: indexPath as IndexPath)
            // attributes.frame = CGRect(x: (i * 50) + 5, y: 0, width: 50, height: 50)
            if attributes != nil
            {
                layoutAttributes.append(attributes!)//append(attributes!)
            }
        }
        
        for i : Int in 0..<numberOfItems{
            
            if (i  % 7) == 0
            {
            let indexPath = NSIndexPath(item: i, section: 0)
            let attributes = self.layoutAttributesForDecorationView(ofKind: "decorationView", at: indexPath as IndexPath)
            //attribute.frame = CGRect(x: 0, y: 0, width: (self.collectionView?.frame.size.width)!, height: 20)
            layoutAttributes.append(attributes!)
            }
        }
        
    
        
        return layoutAttributes
    }
    

}
