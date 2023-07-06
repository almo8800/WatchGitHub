//
//  RepoCollectionViewCell.swift
//  WatchGitHub
//
//  Created by Andrei on 9/6/23.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

private let separatorDecorationView = "separator"

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        register(SeparatorView.self, forDecorationViewOfKind: separatorDecorationView)
        minimumLineSpacing = 2 }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect) ?? []
        let lineWidth = self.minimumLineSpacing
        
        var decorationAttributes: [UICollectionViewLayoutAttributes] = []
        
        for layoutAttribute in layoutAttributes where layoutAttribute.indexPath.item > 0 {
                  let separatorAttribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: separatorDecorationView,
                                                                            with: layoutAttribute.indexPath)
                  let cellFrame = layoutAttribute.frame
                  separatorAttribute.frame = CGRect(x: cellFrame.origin.x,
                                                    y: cellFrame.origin.y - lineWidth,
                                                    width: cellFrame.size.width,
                                                    height: lineWidth)
                  separatorAttribute.zIndex = Int.max
                  decorationAttributes.append(separatorAttribute)
              }

              return layoutAttributes + decorationAttributes
          }
    }

private final class SeparatorView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        self.frame = layoutAttributes.frame
    }
}
