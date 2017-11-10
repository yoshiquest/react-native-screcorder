#ifndef RNRecorder_RCTViewManager_h
#define RNRecorder_RCTViewManager_h

#import "RCTViewManager.h"

@interface RNRecorderManager : RCTViewManager
@property (nonatomic,assign) UIBackgroundTaskIdentifier __block backgroundSavingID;

@end


#endif
