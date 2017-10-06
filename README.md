# Constrainer

[![Build Status](https://travis-ci.org/daehn/Constrainer.svg?branch=develop)](https://travis-ci.org/daehn/Constrainer) [![codecov](https://codecov.io/gh/daehn/Constrainer/branch/develop/graph/badge.svg)](https://codecov.io/gh/daehn/Constrainer) ![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Constrainer is meant to be a lightweight AutoLayout helper. Constrainer exposes several properties on `UIView` that can be used to construct layout constraints using operators. This mostly was an experiment to see how much of [Cartography](https://github.com/robb/Cartography)'s functionality can be replicated without using proxies only accessible in closures and the syntax of Constrainer is this heavily inspired by [Cartography](https://github.com/robb/Cartography).

```swift
view.leading == imageView.trailing - 20
label.edges <= labelContainerView.margins.edges
let widthConstraint = view.width >= imageView.height / 2 ~ .defaultLow
```

Constrainer does currently **NOT** set `translatesAutoresizingMaskIntoConstraints` to `false` but sets  `isActive` to `true` for all involved views in a expression when creating a constraint.
All expressions return a `NSLayoutConstraint` (or an array of `NSLayoutConstraint` when using `edges` or `center`), which can be stored and used to modify / deactivate the constraint at a later point.

All available properties to construct constraints using Constrainer are:

* `top`
* `bottom`
* `leading`
* `trailing`
* `width`
* `height`
* `left`
* `right`
* `centerY`
* `centerX`
* `firstBaseline`
* `lastBaseline`
* `edges`
* `center`

If the constraints should be relative to margins or safe areas all of the above properties are also available on the `UIView.margins` and `UIView.safeArea` properties.

A `UILayoutPriority` can be set for the constraint using the `~` operator.

```swift
view.leading == imageView.trailing ~ .defaultHight
label.edges >= labelContainerView.edges ~ 750
```

Edges can be inset using `CGFloat` values or `UIEdgeInset` values.

```swift
label.edges >= labelContainerView.edges + UIEdgeInsets(top: 12, left: 16, bottom: -8, right: -42)
labelContainerView.edges == view.safeArea.edges - 50
```

### Influence

Constrainer was heavily influenced by [Cartography](https://github.com/robb/Cartography), which has a similar API but instead of exposing properties to construct constraints on the view directly it provides proxy objects inside a closure.

One main disadvantage of exposing properties with such common names directly on the view itself is potential namespace pollution (and collision), for example visible when looking at the `center` proxy in Constrainer, which (depending on the exact expression) might resolve to the `UIView.center` of type `CGPoint` provided by `UIKit`. If this happens it can be resolved by explicitly using the `UIView.anchors` proxy object.
