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

extension UIView: AnchorProviderType {
    public var width:            DimensionProxy                   { return DimensionProxy(anchor: widthAnchor)      }
    public var height:           DimensionProxy                   { return DimensionProxy(anchor: heightAnchor)     }
    public var left:             AnchorProxy<NSLayoutXAxisAnchor> { return AnchorProxy(anchor: leftAnchor)          }
    public var leading:          AnchorProxy<NSLayoutXAxisAnchor> { return AnchorProxy(anchor: leadingAnchor)       }
    public var right:            AnchorProxy<NSLayoutXAxisAnchor> { return AnchorProxy(anchor: rightAnchor)         }
    public var trailing:         AnchorProxy<NSLayoutXAxisAnchor> { return AnchorProxy(anchor: trailingAnchor)      }
    public var centerX:          AnchorProxy<NSLayoutXAxisAnchor> { return AnchorProxy(anchor: centerXAnchor)       }
    public var centerY:          AnchorProxy<NSLayoutYAxisAnchor> { return AnchorProxy(anchor: centerYAnchor)       }
    public var top:              AnchorProxy<NSLayoutYAxisAnchor> { return AnchorProxy(anchor: topAnchor)           }
    public var bottom:           AnchorProxy<NSLayoutYAxisAnchor> { return AnchorProxy(anchor: bottomAnchor)        }
    public var firstBaseline:    AnchorProxy<NSLayoutYAxisAnchor> { return AnchorProxy(anchor: firstBaselineAnchor) }
    public var lastBaseline:     AnchorProxy<NSLayoutYAxisAnchor> { return AnchorProxy(anchor: lastBaselineAnchor)  }
    
    public var margins: AnchorProvider {
        return AnchorProvider(
            left: AnchorProxy(anchor: layoutMarginsGuide.leftAnchor),
            right: AnchorProxy(anchor: layoutMarginsGuide.rightAnchor),
            leading: AnchorProxy(anchor: layoutMarginsGuide.leadingAnchor),
            trailing: AnchorProxy(anchor: layoutMarginsGuide.trailingAnchor),
            centerX: AnchorProxy(anchor: layoutMarginsGuide.centerXAnchor),
            top: AnchorProxy(anchor: layoutMarginsGuide.topAnchor),
            bottom: AnchorProxy(anchor: layoutMarginsGuide.bottomAnchor),
            centerY: AnchorProxy(anchor: layoutMarginsGuide.centerYAnchor),
            height: DimensionProxy(anchor: layoutMarginsGuide.heightAnchor),
            width: DimensionProxy(anchor: layoutMarginsGuide.widthAnchor)
        )
    }
    
    public var safeArea: AnchorProvider {
        return AnchorProvider(
            left: AnchorProxy(anchor: safeAreaLayoutGuide.leftAnchor),
            right: AnchorProxy(anchor: safeAreaLayoutGuide.rightAnchor),
            leading: AnchorProxy(anchor: safeAreaLayoutGuide.leadingAnchor),
            trailing: AnchorProxy(anchor: safeAreaLayoutGuide.trailingAnchor),
            centerX: AnchorProxy(anchor: safeAreaLayoutGuide.centerXAnchor),
            top: AnchorProxy(anchor: safeAreaLayoutGuide.topAnchor),
            bottom: AnchorProxy(anchor: safeAreaLayoutGuide.bottomAnchor),
            centerY: AnchorProxy(anchor: safeAreaLayoutGuide.centerYAnchor),
            height: DimensionProxy(anchor: safeAreaLayoutGuide.heightAnchor),
            width: DimensionProxy(anchor: safeAreaLayoutGuide.widthAnchor)
        )
    }
    
    public var anchors: AnchorProviderType { return self as AnchorProviderType }
}
