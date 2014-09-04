//
//  UIButton+Extras
//
//  Created by Navi Singh on 3/31/14.
//

#import "UIButton+Extras.h"


@implementation UIButton (extras)

- (void)setImages:(id)images
{
    NSString *name;
    if ([images isKindOfClass:NTJSON.class]) {
        if (((NTJSON *)images).array) {
            NSArray *array = ((NTJSON *)images).array;
            if (array.count > UIControlStateNormal){
                name = array[UIControlStateNormal];
                if (name.length)
                    [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
            }
            if (array.count > UIControlStateHighlighted){
                name = array[UIControlStateHighlighted];
                if (name.length)
                    [self setImage:[UIImage imageNamed:name] forState:UIControlStateHighlighted];
            }
            if (array.count > UIControlStateDisabled){
                name = array[UIControlStateDisabled];
                if (name.length)
                    [self setImage:[UIImage imageNamed:name] forState:UIControlStateDisabled];
            }
            if (array.count > UIControlStateSelected){
                name = array[UIControlStateSelected];
                if (name.length)
                    [self setImage:[UIImage imageNamed:name] forState:UIControlStateSelected];
            }
        }
        else if(((NTJSON *)images).dictionary){
            NSDictionary *dict = ((NTJSON *)images).dictionary;
            
            name = dict[@"normal"];
            if (name)
                [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
            name = dict[@"highlighted"];
            if (name)
                [self setImage:[UIImage imageNamed:name] forState:UIControlStateHighlighted];
            name = dict[@"disabled"];
            if (name)
                [self setImage:[UIImage imageNamed:name] forState:UIControlStateDisabled];
            name = dict[@"selected"];
            if (name)
                [self setImage:[UIImage imageNamed:name] forState:UIControlStateSelected];
        }
    }
    else if([images isKindOfClass:NSString.class]){
        name = (NSString *)images;
        [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    }
}


- (void)centerTextVerticallyWithPadding:(float)padding
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);
    
}


- (void)centerTextVertically
{
    const CGFloat kDefaultPadding = 6.0f;
    
    [self centerTextVerticallyWithPadding:kDefaultPadding];
}  

-(void)setTextFieldStyleBorder{
    CALayer * l =   [self layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:3];
    [l setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [l setBorderWidth:0.5];
}
@end
