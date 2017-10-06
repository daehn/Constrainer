// MIT License
//
// Copyright (c) 2017 Silvan Daehn
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

public struct DimensionProxy {
    let anchor: NSLayoutDimension
    let constant: CGFloat, multiplier: CGFloat
    let priority: UILayoutPriority?
    
    init(anchor: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority? = nil) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }
}

public struct DimensionPriority {
    let constant: CGFloat
    let priority: UILayoutPriority
}

@discardableResult public func ==(lhs: DimensionProxy, rhs: DimensionProxy) -> NSLayoutConstraint {
    return lhs.anchor.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func <=(lhs: DimensionProxy, rhs: DimensionProxy) -> NSLayoutConstraint {
    return lhs.anchor.constraint(lessThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func >=(lhs: DimensionProxy, rhs: DimensionProxy) -> NSLayoutConstraint {
    return lhs.anchor.constraint(greaterThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func ==(lhs: DimensionProxy, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.anchor.constraint(equalToConstant: rhs).activated()
}

@discardableResult public func <=(lhs: DimensionProxy, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.anchor.constraint(lessThanOrEqualToConstant: rhs).activated()
}

@discardableResult public func >=(lhs: DimensionProxy, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.anchor.constraint(greaterThanOrEqualToConstant: rhs).activated()
}

@discardableResult public func ==(lhs: DimensionProxy, rhs: DimensionPriority) -> NSLayoutConstraint {
    return lhs.anchor.constraint(equalToConstant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func <=(lhs: DimensionProxy, rhs: DimensionPriority) -> NSLayoutConstraint {
    return lhs.anchor.constraint(lessThanOrEqualToConstant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func >=(lhs: DimensionProxy, rhs: DimensionPriority) -> NSLayoutConstraint {
    return lhs.anchor.constraint(greaterThanOrEqualToConstant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func +(lhs: DimensionProxy, rhs: CGFloat) -> DimensionProxy {
    return DimensionProxy(anchor: lhs.anchor, constant: lhs.constant + rhs, multiplier: lhs.multiplier)
}

@discardableResult public func -(lhs: DimensionProxy, rhs: CGFloat) -> DimensionProxy {
    return DimensionProxy(anchor: lhs.anchor, constant: lhs.constant - rhs, multiplier: lhs.multiplier)
}

@discardableResult public func *(lhs: DimensionProxy, rhs: CGFloat) -> DimensionProxy {
    return DimensionProxy(anchor: lhs.anchor, constant: lhs.constant, multiplier: rhs)
}

@discardableResult public func /(lhs: DimensionProxy, rhs: CGFloat) -> DimensionProxy {
    return DimensionProxy(anchor: lhs.anchor, constant: lhs.constant, multiplier: 1 / rhs)
}

prefix operator ~
func ~(lhs: CGFloat, rhs: UILayoutPriority) -> DimensionPriority {
    return DimensionPriority(constant: lhs, priority: rhs)
}

func ~(lhs: CGFloat, rhs: Float) -> DimensionPriority {
    return lhs ~ UILayoutPriority(rhs)
}

infix operator ~: AdditionPrecedence
@discardableResult public func ~(lhs: DimensionProxy, rhs: UILayoutPriority) -> DimensionProxy {
    return DimensionProxy(anchor: lhs.anchor, constant: lhs.constant, multiplier: lhs.multiplier, priority: rhs)
}

@discardableResult public func ~(lhs: DimensionProxy, rhs: Float) -> DimensionProxy {
    return lhs ~ UILayoutPriority(rawValue: rhs)
}
