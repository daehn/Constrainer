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

public protocol AnchorProviderType {
    var left: AnchorProxy<NSLayoutXAxisAnchor> { get }
    var right: AnchorProxy<NSLayoutXAxisAnchor> { get }
    var leading: AnchorProxy<NSLayoutXAxisAnchor> { get }
    var trailing: AnchorProxy<NSLayoutXAxisAnchor> { get }
    var centerX: AnchorProxy<NSLayoutXAxisAnchor> { get }
    var top: AnchorProxy<NSLayoutYAxisAnchor> { get }
    var bottom: AnchorProxy<NSLayoutYAxisAnchor> { get }
    var centerY: AnchorProxy<NSLayoutYAxisAnchor> { get }
    var height: DimensionProxy { get }
    var width: DimensionProxy { get }
}

public extension AnchorProviderType {
    var edges:  EdgesProxy  { return EdgesProxy(leading, trailing, top, bottom)      }
    var center: CenterProxy { return CenterProxy(centerX: centerX, centerY: centerY) }
}

public  struct AnchorProvider: AnchorProviderType {
    public let left: AnchorProxy<NSLayoutXAxisAnchor>
    public let right: AnchorProxy<NSLayoutXAxisAnchor>
    public let leading: AnchorProxy<NSLayoutXAxisAnchor>
    public let trailing: AnchorProxy<NSLayoutXAxisAnchor>
    public let centerX: AnchorProxy<NSLayoutXAxisAnchor>
    public let top: AnchorProxy<NSLayoutYAxisAnchor>
    public let bottom: AnchorProxy<NSLayoutYAxisAnchor>
    public let centerY: AnchorProxy<NSLayoutYAxisAnchor>
    public let height: DimensionProxy
    public let width: DimensionProxy
}
