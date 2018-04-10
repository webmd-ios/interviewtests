//
//  AutomationTestApUITests_Complete.swift
//  AutomationTestAppUITests
//
//  Created by McHargue, Brandon on 4/10/18.
//  Copyright © 2018 WebMD. All rights reserved.
//

import XCTest

class AutomationTestApUITests_Complete: XCTestCase {
    
    var app : XCUIApplication!;
    
    override func setUp() {
        super.setUp();
        
        app = XCUIApplication();
    }
    
    func testImplementTestCase(){
        
    }
    
    func testAcceptanceCriteria(){
        app.launch();
        
        app.tabBars.buttons["Second"].tap();
        
        let label = app.staticTexts["SecondView_Label"];
        let textfield = app.textFields["SecondView_TextField"];
        let segment = app.segmentedControls.firstMatch;
        
        XCTAssert(label.exists);
        XCTAssert(textfield.exists);
        
        //Check initial label state
        XCTAssert(label.label == "\'\'");
        
        textfield.tap();
        textfield.typeText("text");
        XCTAssert(label.label == "'text'");
        
        segment.buttons.element(boundBy: 1).tap();
        XCTAssert(label.label == "'txet'");
        
        textfield.tap();
        textfield.typeText("other text");
        XCTAssert(label.label == "txet rehot");
        
        Thread.sleep(forTimeInterval: 5);
    }
    
}
