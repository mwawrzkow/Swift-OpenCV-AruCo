//
//  OpenCVWrapper.h
//  postHTTPTest
//
//  Created by Marcin Wawrzków on 09/06/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject
+(NSString*) getOpenCVVersion;
+(float*) findArucoCode:CMSampleBufferRef;
@end

NS_ASSUME_NONNULL_END
