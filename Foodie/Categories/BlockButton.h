//
//  BlockButton.h
//
//  Created by Navi Singh on 3/29/14.
//

#import <Foundation/Foundation.h>

@interface BlockButton : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, copy) void(^action)();
@property (nonatomic, copy) void(^actionWithText)(NSString *text);
@property (nonatomic, copy) void(^actionWithTextText)(NSString *username, NSString *password);

+(instancetype)button;
+(instancetype)label:(NSString *)label;
+(instancetype)label:(NSString *)label action:(void(^)())action;

+(instancetype)label:(NSString *)label actionWithText:(void(^)(NSString *text))action;
+(instancetype)label:(NSString *)label actionWithTextText:(void(^)(NSString *username, NSString *password))action;

@end

BlockButton *button(NSString *label, void(^action)());
BlockButton *buttonT(NSString *label, void(^action)(NSString *));
BlockButton *buttonTT(NSString *label, void(^action)(NSString *, NSString *));