//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container = UIView(frame: CGRectMake(0,0,200,200))
container.backgroundColor = UIColor.whiteColor()

let mover = UIView(frame: CGRectMake(0,0,30,30))
mover.backgroundColor = UIColor.redColor()

container.addSubview(mover)
XCPlaygroundPage.currentPage.liveView = container

let keyFrameAni = CAKeyframeAnimation()
keyFrameAni.keyPath = "position"
keyFrameAni.duration = 3
let value1 = NSValue(CGPoint: CGPointMake(15, 15))
let value2 = NSValue(CGPoint: CGPointMake(15, 185))
let value3 = NSValue(CGPoint: CGPointMake(185, 185))
let value4 = NSValue(CGPoint: CGPointMake(185, 15))
keyFrameAni.values = [value1, value2, value3, value4, value1]

keyFrameAni.path = UIBezierPath(ovalInRect: container.frame).CGPath

mover.layer.addAnimation(keyFrameAni, forKey: keyFrameAni.keyPath)