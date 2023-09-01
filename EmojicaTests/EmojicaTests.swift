//
//  ------------------------------------------------------------------------
//
//  Copyright 2017 Dan Lindholm
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  ------------------------------------------------------------------------
//
//  EmojicaTests.swift
//

import XCTest
import Emojica

class EmojicaTests: XCTestCase {
    
    let emojica = Emojica()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testConvert() {
        XCTContext.runActivity(named: "Half-width characters") { _ in
            let inputText: String = "Sample text 😎"
            let converted: NSAttributedString = emojica.convert(string: inputText)
            XCTAssertEqual(inputText, converted.string)
        }
        XCTContext.runActivity(named: "Hiragana") { _ in
            let inputText: String = "さんぷる　てきすと 😎"
            let converted: NSAttributedString = emojica.convert(string: inputText)
            XCTAssertEqual(inputText, converted.string)
        }
        XCTContext.runActivity(named: "Katakana") { _ in
            let inputText: String = "サンプル　テキスト 😎"
            let converted: NSAttributedString = emojica.convert(string: inputText)
            XCTAssertEqual(inputText, converted.string)
        }
        XCTContext.runActivity(named: "Harf-wide Katakana") { _ in
            let inputText: String = "ｻﾝﾌﾟﾙ ﾃｷｽﾄ 😎"
            let converted: NSAttributedString = emojica.convert(string: inputText)
            XCTAssertEqual(inputText, converted.string)
        }
        XCTContext.runActivity(named: "Kanji") { _ in
            let inputText: String = "例文 😎"
            let converted: NSAttributedString = emojica.convert(string: inputText)
            XCTAssertEqual(inputText, converted.string)
        }
        XCTContext.runActivity(named: "concatenation") { _ in
            let inputText: String = "ǟæ 😎"
            let converted: NSAttributedString = emojica.convert(string: inputText)
            XCTAssertEqual(inputText, converted.string)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
