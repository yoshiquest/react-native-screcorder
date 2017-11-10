#import "RNRecorderManager.h"
#import "RNRecorder.h"

#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import "UIView+React.h"

@implementation RNRecorderManager
{
    RNRecorder *_recorderView;
}

RCT_EXPORT_MODULE();
RCT_EXPORT_VIEW_PROPERTY(config, NSDictionary);
RCT_EXPORT_VIEW_PROPERTY(device, NSString);
RCT_EXPORT_VIEW_PROPERTY(flashMode, NSInteger);
RCT_EXPORT_VIEW_PROPERTY(onEnd, RCTBubblingEventBlock);

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (UIView *)view
{
    // Alloc UI element
    if (_recorderView == nil) {
        _recorderView = [[RNRecorder alloc] init];
    }
    return _recorderView;
}

RCT_EXPORT_METHOD(record)
{
    [_recorderView record];
}

RCT_EXPORT_METHOD(capture:(RCTResponseSenderBlock)callback)
{
    [_recorderView capture:^(NSError *error, NSString *url) {
        if (error == nil && url != nil) {
            callback(@[[NSNull null], url]);
        } else {
            callback(@[[error localizedDescription], [NSNull null]]);
        }
    }];
}

RCT_EXPORT_METHOD(pause:(RCTResponseSenderBlock)callback)
{
    [_recorderView pause:^{

        SCRecordSessionSegment* ls = [_recorderView lastSegment];

        if (ls != nil) {
            NSString *url = [ls.url relativeString];
            float duration = CMTimeGetSeconds(ls.duration);

            NSDictionary *props = @{@"url": url, @"duration":@(duration)};
            callback(@[props]);
        }

    }];
}

RCT_EXPORT_METHOD(removeLastSegment)
{
    [_recorderView removeLastSegment];
}

RCT_EXPORT_METHOD(removeAllSegments)
{
    [_recorderView removeAllSegments];
}

RCT_EXPORT_METHOD(removeSegmentAtIndex:(NSInteger)index)
{
    [_recorderView removeSegmentAtIndex:index];
}

RCT_EXPORT_METHOD(save:(RCTResponseSenderBlock)callback)
{
    UIApplication *app = [UIApplication sharedApplication];
    _backgroundSavingID = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:_backgroundSavingID];
        _backgroundSavingID = UIBackgroundTaskInvalid;
        callback(@[@"Ran out of time loading video in the background.", [NSNull null]]);
    }];
    [_recorderView save:^(NSError *error, NSURL *url) {
        if (error == nil && url != nil) {
            [app endBackgroundTask:_backgroundSavingID];
            callback(@[[NSNull null], [url relativePath]]);
        } else {
            [app endBackgroundTask:_backgroundSavingID];
            callback(@[[error localizedDescription], [NSNull null]]);
        }
    }];
}

RCT_EXPORT_METHOD(saveWithAudio:(NSString*)audioPath saveCallback:(RCTResponseSenderBlock)callback)
{
    UIApplication *app = [UIApplication sharedApplication];
    _backgroundSavingID = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:_backgroundSavingID];
        _backgroundSavingID = UIBackgroundTaskInvalid;
        callback(@[@"Ran out of time loading video in the background.", [NSNull null]]);
    }];
    [_recorderView saveWithAudio:audioPath saveCallback:^(NSError *error, NSURL *url) {
        if (error == nil && url != nil) {
            [app endBackgroundTask:_backgroundSavingID];
            callback(@[[NSNull null], [url relativePath]]);
        } else {
            [app endBackgroundTask:_backgroundSavingID];
            callback(@[[error localizedDescription], [NSNull null]]);
        }
    }];
}

@end
