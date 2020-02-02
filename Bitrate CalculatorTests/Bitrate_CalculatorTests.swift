//
//  Bitrate_CalculatorTests.swift
//  Bitrate CalculatorTests
//
//  MIT License
//
//  Copyright (c) 2020 Maxime CHAPELET
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
@testable import Bitrate_Calculator

class Bitrate_CalculatorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVideoBitrateChangeTo1200() {
        let calculator:VideoPropertiesCalculator = DefaultVideoPropertiesCalculator()
        let initialVideoProperties = VideoProperties(
            videoBitrateKbps: 0,
            audioBitrateKbps: 0,
            audioChannelsCount: 0,
            duration: 100 * 60,
            fileSizeKB: 0)
        let result = calculator.solve(videoBitrate:1200, from:initialVideoProperties)
        XCTAssertEqual(result.videoBitrateKbps, 1200)
    }
    
    func testVideoBitrateChangeTo1300() {
        let calculator:VideoPropertiesCalculator = DefaultVideoPropertiesCalculator()
        let initialVideoProperties = VideoProperties(
            videoBitrateKbps: 0,
            audioBitrateKbps: 0,
            audioChannelsCount: 0,
            duration: 100 * 60,
            fileSizeKB: 0)
        let result = calculator.solve(videoBitrate:1300, from:initialVideoProperties)
        XCTAssertEqual(result.videoBitrateKbps, 1300)
    }
    
    func testVideoPropertiesEquality() {
        let calculator:VideoPropertiesCalculator = DefaultVideoPropertiesCalculator()
        let initialVideoProperties = VideoProperties(
            videoBitrateKbps: 0,
            audioBitrateKbps: 0,
            audioChannelsCount: 0,
            duration: 100 * 60,
            fileSizeKB: 0)
        let resultingVideoProperties = VideoProperties(
            videoBitrateKbps: 1300,
            audioBitrateKbps: 0,
            audioChannelsCount: 0,
            duration: 100 * 60,
            fileSizeKB: 975000)
        let result = calculator.solve(videoBitrate:resultingVideoProperties.videoBitrateKbps, from:initialVideoProperties)
        XCTAssertEqual(result, resultingVideoProperties)
    }

}
