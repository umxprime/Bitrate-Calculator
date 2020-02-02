//
//  DefaultVideoFilePropertiesCalculator.swift
//  Bitrate Calculator
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

import Foundation

public class DefaultVideoFilePropertiesCalculator {
    
    public private(set) var videoFileProperties: VideoFileProperties
    
    init(_ videoFileProperties: VideoFileProperties) {
        self.videoFileProperties = videoFileProperties
    }
    
    private func videoTrackSizeKB() -> UInt64 {
        return videoFileProperties.video.bitrateKbps * UInt64(videoFileProperties.duration) / 8
    }
    
    private func audioTracksSizeKB() -> UInt64 {
        return videoFileProperties.audio.bitrateKbps * UInt64(videoFileProperties.audio.tracksCount) * UInt64(videoFileProperties.duration) / 8
    }
}

extension DefaultVideoFilePropertiesCalculator: VideoFilePropertiesCalculator {
    
    public func change(audioProperties: VideoFileProperties.AudioProperties) -> VideoFileProperties {
        videoFileProperties.audio = audioProperties
        videoFileProperties.fileSizeKB = videoTrackSizeKB() + audioTracksSizeKB()
        return videoFileProperties
    }
    
    public func change(videoProperties: VideoFileProperties.VideoProperties) -> VideoFileProperties {
        videoFileProperties.video = videoProperties
        videoFileProperties.fileSizeKB = videoTrackSizeKB() + audioTracksSizeKB()
        return videoFileProperties
    }
}
