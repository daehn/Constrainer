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

import XCTest
import Constrainer

class DimensionProxyTests: XCTestCase {
    
    var container: UIView!, view1: UIView!, view2: UIView!
    
    override func setUp() {
        super.setUp()
        (container, view1, view2) = (UIView(), UIView(), UIView())
        [view1, view2].forEach(container.addSubview)
    }
    
    override func tearDown() {
        (container, view1, view2) = (nil, nil, nil)
        super.tearDown()
    }
    
    func testThatItCreatesAWidthConstraint() {
        // when
        let constraint = view1.width == 1337
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertNil(constraint.secondItem)
        XCTAssertEqual(constraint.constant, 1337)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraint() {
        // when
        let constraint = view1.height == 42
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertNil(constraint.secondItem)
        XCTAssertEqual(constraint.constant, 42)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraint_Priority() {
        // when
        let constraint = view1.height == 42 ~ .fittingSizeLevel
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertNil(constraint.secondItem)
        XCTAssertEqual(constraint.constant, 42)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, .fittingSizeLevel)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraint_CustomPriority() {
        // when
        let constraint = view1.height == view2.width ~ 42.0
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, UILayoutPriority(42))
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraint_LessThanOrEqual() {
        // when
        let constraint = view1.height <= 42
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertNil(constraint.secondItem)
        XCTAssertEqual(constraint.constant, 42)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraint_GreaterThanOrEqual() {
        // when
        let constraint = view1.width >= 1337
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertNil(constraint.secondItem)
        XCTAssertEqual(constraint.constant, 1337)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraint_Priority_LessThanOrEqual() {
        // when
        let constraint = view1.height <= 42 ~ .fittingSizeLevel
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertNil(constraint.secondItem)
        XCTAssertEqual(constraint.constant, 42)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, .fittingSizeLevel)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraint_Priority_GreaterThanOrEqual() {
        // when
        let constraint = view1.height >= 1337 ~ 42.0
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertNil(constraint.secondItem)
        XCTAssertEqual(constraint.constant, 1337)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, UILayoutPriority(42))
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAWidthConstraintWithMultiplier() {
        // when
        let constraint = view1.width == view2.width * 2
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.multiplier, 2)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraintWithMultiplier() {
        // when
        let constraint = view1.height == view2.height * 2
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.multiplier, 2)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAWidthConstraintWithConstant() {
        // when
        let constraint = view1.width == view2.width + 10
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 10)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraintWithConstant() {
        // when
        let constraint = view1.height == view2.height - 42
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -42)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAWidthConstraintWithConstantAndMultiplier() {
        // when
        let constraint = view1.width == view2.width / 2 + 10
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 10)
        XCTAssertEqual(constraint.multiplier, 0.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraintWithConstantAndMultiplier() {
        // when
        let constraint = view1.height == view2.width * 2 - 42
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -42)
        XCTAssertEqual(constraint.multiplier, 2)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAWidthConstraintWithConstantAndMultiplier_LessThanOrEqual() {
        // when
        let constraint = view1.width <= view2.width / 2 + 10
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 10)
        XCTAssertEqual(constraint.multiplier, 0.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraintWithConstantAndMultiplier_LessThanOrEqual() {
        // when
        let constraint = view1.height <= view2.width * 2 - 42
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -42)
        XCTAssertEqual(constraint.multiplier, 2)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAWidthConstraintWithConstantAndMultiplier_GreaterThanOrEqual() {
        // when
        let constraint = view1.width >= view2.width / 2 + 10
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 10)
        XCTAssertEqual(constraint.multiplier, 0.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAHeightConstraintWithConstantAndMultiplier_GreaterThanOrEqual() {
        // when
        let constraint = view1.height >= view2.width * 2 - 42
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -42)
        XCTAssertEqual(constraint.multiplier, 2)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }

}
