//
//  BlockButton.swift
//
//
//  Created by Cem Olcay on 12/08/15.
//
//
import UIKit

public typealias BlockButtonAction = (sender: BlockButton) -> Void

public class BlockButton: UIButton {

    // MARK: Propeties

    public var highlightLayer: CALayer?
    public var action: BlockButtonAction?

    // MARK: Init

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        defaultInit()
    }

    public init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        super.init(frame: CGRect(x: x, y: y, width: w, height: h))
        defaultInit()
    }

    public init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, action: BlockButtonAction?) {
        super.init (frame: CGRect(x: x, y: y, width: w, height: h))
        self.action = action
        defaultInit()
    }

    public init(action: BlockButtonAction) {
        super.init(frame: CGRectZero)
        self.action = action
        defaultInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }

    public init(frame: CGRect, action: BlockButtonAction) {
        super.init(frame: frame)
        self.action = action
        defaultInit()
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        defaultInit()
    }

    private func defaultInit() {
        addTarget(self, action: "didPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        addTarget(self, action: "highlight", forControlEvents: [UIControlEvents.TouchDown, UIControlEvents.TouchDragEnter])
        addTarget(self, action: "unhighlight", forControlEvents: [UIControlEvents.TouchUpInside, UIControlEvents.TouchUpOutside, UIControlEvents.TouchCancel, UIControlEvents.TouchDragExit])
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected)
    }

    public func addAction(action: BlockButtonAction) {
        self.action = action
    }

    // MARK: Action

    public func didPressed(sender: BlockButton) {
        action?(sender: sender)
    }

    // MARK: Highlight

    public func highlight() {
        if action == nil {
            return
        }
        let highlightLayer = CALayer()
        highlightLayer.frame = layer.bounds
        highlightLayer.backgroundColor = UIColor.blackColor().CGColor
        highlightLayer.opacity = 0.5
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, false, 0)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let maskImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let maskLayer = CALayer()
        maskLayer.contents = maskImage.CGImage
        maskLayer.frame = highlightLayer.frame
        highlightLayer.mask = maskLayer
        layer.addSublayer(highlightLayer)
        self.highlightLayer = highlightLayer
    }

    public func unhighlight() {
        if action == nil {
            return
        }
        highlightLayer?.removeFromSuperlayer()
        highlightLayer = nil
    }

}

