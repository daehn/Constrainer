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

class CenterProxyTests: XCTestCase {
    
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
        view1.center == view2.center ~ .defaultHigh
        
        // then
        XCTAssertFalse(view1.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(view2.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testThatItCanConstaintACenterToAnotherCenter() {
        // given
        let constraints = view1.anchors.center == view2.center
        
        // then
        assertConstraints(constraints)
    }
    
    func testThatItCanConstaintACenterToAnotherCenter_Priority() {
        // given
        let constraints = view1.anchors.center == view2.center ~ 600
        
        // then
        assertConstraints(constraints, priority: UILayoutPriority(600))
    }
    
    func testThatItCanConstaintACenterToAnotherCenter_LessThanOrEqual() {
        // given
        let constraints = view1.anchors.center <= view2.center
        
        // then
        assertConstraints(constraints, relation: .lessThanOrEqual)
    }
    
    func testThatItCanConstaintACenterToAnotherCenter_GreaterThanOrEqual() {
        // given
        let constraints = view1.anchors.center >= view2.center ~ .fittingSizeLevel
        
        // then
        assertConstraints(constraints, priority: .fittingSizeLevel, relation: .greaterThanOrEqual)
    }
    
    func testThatItCanConstaintACenterToAnotherCenter_Offsett() {
        // given
        let constraints = view1.anchors.center >= view2.center + CGPoint(x: 42, y: 42)
        
        // then
        assertConstraints(constraints, constant: 42, relation: .greaterThanOrEqual)
    }
    
    func testThatItCanConstaintACenterToAnotherCenter_NegativeOffsett() {
        // given
        let constraints = view1.anchors.center >= view2.center - CGPoint(x: 42, y: 42)
        
        // then
        assertConstraints(constraints, constant: -42, relation: .greaterThanOrEqual)
    }
    
    private func assertConstraints(
        _ constraints: [NSLayoutConstraint],
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required,
        relation: NSLayoutRelation = .equal,
        file: StaticString = #file,
        line: UInt = #line
        ) {
        [NSLayoutAttribute.centerY, .centerX].forEach { attribute in
            guard let constraint = constraints.first(where: { $0.firstAttribute == attribute }) else { return XCTFail(file: file, line: line) }
            XCTAssertEqual(constraint.constant, constant, file: file, line: line)
            XCTAssertEqual(constraint.multiplier, 1, file: file, line: line)
            XCTAssertEqual(constraint.priority, priority, file: file, line: line)
            XCTAssertEqual(constraint.relation, relation, file: file, line: line)
            XCTAssertEqual(constraint.secondAttribute, attribute, file: file, line: line)
            XCTAssertEqual(constraint.firstItem as? UIView, view1, file: file, line: line)
            XCTAssertEqual(constraint.secondItem as? UIView, view2, file: file, line: line)
        }
    }
    
}
