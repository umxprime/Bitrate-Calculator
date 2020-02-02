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
        let initialVideoFileProperties = VideoFileProperties(
            video: VideoFileProperties.VideoProperties(),
            audio: VideoFileProperties.AudioProperties(),
            duration: 100 * 60,
            fileSizeKB: 0
        )
        let calculator:VideoFilePropertiesCalculator = DefaultVideoFilePropertiesCalculator(initialVideoFileProperties)
        
        let expectedVideoProperties = VideoFileProperties.VideoProperties(
            bitrateKbps: 1200
        )
        
        let result = calculator.change(
            videoProperties: expectedVideoProperties
        )
        XCTAssertEqual(result.video, expectedVideoProperties)
    }
    
    func testVideoBitrateChangeTo1300() {
         let initialVideoFileProperties = VideoFileProperties(
            video: VideoFileProperties.VideoProperties(),
            audio: VideoFileProperties.AudioProperties(),
            duration: 100 * 60,
            fileSizeKB: 0
         )
         let calculator:VideoFilePropertiesCalculator = DefaultVideoFilePropertiesCalculator(initialVideoFileProperties)

         let expectedVideoProperties = VideoFileProperties.VideoProperties(
            bitrateKbps: 1300
         )

         let result = calculator.change(
            videoProperties: expectedVideoProperties
         )
         XCTAssertEqual(result.video, expectedVideoProperties)
    }
    
    func testVideoPropertiesChangeAffectFileSize() {
        let initialVideoFileProperties = VideoFileProperties(
           video: VideoFileProperties.VideoProperties(),
           audio: VideoFileProperties.AudioProperties(),
           duration: 100 * 60,
           fileSizeKB: 0
        )
        let expectedVideoFileProperties = VideoFileProperties(
           video: VideoFileProperties.VideoProperties(
               bitrateKbps: 1300
           ),
           audio: VideoFileProperties.AudioProperties(),
           duration: 100 * 60,
           fileSizeKB: 975000
        )
        
        let calculator:VideoFilePropertiesCalculator = DefaultVideoFilePropertiesCalculator(initialVideoFileProperties)
        let result = calculator.change(videoProperties: expectedVideoFileProperties.video)
        XCTAssertEqual(result, expectedVideoFileProperties)
    }
    
    func testAudioPropertiesChangeAffectFileSize() {
        let initialVideoFileProperties = VideoFileProperties(
           video: VideoFileProperties.VideoProperties(),
           audio: VideoFileProperties.AudioProperties(),
           duration: 100 * 60,
           fileSizeKB: 0
        )
        let expectedVideoFileProperties = VideoFileProperties(
           video: VideoFileProperties.VideoProperties(),
           audio: VideoFileProperties.AudioProperties(
               bitrateKbps: 160,
               tracksCount: 2
           ),
           duration: 100 * 60,
           fileSizeKB: 240000
        )
        
        let calculator:VideoFilePropertiesCalculator = DefaultVideoFilePropertiesCalculator(initialVideoFileProperties)
        let result = calculator.change(audioProperties: expectedVideoFileProperties.audio)
        XCTAssertEqual(result, expectedVideoFileProperties)
    }
    
    func testVideoPropertiesChangeWithAudioPropertiesSetAffectFileSize() {
        let initialVideoFileProperties = VideoFileProperties(
            video: VideoFileProperties.VideoProperties(),
            audio: VideoFileProperties.AudioProperties(
                bitrateKbps: 160,
                tracksCount: 2),
            duration: 100 * 60,
            fileSizeKB: 240000
        )
        let expectedVideoFileProperties = VideoFileProperties(
            video: VideoFileProperties.VideoProperties(
                bitrateKbps: 1300
            ),
            audio: VideoFileProperties.AudioProperties(
                bitrateKbps: 160,
            tracksCount: 2),
            duration: 100 * 60,
            fileSizeKB: 1215000
        )
        
        let calculator:VideoFilePropertiesCalculator = DefaultVideoFilePropertiesCalculator(initialVideoFileProperties)
        let result = calculator.change(videoProperties: expectedVideoFileProperties.video)
        XCTAssertEqual(result, expectedVideoFileProperties)
    }

}
