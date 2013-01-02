#import "FISampleBuffer.h"
#import "FISoundContext.h"
#import "FISoundDevice.h"

@interface FISampleBufferTests : SenTestCase
@property(strong) FISoundContext *context;
@end

@implementation FISampleBufferTests

- (void) testInitializationWithNilData
{
    FISampleBuffer *buffer = [[FISampleBuffer alloc] initWithData:nil
        sampleRate:0 sampleFormat:FISampleFormatMono8 error:NULL];
    STAssertNil(buffer, @"Creating buffer with nil data returns nil");
}

- (void) testDurationCalculations
{
    unsigned char sampleBytes[44100] = {0};
    NSData *sampleData = [NSData dataWithBytes:sampleBytes length:44100];
    FISampleBuffer *buffer = [[FISampleBuffer alloc] initWithData:sampleData
        sampleRate:44100 sampleFormat:FISampleFormatMono16 error:NULL];
    STAssertNotNil(buffer, @"Create a sample buffer");
    STAssertEquals([buffer duration], (NSTimeInterval) 0.5,
        @"Calculate duration from sample data length and format");
}

#pragma mark Setup

- (void) setUp
{
    [super setUp];
    [self setContext:[[FISoundContext alloc]
        initWithDevice:[FISoundDevice defaultSoundDevice]
        error:NULL]];
    [_context setCurrent:YES];
}

@end
