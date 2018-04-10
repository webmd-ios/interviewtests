//
//  AutomationTestAppTests_Complete.swift
//  AutomationTestAppTests
//
//  Created by McHargue, Brandon on 4/10/18.
//  Copyright © 2018 WebMD. All rights reserved.
//

import XCTest
@testable import AutomationTestApp

class AutomationTestAppTests_Complete: XCTestCase {
    
    func testParsingUtility(){
        do{
            let _ = try AutomationTestUtilities.parseJSON(jsonData: nil);
            XCTFail("Parsing nil data didn't throw error");
        }catch{
            
        }
        
        do{
            let emptyData = "".data(using: String.Encoding.utf8);
            let _ = try AutomationTestUtilities.parseJSON(jsonData: emptyData);
            XCTFail("Parsing empty data didn't throw error");
        }catch{
            
        }
        
        do{
            let nonJSONData = "{".data(using: String.Encoding.utf8);
            let _ = try AutomationTestUtilities.parseJSON(jsonData: nonJSONData);
            XCTFail("Parsing malformed json data didn't throw error");
        }catch{
            
        }
        
        do{
            let goodDataString =
            """
{
    "intValue": 1,
    "stringValue": "string"
}
"""
            let obj = try AutomationTestUtilities.parseJSON(jsonData: goodDataString.data(using: String.Encoding.utf8));
            XCTAssertNotNil("No object returned from parse");
            
            if let intValue = obj?.intValue as Int?{
                XCTAssert(intValue == 1, "Incorrect intValue found");
            } else {
                XCTFail("No intValue found");
            }
            
            if let stringValue = obj?.stringValue as String?{
                XCTAssert(stringValue == "string", "Incorrect stringValue found");
            } else {
                XCTFail("No stringValue found");
            }
        }catch{
            XCTFail("Error thrown when parsing good json data");
        }
        
        do{
            let badTypesString =
            """
{
    "intValue": "string",
    "stringValue": 1
}
"""
            let _ = try AutomationTestUtilities.parseJSON(jsonData: badTypesString.data(using: String.Encoding.utf8));
            XCTFail("Parsing json with wrong types didn't throw error");
        }catch ParseError.invalidType{
            
        }catch{
            XCTFail("Parsing json with wrong types threw incorrect error");
        }
        
        do{
            let errorString =
            """
{
    "error": {
        "code":100,
        "description":"Some Error"
    }
}
"""
            let _ = try AutomationTestUtilities.parseJSON(jsonData: errorString.data(using: String.Encoding.utf8));
            XCTFail("Parsing json with error dictionary didn't throw error");
        }catch ParseError.customError(let code, let description){
            XCTAssert(code == 100, "Incorrect error code");
            XCTAssert(description == "Some Error", "Incorrect description");
        }catch{
            XCTFail("Parsing json with error dictionary threw incorrect error");
        }
    }
    
    func testAsynchronousUtility(){
        let expectation = self.expectation(description: "Async Expectation");
        AutomationTestUtilities.asynchronousMethod(delay: 2, input: "Test", completionHandler: {output in
            if(output == "TestTest"){
                expectation.fulfill();
            }else{
                XCTFail("Output did not match expected result");
            }
        });
        self.waitForExpectations(timeout: 5, handler: nil);
    }
    
}
