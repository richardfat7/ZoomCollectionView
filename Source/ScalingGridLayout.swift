import Foundation
import UIKit

public class ScalingGridLayout : UICollectionViewLayout, ScalingLayoutProtocol {
    
    public let itemSize: CGSize
    public let columns: CGFloat
    public let itemSpacing: CGFloat
    
    private var scale: CGFloat
    private var attributes: [UICollectionViewLayoutAttributes] = []
    private var contentSize: CGSize = .zero
    
    public init(itemSize: CGSize, columns: CGFloat, itemSpacing: CGFloat, scale: CGFloat) {
        self.itemSize = itemSize
        self.columns = columns
        self.itemSpacing = itemSpacing
        self.scale = scale
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    public func contentSizeForScale(_ scale: CGFloat) -> CGSize {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        let rowCount = ceil(CGFloat(itemCount)/CGFloat(columns))
        let sz = CGSize(
            width: itemSize.width * columns + itemSpacing * (columns - 1),
            height: itemSize.height * rowCount + itemSpacing * (rowCount - 1)
        )
        return sz.scale(scale)
    }
    
    override public func prepare() {
        super.prepare()
        self.contentSize = contentSizeForScale(self.scale)
        let itemCount = self.collectionView!.numberOfItems(inSection: 0)
        let columnCount = self.columns
        
        attributes = (0..<itemCount).map { idx in
            let rowIdx = floor(Double(idx) / Double(columnCount))
            let columnIdx =  idx % Int(columnCount)
            let pt = CGPoint(
                x: (itemSize.width + itemSpacing) * CGFloat(columnIdx),
                y: (itemSize.height + itemSpacing) * CGFloat(rowIdx)
            )
            let rect = CGRect(origin: pt, size: self.itemSize)
            let attr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: idx, section: 0))
            attr.frame = rect.scale(self.scale)
            return attr
        }
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes.filter { $0.frame.intersects(rect) }
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes.first { $0.indexPath == indexPath }
    }
    
    public func setScale(_ scale: CGFloat) {
        self.scale = scale
    }
    
    public func getScale() -> CGFloat {
        return self.scale
    }
    
}
