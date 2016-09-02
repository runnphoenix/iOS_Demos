//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container = UIView(frame: CGRectMake(0,0,200,200))
container.backgroundColor = UIColor.whiteColor()
XCPlaygroundPage.currentPage.liveView = container

let transition = CATransition()
transition.duration = 1
transition.type = kCATransitionPush
transition.subtype = kCATransitionFromRight
transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
transition.repeatCount = 3

container.layer.addAnimation(transition, forKey: nil)