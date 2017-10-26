#import <SCRecorder.h>
#import <React/RCTComponent.h>

@interface RNSCRecorder:SCRecorder

@property (nonatomic, copy) RCTBubblingEventBlock onEnd;

@end

