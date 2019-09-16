//
//  DVBaseEngine.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVBaseEngine.h"
//TODO psy 这一块是有用的，不过测试的时候感觉有问题，后续解决
//#import <OHHTTPStubs/OHHTTPStubs.h>
//
//BOOL makeRegular(NSString *pattern,NSURLRequest *request){
//    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
//    NSString *urlStr = [request.URL absoluteString];
//    NSInteger index= [re numberOfMatchesInString:urlStr options:0 range:NSMakeRange(0, [urlStr length])];
//    return (index > 0);
//};
//
//OHHTTPStubsResponse* makeResponse(NSString *filename) {
////    NSString* path  = [[NSBundle bundleForClass:[HTMDelayStub class]] pathForResource:filename ofType:nil];
////    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
////    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
////    return [OHHTTPStubsResponse responseWithData:jsonData statusCode:200 headers:nil];
//    
//    NSString *filePath =[[NSBundle mainBundle] pathForResource:filename ofType:@"geojson"];
//    NSData *jsonData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
////    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dd options:0 error:nil];
//    return [OHHTTPStubsResponse responseWithData:jsonData statusCode:200 headers:nil];
//};

@implementation DVBaseEngine

//+ (void)setStubByGeopath:(NSString*)path regular:(NSString*)regular {
//    
//    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//        return makeRegular(regular, request);
//    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
//        return makeResponse(path);
//    }];
//    
//}
//
//+ (void)clearAllStub {
//    [OHHTTPStubs removeAllStubs];
//}

@end
