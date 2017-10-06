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

public struct EdgesProxy {
    let leading:  AnchorProxy<NSLayoutXAxisAnchor>
    let trailing: AnchorProxy<NSLayoutXAxisAnchor>
    let top:      AnchorProxy<NSLayoutYAxisAnchor>
    let bottom:   AnchorProxy<NSLayoutYAxisAnchor>
    
    init(
        _ leading:  AnchorProxy<NSLayoutXAxisAnchor>,
        _ trailing: AnchorProxy<NSLayoutXAxisAnchor>,
        _ top:      AnchorProxy<NSLayoutYAxisAnchor>,
        _ bottom:   AnchorProxy<NSLayoutYAxisAnchor>
        ) {
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
    }
}

@discardableResult public func ==(lhs: EdgesProxy, rhs: EdgesProxy) -> [NSLayoutConstraint] {
    return [lhs.top == rhs.top, lhs.bottom == rhs.bottom, lhs.leading == rhs.leading, lhs.trailing == rhs.trailing]
}

@discardableResult public func <=(lhs: EdgesProxy, rhs: EdgesProxy) -> [NSLayoutConstraint] {
    return [lhs.top <= rhs.top, lhs.bottom <= rhs.bottom, lhs.leading <= rhs.leading, lhs.trailing <= rhs.trailing]
}

@discardableResult public func >=(lhs: EdgesProxy, rhs: EdgesProxy) -> [NSLayoutConstraint] {
    return [lhs.top >= rhs.top, lhs.bottom >= rhs.bottom, lhs.leading >= rhs.leading, lhs.trailing >= rhs.trailing]
}

@discardableResult public func +(lhs: EdgesProxy, rhs: CGFloat) -> EdgesProxy {
    return EdgesProxy(lhs.leading - rhs, lhs.trailing + rhs, lhs.top - rhs, lhs.bottom + rhs)
}

@discardableResult public func -(lhs: EdgesProxy, rhs: CGFloat) -> EdgesProxy {
    return EdgesProxy(lhs.leading + rhs, lhs.trailing - rhs, lhs.top + rhs, lhs.bottom - rhs)
}

@discardableResult public func +(lhs: EdgesProxy, rhs: UIEdgeInsets) -> EdgesProxy {
    return EdgesProxy(lhs.leading + rhs.left, lhs.trailing + rhs.right, lhs.top + rhs.top, lhs.bottom + rhs.bottom)
}

@discardableResult public func ~(lhs: EdgesProxy, rhs: UILayoutPriority) -> EdgesProxy {
    return EdgesProxy(lhs.leading ~ rhs, lhs.trailing ~ rhs, lhs.top ~ rhs, lhs.bottom ~ rhs)
}

@discardableResult public func ~(lhs: EdgesProxy, rhs: Float) -> EdgesProxy {
    return EdgesProxy(lhs.leading ~ rhs, lhs.trailing ~ rhs, lhs.top ~ rhs, lhs.bottom ~ rhs)
}
