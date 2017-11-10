#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SCRecorder.h"
#import <React/RCTComponent.h>

@interface RNRecorder : UIView <SCRecorderDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onEnd;

- (void)record;
- (void)capture:(void(^)(NSError *error, NSString *url))callback;
- (void)pause:(void(^)())completionHandler;
- (SCRecordSessionSegment*)lastSegment;
- (void)removeLastSegment;
- (void)removeAllSegments;
- (void)removeSegmentAtIndex:(NSInteger)index;
- (void)save:(void(^)(NSError *error, NSURL *outputUrl))callback;
- (void)saveWithAudio:(NSString*)audioPath saveCallback:(void(^)(NSError *error, NSURL *outputUrl))callback;
- (NSString*)saveImage:(UIImage*)image;


@end
