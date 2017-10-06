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

class EdgesProxyTests: XCTestCase {
    
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
        view1.edges == view2.edges
        
        // then
        XCTAssertFalse(view1.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(view2.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testThatItCreatesConstraintsForAllEdges() {
        // when
        let constraints = view1.edges == view2.edges
        
        // then
        assertConstraints(constraints)
    }
    
    func testThatItCreatesConstraintsForAllEdgesWithConstant() {
        // when
        let constraints = view1.edges == view2.edges + 10
        
        // then
        assertConstraints(constraints, constant: 10)
    }
    
    func testThatItCreatesConstraintsForAllEdgesWithConstant_Negative() {
        // when
        let constraints = view1.edges == view2.edges - 10
        
        // then
        assertConstraints(constraints, constant: -10)
    }
    
    func testThatItCreatesConstraintsForAllEdges_Insets() {
        // when
        let constraints = view1.edges == view2.edges + UIEdgeInsets(top: 12, left: 16, bottom: -8, right: -42) ~ .defaultHigh
        
        // then
        let top = constraints.first { $0.firstAttribute == .top }
        let bottom = constraints.first { $0.firstAttribute == .bottom }
        let leading = constraints.first { $0.firstAttribute == .leading }
        let trailing = constraints.first { $0.firstAttribute == .trailing }
        
        XCTAssertEqual(top?.constant, 12)
        XCTAssertEqual(bottom?.constant, -8)
        XCTAssertEqual(leading?.constant, 16)
        XCTAssertEqual(trailing?.constant, -42)
        
        [top, bottom, leading, trailing].forEach { constraint in
            XCTAssertEqual(constraint?.multiplier, 1)
            XCTAssertEqual(constraint?.priority, .defaultHigh)
            XCTAssertEqual(constraint?.relation, .equal)
            XCTAssertEqual(constraint?.secondAttribute, constraint?.firstAttribute)
            XCTAssertEqual(constraint?.firstItem as? UIView, view1)
            XCTAssertEqual(constraint?.secondItem as? UIView, view2)
        }
    }
    
    func testThatItCreatesConstraintsForAllEdges_Priority() {
        // when
        let constraints = view1.edges == view2.edges ~ .defaultLow
        
        // then
        assertConstraints(constraints, priority: .defaultLow)
    }
    
    func testThatItCreatesConstraintsForAllEdgesWithConstant_Priority() {
        // when
        let constraints = view1.edges == view2.edges + 10 ~ 123.0
        
        // then
        assertConstraints(constraints, constant: 10, priority: UILayoutPriority(123))
    }
    
    func testThatItCreatesConstraintsForAllEdgesWithConstant_Negative_Priority() {
        // when
        let constraints = view1.edges == view2.edges - 10 ~ .fittingSizeLevel
        
        // then
        assertConstraints(constraints, constant: -10, priority: .fittingSizeLevel)
    }
    
    func testThatItCreatesConstraintsForAllEdges_LessThanOrEqual() {
        // when
        let constraints = view1.edges <= view2.edges
        
        // then
        assertConstraints(constraints, relation: .lessThanOrEqual)
    }
    
    func testThatItCreatesConstraintsForAllEdgesWithConstant_LessThanOrEqual() {
        // when
        let constraints = view1.edges <= view2.edges + 10
        
        // then
        assertConstraints(constraints, constant: 10, relation: .lessThanOrEqual)
    }
    
    func testThatItCreatesConstraintsForAllEdgesWithConstant_Negative_LessThanOrEqual() {
        // when
        let constraints = view1.edges <= view2.edges - 10
        
        // then
        assertConstraints(constraints, constant: -10, relation: .lessThanOrEqual)
    }
    
    func testThatItCreatesConstraintsForAllEdges_GreaterThanOrEqual() {
        // when
        let constraints = view1.edges >= view2.edges
        
        // then
        assertConstraints(constraints, relation: .greaterThanOrEqual)
    }
    
    func testThatItCreatesConstraintsForAllEdgesWithConstant_GreaterThanOrEqual() {
        // when
        let constraints = view1.edges >= view2.edges + 10
        
        // then
        assertConstraints(constraints, constant: 10, relation: .greaterThanOrEqual)
    }
    
    func testThatItCreatesConstraintsForAllEdgesWithConstant_Negative_GreaterThanOrEqual() {
        // when
        let constraints = view1.edges >= view2.edges - 10
        
        // then
        assertConstraints(constraints, constant: -10, relation: .greaterThanOrEqual)
    }
    
    private func assertConstraints(
        _ constraints: [NSLayoutConstraint],
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required,
        relation: NSLayoutRelation = .equal,
        file: StaticString = #file,
        line: UInt = #line
        ) {
        [NSLayoutAttribute.top, .bottom, .leading, .trailing].forEach { attribute in
            guard let constraint = constraints.first(where: { $0.firstAttribute == attribute }) else { return XCTFail(file: file, line: line) }
            XCTAssertEqual(constraint.constant, (attribute == .bottom || attribute == .trailing) ? constant : -constant, file: file, line: line)
            XCTAssertEqual(constraint.multiplier, 1, file: file, line: line)
            XCTAssertEqual(constraint.priority, priority, file: file, line: line)
            XCTAssertEqual(constraint.relation, relation, file: file, line: line)
            XCTAssertEqual(constraint.secondAttribute, attribute, file: file, line: line)
            XCTAssertEqual(constraint.firstItem as? UIView, view1, file: file, line: line)
            XCTAssertEqual(constraint.secondItem as? UIView, view2, file: file, line: line)
        }
    }

}
