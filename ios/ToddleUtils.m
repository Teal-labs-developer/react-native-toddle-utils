#import "ToddleUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <CallKit/CallKit.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>


@implementation ToddleUtils

RCT_EXPORT_MODULE()

static RCTEventEmitter* staticEventEmitter = nil;
static CXCallObserver* callObserver = nil;

bool cannotUseCallKit;

- (instancetype)init
{
    self = [super init];
    if (self) {
        staticEventEmitter = self;
        NSLocale *userLocale = [NSLocale currentLocale];
        if ([userLocale.countryCode containsString: @"CN"] || [userLocale.countryCode containsString: @"CHN"]) {
            NSLog(@"currentLocale is China so we cannot use CallKit.");
            cannotUseCallKit = YES;
        }
        else{
            cannotUseCallKit = NO;
            if (@available(iOS 10.0, *)) {
                callObserver = [[CXCallObserver alloc] init];
                [callObserver setDelegate:self queue:nil];
            }
        }
    }
    return self;
}

- (void)_sendEventWithName:(NSString *)eventName body:(id)body {
  if (staticEventEmitter == nil)
    return;
  [staticEventEmitter sendEventWithName:eventName body:body];
}

- (void)callObserver:(CXCallObserver *)callObserver callChanged:(CXCall *)call{
    NSLog(@"########## call state changed hasEnded: %d, %d ", call.hasEnded, call.hasConnected);
    NSString* result = @"disconnected";
    if(![call hasEnded] && [call hasConnected]){
        result = @"connected";
    }
    
    [self _sendEventWithName:@"RNToddleUtils-callStatusChanged" body: @{ @"status":result}];
}

- (NSArray<NSString *> *)supportedEvents{
    return @[
        @"RNToddleUtils-callStatusChanged"
    ];
}


RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
	callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}


RCT_EXPORT_METHOD(isCallConnected:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
    NSString* result = @"disconnected";
    if (@available(iOS 10.0, *)) {
        if(callObserver != nil && !cannotUseCallKit){
            NSArray<CXCall *> *calls = [callObserver calls];
            for (CXCall *call in calls) {
                // do something with object
                
                if(![call hasEnded] && [call hasConnected]){
                    result = @"connected";
                }
            }
        }
    }
    
    callback(@[result]);
}

RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)title
                 location:(NSString *)location
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(audioDidInterrupted:)
        name:AVAudioSessionInterruptionNotification
        object:[AVAudioSession sharedInstance]];
 NSInteger eventId = 1;
 if (eventId) {
    resolve(@[@(eventId)]);
  } else {
    reject(@"event_failure", @"no event id returned", nil);
  }
}


@end
