//
//  UITextFieldExtend.m
//  MakeHave
//
//  Created by pppsy on 15/8/12.
//  Copyright (c) 2015年 makehave. All rights reserved.
//

#import "UITextFieldExtend.h"
#import "RPFloatingPlaceholderTextField.h"

@implementation UITextField (helper)

@end

UITextField* txtfieldWithFrame(CGRect frame,NSString *placeholder)
{
    UITextField* field = [[UITextField alloc] initWithFrame:frame];
    field.background = [[UIImage imageNamed:@"icon_frame"] resizableImage];
    field.font = Font(15);
    field.textColor = HEXCOLOR(0xc3c1c2);
    field.placeholder = placeholder;
//    field.leftView = [[UIView alloc] initWithFrame:DVRectMake(0, 0, 8, frame.size.height)];
    
    return field;
}
