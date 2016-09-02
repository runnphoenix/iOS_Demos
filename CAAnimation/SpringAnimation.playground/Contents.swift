//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container = UIView(frame: CGRectMake(0,0,200,200))
container.backgroundColor = UIColor.whiteColor()

let label = UILabel(frame: CGRectMake(0,0,100,50))
label.backgroundColor = UIColor.redColor()
container.addSubview(label)
XCPlaygroundPage.currentPage.liveView = container

let springAnimation = CASpringAnimation(keyPath:"position.x")
springAnimation.damping = 5
springAnimation.stiffness = 100
springAnimation.mass = 1
springAnimation.initialVelocity = 0
springAnimation.fromValue = label.layer.position.x
springAnimation.toValue = label.layer.position.x + 100
springAnimation.duration = 3
label.layer.addAnimation(springAnimation, forKey: springAnimation.keyPath)
