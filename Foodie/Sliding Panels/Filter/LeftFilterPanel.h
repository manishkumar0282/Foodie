//
//  LeftFilterPanel.h
//  Foodie
//
//  Created by Manish Kumar on 9/15/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

//#import "BaseUIViewController.h"

@interface LeftFilterPanel : UIView
+(instancetype)instantiateFromStoryboard;
-(void)slideInFromLeft:(BoolBlock)completion;

@end
