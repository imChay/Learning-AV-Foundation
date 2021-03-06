//
//  MIT License
//
//  Copyright (c) 2014 Bob McCune http://bobmccune.com/
//  Copyright (c) 2014 TapHarmonic, LLC http://tapharmonic.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "THCameraController.h"
#import <AVFoundation/AVFoundation.h>

@interface THCameraController () <AVCaptureMetadataOutputObjectsDelegate>   // 1

@property (strong, nonatomic) AVCaptureMetadataOutput *metadataOutput;

@end

@implementation THCameraController

- (BOOL)setupSessionOutputs:(NSError **)error {

    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];           // 2

    if ([self.captureSession canAddOutput:self.metadataOutput]) {
        [self.captureSession addOutput:self.metadataOutput];

        NSArray *metadataObjectTypes = @[AVMetadataObjectTypeFace];         // 3
        self.metadataOutput.metadataObjectTypes = metadataObjectTypes;

        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        [self.metadataOutput setMetadataObjectsDelegate:self                // 4
                                                  queue:mainQueue];

        return YES;

    } else {                                                                // 5
        if (error) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:
                                           @"Failed to still image output."};
            *error = [NSError errorWithDomain:THCameraErrorDomain
                                         code:THCameraErrorFailedToAddOutput
                                     userInfo:userInfo];
        }
        return NO;
    }
}

#pragma mark - THFaceDetectionDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
                                                                 fromConnection:(AVCaptureConnection *)connection {

    for (AVMetadataFaceObject *face in metadataObjects) {                   // 2
//        NSLog(@"Face detected with ID: %li", (long)face.faceID);
//        NSLog(@"Face bounds: %@", NSStringFromCGRect(face.bounds));
        
//        Core Image只是简单的图像识别， 并不能对流中的人脸进行识别
//        NSLog(@"左眼是否闭合:%@",[face valueForKeyPath:@"_internal.hasLeftEyeClosedConfidence"]);
//        NSLog(@"左眼是否闭合可信度:%@",[face valueForKeyPath:@"_internal.leftEyeClosedConfidence"]);
//        NSLog(@"右眼是否闭合:%@",[face valueForKeyPath:@"_internal.hasRightEyeClosedConfidence"]);
//        NSLog(@"右眼是否闭合可信度:%@",[face valueForKeyPath:@"_internal.rightEyeClosedConfidence"]);
//        NSLog(@"是否微笑:%@",[face valueForKeyPath:@"_internal.hasSmileConfidence"]);
//        NSLog(@"是否微笑可信度:%@",[face valueForKeyPath:@"_internal.smileConfidence"]);
//        NSLog(@"左眼bounds:%@",[face valueForKeyPath:@"_internal.hasLeftEyeBounds"]);
//        NSLog(@"右眼bounds:%@",[face valueForKeyPath:@"_internal.hasLeftEyeBounds"]);
    }

    [self.faceDetectionDelegate didDetectFaces:metadataObjects];            // 3
    
}

@end

