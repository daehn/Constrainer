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
@testable import Constrainer

class AnchorProxyTests: XCTestCase {
    
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
    
    func testThatItSetsTranslatesAutoresizingMaskIntoConstraintsToFalse() {
        // given
        XCTAssert(view1.translatesAutoresizingMaskIntoConstraints)
        XCTAssert(view2.translatesAutoresizingMaskIntoConstraints)
        
        // when
        view1.margins.top == view2.safeArea.centerY
        
        // then
        XCTAssertFalse(view1.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(view2.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testThatItCreatesALeadingConstraint() {
        // when
        let constraint = view1.leading == view2.trailing
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintWithPositiveConstant() {
        // when
        let constraint = view2.leading == view1.leading + 17.5
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
        XCTAssertEqual(constraint.firstItem as? UIView, view2)
        XCTAssertEqual(constraint.secondItem as? UIView, view1)
        XCTAssertEqual(constraint.constant, 17.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesATrailingConstraintWithNegativeConstant() {
        // when
        let constraint = view1.trailing == view2.trailing - 17.5
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .trailing)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -17.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintAndSafeAreaWitPriority() {
        // when
        let constraint = view1.leading == view2.safeArea.trailing ~ .defaultLow
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UILayoutGuide, view2.safeAreaLayoutGuide)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .defaultLow)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeftConstraintWithConstantAndPriority() {
        // when
        let constraint = view1.left == view2.right + 17.5 ~ .defaultHigh
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .left)
        XCTAssertEqual(constraint.secondAttribute, .right)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 17.5)
        XCTAssertEqual(constraint.priority, .defaultHigh)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintWithConstantAndCustomPriority() {
        // when
        let constraint = view1.leading == view2.leading - 17.5 ~ 123
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -17.5)
        XCTAssertEqual(constraint.priority, UILayoutPriority(123))
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesContraintsBetweenMargins() {
        // when
        let constraint = view1.margins.top == view2.bottom - 4 ~ .fittingSizeLevel
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.secondAttribute, .bottom)
        XCTAssertEqual(constraint.firstItem as? UILayoutGuide, view1.layoutMarginsGuide)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -4)
        XCTAssertEqual(constraint.priority, .fittingSizeLevel)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraint_LessThanOrEqual() {
        // when
        let constraint = view1.leading <= view2.trailing
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintWithPositiveConstant_LessThanOrEqual() {
        // when
        let constraint = view2.leading <= view1.leading + 17.5
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
        XCTAssertEqual(constraint.firstItem as? UIView, view2)
        XCTAssertEqual(constraint.secondItem as? UIView, view1)
        XCTAssertEqual(constraint.constant, 17.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesATrailingConstraintWithNegativeConstant_LessThanOrEqual() {
        // when
        let constraint = view1.trailing <= view2.trailing - 17.5
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .trailing)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -17.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesAFirstBaselineConstraintAndSafeAreaWitPriorit_LessThanOrEqualy() {
        // when
        let constraint = view1.firstBaseline <= view2.safeArea.centerY ~ .defaultLow
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .firstBaseline)
        XCTAssertEqual(constraint.secondAttribute, .centerY)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UILayoutGuide, view2.safeAreaLayoutGuide)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .defaultLow)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintWithConstantAndPriority_LessThanOrEqual() {
        // when
        let constraint = view1.leading <= view2.trailing + 17.5 ~ .defaultHigh
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 17.5)
        XCTAssertEqual(constraint.priority, .defaultHigh)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintWithConstantAndCustomPriority_LessThanOrEqual() {
        // when
        let constraint = view1.leading <= view2.leading - 17.5 ~ 123
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -17.5)
        XCTAssertEqual(constraint.priority, UILayoutPriority(123))
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesContraintsBetweenMargins_LessThanOrEqual() {
        // when
        let constraint = view1.margins.top <= view2.bottom - 4 ~ .fittingSizeLevel
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.secondAttribute, .bottom)
        XCTAssertEqual(constraint.firstItem as? UILayoutGuide, view1.layoutMarginsGuide)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -4)
        XCTAssertEqual(constraint.priority, .fittingSizeLevel)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALastBaselineConstraint_GreaterThanOrEqual() {
        // when
        let constraint = view1.lastBaseline >= view2.lastBaseline
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .lastBaseline)
        XCTAssertEqual(constraint.secondAttribute, .lastBaseline)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintWithPositiveConstant_GreaterThanOrEqual() {
        // when
        let constraint = view2.leading >= view1.leading + 17.5
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
        XCTAssertEqual(constraint.firstItem as? UIView, view2)
        XCTAssertEqual(constraint.secondItem as? UIView, view1)
        XCTAssertEqual(constraint.constant, 17.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesATrailingConstraintWithNegativeConstant_GreaterThanOrEqual() {
        // when
        let constraint = view1.trailing >= view2.trailing - 17.5
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .trailing)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -17.5)
        XCTAssertEqual(constraint.priority, .required)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintAndSafeAreaWitPriorit_GreaterThanOrEqualy() {
        // when
        let constraint = view1.leading >= view2.safeArea.trailing ~ .defaultLow
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UILayoutGuide, view2.safeAreaLayoutGuide)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, .defaultLow)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintWithConstantAndPriority_GreaterThanOrEqual() {
        // when
        let constraint = view1.leading >= view2.trailing + 17.5 ~ .defaultHigh
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, 17.5)
        XCTAssertEqual(constraint.priority, .defaultHigh)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesALeadingConstraintWithConstantAndCustomPriority_GreaterThanOrEqual() {
        // when
        let constraint = view1.leading >= view2.leading - 17.5 ~ 123
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .leading)
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -17.5)
        XCTAssertEqual(constraint.priority, UILayoutPriority(123))
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
    func testThatItCreatesContraintsBetweenMargins_GreaterThanOrEqual() {
        // when
        let constraint = view1.margins.top >= view2.bottom - 4 ~ .fittingSizeLevel
        
        // then
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.secondAttribute, .bottom)
        XCTAssertEqual(constraint.firstItem as? UILayoutGuide, view1.layoutMarginsGuide)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
        XCTAssertEqual(constraint.constant, -4)
        XCTAssertEqual(constraint.priority, .fittingSizeLevel)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssert(constraint.isActive)
    }
    
}
