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

public struct AnchorProxy<T> where T: AnyObject {
    let anchor: NSLayoutAnchor<T>
    let constant: CGFloat
    let priority: UILayoutPriority?
    
    
    init(anchor: NSLayoutAnchor<T>, constant: CGFloat = 0, priority: UILayoutPriority? = nil) {
        self.anchor = anchor
        self.constant = constant
        self.priority = priority
    }
}

@discardableResult public func ==<T>(lhs: AnchorProxy<T>, rhs: AnchorProxy<T>) -> NSLayoutConstraint {
    return lhs.anchor.constraint(equalTo: rhs.anchor, constant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func <=<T>(lhs: AnchorProxy<T>, rhs: AnchorProxy<T>) -> NSLayoutConstraint {
    return lhs.anchor.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func >=<T>(lhs: AnchorProxy<T>, rhs: AnchorProxy<T>) -> NSLayoutConstraint {
    return lhs.anchor.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant).activated(with: rhs.priority)
}

@discardableResult public func +<T>(lhs: AnchorProxy<T>, rhs: CGFloat) -> AnchorProxy<T> {
    return AnchorProxy<T>(anchor: lhs.anchor, constant: lhs.constant + rhs, priority: lhs.priority)
}

@discardableResult public func -<T>(lhs: AnchorProxy<T>, rhs: CGFloat) -> AnchorProxy<T> {
    return AnchorProxy<T>(anchor: lhs.anchor, constant: lhs.constant - rhs, priority: lhs.priority)
}

@discardableResult public func ~<T>(lhs: AnchorProxy<T>, rhs: UILayoutPriority) -> AnchorProxy<T> {
    return AnchorProxy<T>(anchor: lhs.anchor, constant: lhs.constant, priority: rhs)
}

@discardableResult public func ~<T>(lhs: AnchorProxy<T>, rhs: Float) -> AnchorProxy<T> {
    return lhs ~ UILayoutPriority(rawValue: rhs)
}
