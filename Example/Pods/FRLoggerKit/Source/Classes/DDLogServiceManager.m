//
//  DDLogServiceManager.m
//  youpin-sale-ios
//
//  Created by 曾凡旭 on 16/6/21.
//  Copyright © 2016年 youpin. All rights reserved.
//

#import "DDLogServiceManager.h"

@interface DDLogFormatter : NSObject<DDLogFormatter>

@end

@implementation DDLogServiceManager

+ (DDLogServiceManager *)shared{
    static DDLogServiceManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DDLogServiceManager alloc] init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        [self commInit];
    }
    return self;
}

-(void)commInit{
    DDLogFormatter *formatter = [[DDLogFormatter alloc] init];
    //添加输出到Xcode控制台
    
    [[DDASLLogger sharedInstance] setLogFormatter:formatter];
    [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // 设置颜色
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:255.0f/255.0f green:111.0f/255.0f blue:111.0f/255.0f alpha:1.0f]
                                     backgroundColor:nil
                                             forFlag:DDLogFlagError];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:48.0f/255.0f alpha:1.0f]
                                     backgroundColor:nil
                                             forFlag:DDLogFlagWarning];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:68.0f/255.0f green:233.0f/255.0f blue:139.0f/255.0f alpha:1.0f]
                                     backgroundColor:nil
                                             forFlag:DDLogFlagInfo];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:75.0f/255.0f green:83.0f/255.0f blue:78.0f/255.0f alpha:1.0f]
                                     backgroundColor:nil
                                             forFlag:DDLogFlagVerbose];
    
}

@end


@implementation DDLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    
    NSString *logLevel = nil;
    switch (logMessage.flag)
    {
        case DDLogFlagError:
            logLevel = @"[ERROR] >  ";
            break;
        case DDLogFlagWarning:
            logLevel = @"[WARN]  >  ";
            break;
        case DDLogFlagInfo:
            logLevel = @"[INFO]  >  ";
            break;
        case DDLogFlagDebug:
            logLevel = @"[DEBUG] >  ";
            break;
        default:
            logLevel = @"[VBOSE] >  ";
            break;
    }
    
    NSString *formatStr = [NSString stringWithFormat:@"%@{%@ %@}[line %zi] %@",
                           logLevel, [logMessage fileName],logMessage->_function,
                           logMessage->_line, logMessage->_message];
    return formatStr;
}

@end
