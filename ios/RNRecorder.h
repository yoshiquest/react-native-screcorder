#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SCRecorder.h"
#import <React/RCTComponent.h>

@class RTCEventDispatcher;

@interface RNRecorder : UIView

@property (weak, nonatomic) id<SCRecorderDelegate> __nullable delegate;
@property (nonatomic, copy) RCTBubblingEventBlock onEnd;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

- (void)record;
- (void)capture:(void(^)(NSError *error, NSString *url))callback;
- (void)pause:(void(^)())completionHandler;
- (SCRecordSessionSegment*)lastSegment;
- (void)removeLastSegment;
- (void)removeAllSegments;
- (void)removeSegmentAtIndex:(NSInteger)index;
- (void)save:(void(^)(NSError *error, NSURL *outputUrl))callback;
- (NSString*)saveImage:(UIImage*)image;


@end
