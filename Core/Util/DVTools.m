//
//  DVTools.m
//  MakeHave
//
//  Created by pan Shiyu on 15/7/21.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "DVTools.h"

#import "SDImageCache.h"
#import "SDWebImageManager.h"

@interface DVTools ()
@property (nonatomic, assign) BOOL hasGBW3;
@property (nonatomic, assign) BOOL hasGBW6;
+ (instancetype)sharedTools;
@end

@implementation DVTools

+ (instancetype)sharedTools
{
    static DVTools* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


@end

UIImageView* makeSepline()
{
    UIImageView* line = [[UIImageView alloc] init]; //WithImage:[UIImage imageNamed:@"line_common"]];
    [line setFrame:CGRectMake(0, 0, SCREEN_WIDTH, .5)];
    line.image = [UIImage imageWithColor:HEXCOLOR(0xdddddd)];
    return line;
}

UIImageView* makeSepline2(CGRect frame) {
    UIImageView* line = [[UIImageView alloc] initWithFrame:frame];
    line.image = [UIImage imageWithColor:HEXCOLOR(0xdddddd)];
    return line;
}

UIImageView* makeSepline3(CGRect frame,UIColor *color) {
    UIImageView* line = [[UIImageView alloc] initWithFrame:frame];
    line.image = [UIImage imageWithColor:color];
    return line;
}

UIView* makeLine(CGFloat width)
{
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_common"]];
    [line setFrame:CGRectMake(0, 0, width, 1)];
    return line;
}

UIImageView* makeImgView(CGRect frame, NSString* picName)
{
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = [[UIImage imageNamed:picName] resizableImage];
    return imgView;
}

UIImage* cacheImageFromUrl(NSString* webPath)
{
    NSString* key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:webPath]];

    UIImage* resultImage = nil;
    resultImage = [[SDWebImageManager sharedManager].imageCache imageFromMemoryCacheForKey:key];

    if (!resultImage) {
        resultImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
    }

    if (resultImage) {
        //        resultImage = [resultImage scaleToSize:CGSizeMake(80, 80)];
        UIImage* image = [UIImage imageWithCGImage:resultImage.CGImage];
        CGFloat height = image.size.height;
        CGRect middleRect = CGRectMake((image.size.width - height) / 2, 0, height, height);

        CGImageRef cr = CGImageCreateWithImageInRect([image CGImage], middleRect);
        image = [UIImage imageWithCGImage:cr];
        CGImageRelease(cr);
        resultImage = [image aspectScaleImageToSize:CGSizeMake(310, 310)];
    }

    if (!resultImage) {
        resultImage = [UIImage imageNamed:@"icon_logo"];
    }
    resultImage = [UIImage imageNamed:@"icon_logo"];
    //    resultImage = [UIImage imageNamed:@"res2"];
    ////    [UIImage imageNamed:@"res2.png"]
    //
    //    NSData* imageData = UIImagePNGRepresentation(resultImage);
    //    int kb = imageData.length / 1024;

    //    UIImageView *vv = [[UIImageView alloc] initWithImage:resultImage];
    //    vv.frame = DVRectMake(100, 100, resultImage.size.width, resultImage.size.height);
    //    [[UIApplication sharedApplication].keyWindow addSubview:vv];

    return [resultImage copy];
}

#pragma mark - alert

void alertError(NSError* error)
{
    NSString* str = MHMSG_POOR_NETWORK;
    if (error && (error.userInfo[@"msg"] || error.userInfo[@"message"])) {
        str = error.userInfo[@"msg"] ? error.userInfo[@"msg"] : error.userInfo[@"message"];
    }
    if ([str isEqualToString:@"token失效"]) {
         [[DVAppCenter sharedAppCenter] logout];
        [[DVPortalCenter portalCenter] portalToAim:DVPortalLogin params:nil];
    }

    [MBProgressHUD topShowTmpMessage:str];
}

void alertCommonError(NSError* error, NSString* defaultMessage)
{
    NSString* str = defaultMessage;
    if (error && (error.userInfo[@"msg"] || error.userInfo[@"message"])) {
        str = error.userInfo[@"msg"] ? error.userInfo[@"msg"] : error.userInfo[@"message"];
    }

    [MBProgressHUD topShowTmpMessage:str];
}

void alertPoolnetError()
{
    [MBProgressHUD topShowTmpMessage:MHMSG_POOR_NETWORK];
}

void alertPushSimplely(NSString* info)
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:info message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -

NSDictionary* geoDict(NSString* geoPath)
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:geoPath ofType:@"geojson"];
    NSData* jsonData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSError* error;
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (error) {
        DVLog(@"-----wrong geofile in %@", geoPath);
    }
    return dict[@"data"];
}

#pragma mark -

void runOnMainQueue(void (^block)(void))
{
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void runOnBackgroundQueue(void (^block)(void))
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

void runBlockAfterDelay(float delaySeconds, void (^block)(void))
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delaySeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

void runBlockWithRetryTimes(NSUInteger retryTimes, CGFloat delayTime, BOOL (^block)())
{
    NSCAssert(block, @"block不能为空");

    if (retryTimes > 0) {
        BOOL hasDone = block();
        if (!hasDone) {
            runBlockAfterDelay(delayTime, ^{
                runBlockWithRetryTimes(retryTimes - 1, delayTime, block);
            });
        }
    }
}

UIImageView * makeTopLine(){
    UIImageView* line = [[UIImageView alloc] init]; //WithImage:[UIImage imageNamed:@"line_common"]];
    [line setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.image = [UIImage imageWithColor:HEXCOLOR(0xdddddd)];
//    line.layer.shadowOpacity = 0.8;// 阴影透明度
//    line.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影的颜色
//    line.layer.shadowRadius = 3;// 阴影扩散的范围控制
//    line.layer.shadowOffset = CGSizeMake(-1, -1);// 阴影的范围
    return line;
}

NSString* intToString(int num)
{
    return [@(num) stringValue];
}
NSString* int64ToString(int64_t num)
{
    return [@(num) stringValue];
}


NSString * dateToString(NSDate * date){
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

NSString* globalString(NSString* key)
{
    return NSLocalizedStringFromTable(key, @"Golbal", nil);
}

NSString* getWeekDayFordate(NSTimeInterval data){
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSDate *  newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

NSString* getCurrentWeekDay(){
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    return getWeekDayFordate(interval);
}

NSString * getCurrentTime(){
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *showTimeNew = [formatter stringFromDate:now];
    return showTimeNew;
}

NSString * getCurrentData(){
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return [NSString stringWithFormat:@"%ld-%ld-%ld",[dateComponent year],[dateComponent month],[dateComponent day]];
}
float folderSizeAtPath(NSString *path){
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += fileSizeAtPath(absolutePath);
        }
        if ([[SDImageCache sharedImageCache] getSize]) {
            folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;//SDWebImage框架自身计算缓存的实现
        }
        return folderSize;
    }
    return 0;
}
float fileSizeAtPath(NSString *path){
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
       unsigned long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}



