//
//  OpenCVWrapper.m
//  postHTTPTest
//
//  Created by Marcin Wawrzków on 09/06/2021.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv2.h>
#import <opencv2/aruco.hpp> 
@implementation OpenCVWrapper
+(NSString*) getOpenCVVersion {
    return [NSString stringWithFormat:@"OpenCV Version: %s", CV_VERSION];
}
+(float*) findArucoCode: (CMSampleBufferRef)sampleBuffer
{
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    OSType format = CVPixelBufferGetPixelFormatType(pixelBuffer);

    // Set the following dict on AVCaptureVideoDataOutput's videoSettings to get YUV output
    // @{ kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_420YpCbCr8BiPlanarFullRange }

    NSAssert(format == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange, @"Only YUV is supported");

    // The first plane / channel (at index 0) is the grayscale plane
    // See more infomation about the YUV format
    // http://en.wikipedia.org/wiki/YUV
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    void *baseaddress = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);

    CGFloat width = CVPixelBufferGetWidth(pixelBuffer);
    CGFloat height = CVPixelBufferGetHeight(pixelBuffer);

    cv::Mat mat(height, width, CV_8UC1, baseaddress, 0);

    // Use the mat here

    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    return nullptr;
}
@end
 
