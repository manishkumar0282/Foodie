//
//  UIAlertView+BlockButtons.h
//
//  Created by Navi Singh on 3/29/14.
//

#import <UIKit/UIKit.h>
#import "BlockButton.h"

@interface UIAlertView (BlockButtons)

+ (instancetype)showWithMessage:(NSString *)message;

//Alert without delegate. - cancelButtonTitle:@"OK"
+ (instancetype)showWithTitle:(NSString *)title;

//Alert without delegate - cancelButtonTitle:@"OK"
+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message;

+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle;

//Alert with single block button
+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButtonItem;

//Alert with two block buttons.
+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButton
                  otherButton:(BlockButton *)okButton;

//Alert with many block buttons.
+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButton
                 otherButtons:(BlockButton *)otherButtons, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButton
                 otherButtons:(BlockButton *)otherButtons, ... NS_REQUIRES_NIL_TERMINATION;

//Alert using single editable text box.
+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
                      textBox:(NSString *)textBox
                 cancelButton:(BlockButton *)cancelButton
                  otherButton:(BlockButton *)okButton;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                      textBox:(NSString *)textBox
                 cancelButton:(BlockButton *)cancelButton
                  otherButton:(BlockButton *)okButton;

//Alert using username/pasword editable text boxes.
+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
                     userName:(NSString *)userName
                     password:(NSString *)password
                 cancelButton:(BlockButton *)cancelButton
                  otherButton:(BlockButton *)okButton;
//- (NSInteger)addButton:(BlockButton *)button;

- (void)dismiss:(BOOL)animated;
- (void)setKeyboardType:(UIKeyboardType)keyboardType;
@end


/* Sample Usage
    [UIAlertView showWithTitle:@"hello" message:@"world"];
    [UIAlertView showWithTitle:@"hello" message:@"world"
          cancelButton:[BlockButton label:@"test" action:^{
        NSLog(@"clicked cancel");
    }]];
    [UIAlertView showWithTitle:@"hello"
               message:@"world"
          cancelButton:button(@"cancel", ^{
        NSLog(@"clicked cancel");
    })];
    [UIAlertView showWithTitle:@"hello" message:@"world"
          cancelButton:button(@"cancel", ^{
        NSLog(@"clicked cancel");
    })
           otherButton:button(@"other", ^{
        NSLog(@"clicked other");
    })
     ];
    [UIAlertView showWithTitle:@"hello" message:@"world"
          cancelButton:
         button(@"cancel", ^{
            NSLog(@"clicked cancel");
        })
              otherButtons:
         button(@"other1", ^{
            NSLog(@"clicked other1");
        }),
         button(@"other2", ^{
            NSLog(@"clicked other2");
        }),
         nil
     ];
 */
