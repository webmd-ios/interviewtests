//
//  AutomationTestUtilities.swift
//  AutomationTestApp
//
//  Created by McHargue, Brandon on 4/6/18.
//  Copyright © 2018 WebMD. All rights reserved.
//

import UIKit

class ParsedData{
    var intValue : Int?;
    var stringValue: String?;
}

enum ParseError: Error{
    case invalidJSON;
    case invalidType(description: String);
    case customError(code: Int, description: String);
}

class AutomationTestUtilities: NSObject {

    typealias asynchronousCompletionHandler = (_ output:String)->();
    public class func asynchronousMethod(delay:TimeInterval, input:String, completionHandler:@escaping asynchronousCompletionHandler){
        DispatchQueue.global(qos: .background).async {
            Thread.sleep(forTimeInterval: delay);
            DispatchQueue.main.async {
                completionHandler(input+input);
            }
        }
    }
    
    public class func parseJSON(jsonData: Data?) throws -> ParsedData?{
        guard let jsonData = jsonData else{
            throw ParseError.invalidJSON;
        }
        
        let dataString = String(data:jsonData, encoding: String.Encoding.utf8) ?? "<nil>";
        print("JSON: \(dataString)");
        
        let jsonObject: Any?;
        do{
            jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []);
        }catch{
            jsonObject = nil;
        }
        
        if(jsonObject == nil){
            throw ParseError.invalidJSON;
        }
        
        guard let dict = jsonObject as? [String: Any] else{
            throw ParseError.invalidJSON;
        }
        
        let output = ParsedData();
        
        if let intValue = dict["intValue"] {
            if let int = intValue as? Int{
                output.intValue = int;
            }else{
                throw ParseError.invalidType(description: "intValue has invalid type");
            }
        }
        
        if let stringValue = dict["stringValue"] {
            if let string = stringValue as? String{
                output.stringValue = string;
            }else{
                throw ParseError.invalidType(description: "stringValue has invalid type");
            }
        }
        
        if let dictValue = dict["error"]{
            if let errorDict = dictValue as? [String: Any]{
                if  let errorCode = errorDict["code"] as? Int,
                    let errorDesc = errorDict["description"] as? String{
                    throw ParseError.customError(code: errorCode, description: errorDesc)
                }else{
                    throw ParseError.invalidType(description: "error is missing valid code or description")
                }
            }else{
                throw ParseError.invalidType(description: "error has invalid type")
            }
        }
        
        return output;
    }
}
