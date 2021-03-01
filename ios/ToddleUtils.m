#import "ToddleUtils.h"


@implementation ToddleUtils

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
	callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

RCT_EXPORT_METHOD(isCallConnected:(RCTResponseSenderBlock)callback)
{
    NSString* result = @"disconnected";
    if (@available(iOS 10.0, *)) {
        CXCallObserver *callObserver = [[CXCallObserver alloc] init];
        NSArray<CXCall *> *calls = [callObserver calls];
        // iterate over calls
        for (CXCall *call in calls) {            
            if(![call hasEnded]){
                result = @"connected";
            }
        }
    }
    
    callback(@[result]);
}

@end
