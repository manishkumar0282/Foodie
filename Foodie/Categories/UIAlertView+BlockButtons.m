//
//  UIAlertView+BlockButtons.m
//
//  Created by Manish Kumar - Imported on 3/29/14.
//

#import "UIAlertView+BlockButtons.h"
#import <objc/runtime.h>

@interface UIAlertViewHelper: NSObject <UIAlertViewDelegate>
@end

@interface UIAlertViewHelper()

@property (nonatomic, strong) NSMutableDictionary *alertButtons;
@property (nonatomic, strong) NSMutableDictionary *alertViews;

+(instancetype) sharedHelper;

@end

@implementation UIAlertViewHelper

+(instancetype) sharedHelper
{
	static dispatch_once_t once = 0;
    __strong static UIAlertViewHelper *_sharedHelper = nil;
    dispatch_once(&once, ^{
        _sharedHelper = [[UIAlertViewHelper alloc] init];
    });
    return _sharedHelper;
}

- (void) setButtons:(NSArray *)buttons forAlert:(UIAlertView *)alert
{
    if (!self.alertButtons)
        self.alertButtons = [NSMutableDictionary dictionary];
    [self.alertButtons setObject:buttons forKey:[NSValue valueWithNonretainedObject:alert]];
    if (!self.alertViews)
        self.alertViews = [NSMutableDictionary dictionary];
    [self.alertViews setObject:alert forKey:[NSValue valueWithNonretainedObject:alert]];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *buttonsArray = [self.alertButtons objectForKey:[NSValue valueWithNonretainedObject:alertView]];
    [self.alertButtons removeObjectForKey:[NSValue valueWithNonretainedObject:alertView]];
    [self.alertViews removeObjectForKey:[NSValue valueWithNonretainedObject:alertView]];

    // If the button index is -1 it means we were dismissed with no selection
    // TODO:  Should we treat the button index == -1 as a cancel and call the cancel block if any?
    if (buttonIndex >= 0)
    {
        BlockButton *button = [buttonsArray objectAtIndex:buttonIndex];

        NSString *text0 = @"";
        NSString *text1 = @"";
        switch (alertView.alertViewStyle) {
            case UIAlertViewStyleDefault:
                if(button.action)
                    button.action();
                break;
            case UIAlertViewStyleSecureTextInput:
            case UIAlertViewStylePlainTextInput:
                if (button.actionWithText) {
                    text0 = [[alertView textFieldAtIndex:0] text];
                    button.actionWithText(text0);
                }
                if(button.action)
                    button.action();
                break;
            case UIAlertViewStyleLoginAndPasswordInput:
                if (button.actionWithTextText) {
                    text0 = [[alertView textFieldAtIndex:0] text];
                    text1 = [[alertView textFieldAtIndex:1] text];
                    button.actionWithTextText(text0, text1);
                }
                if(button.action)
                    button.action();
                break;
            default:
                break;
        }
    }
}
@end

@interface UIAlertView ()

@end

@implementation UIAlertView (BlockButtons)
- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    UITextField* tf = [self textFieldAtIndex:0];
    tf.keyboardType = keyboardType;
}

+(instancetype) showWithTitle:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:nil
                          delegate:[UIAlertViewHelper sharedHelper]
                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                          otherButtonTitles: nil];
    alert.accessibilityLabel = title;

    [alert show];

    return alert;
}


+(instancetype) showWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:[UIAlertViewHelper sharedHelper]
                          cancelButtonTitle:NSLocalizedString(cancelButtonTitle, nil)
                          otherButtonTitles: nil];
    alert.accessibilityLabel = title;

    [alert show];

    return alert;
}

+(instancetype) showWithMessage:(NSString *)message
{
    return [self showWithTitle:@"" message:message];
}


+(instancetype) showWithTitle:(NSString *)title
                      message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:[UIAlertViewHelper sharedHelper]
                          cancelButtonTitle: NSLocalizedString(@"OK", nil)
                          otherButtonTitles: nil];
    alert.accessibilityLabel = title;

    [alert show];

    return alert;
}

+(instancetype) showWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButton
{
    if (cancelButton){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message cancelButton:cancelButton otherButtonsArray:nil];
        [alert show];
        return alert;
    }

    return [UIAlertView showWithTitle:title message:message];
}


+(instancetype) showWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButton
                  otherButton:(BlockButton *)okButton
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                               cancelButton:cancelButton
                                          otherButtonsArray:[NSArray arrayWithObject:okButton]];
    [alert show];
    return alert;
}

+(instancetype) showWithTitle:(NSString *)title
                      message:(NSString *)message
                      textBox:(NSString *)defaultText
                 cancelButton:(BlockButton *)cancelButton
                  otherButton:(BlockButton *)okButton
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[UIAlertViewHelper sharedHelper]
                                          cancelButtonTitle:cancelButton.label
                                          otherButtonTitles:okButton.label, nil];
    alert.accessibilityLabel = title;

    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    if (defaultText)
        [[alert textFieldAtIndex:0] setPlaceholder:defaultText];

    //----
    NSMutableArray *buttonsArray = [NSMutableArray arrayWithObjects:cancelButton, okButton, nil];
    for(BlockButton *button in buttonsArray)
        button.parentView = alert;

    [[UIAlertViewHelper sharedHelper] setButtons:buttonsArray forAlert:alert];

    [alert show];

    return alert;
}

-(instancetype) initWithTitle:(NSString *)title
                      message:(NSString *)message
                      textBox:(NSString *)defaultText
                 cancelButton:(BlockButton *)cancelButton
                  otherButton:(BlockButton *)okButton
{
    self = [self initWithTitle:title
                       message:message
                      delegate:[UIAlertViewHelper sharedHelper]
             cancelButtonTitle:cancelButton.label
             otherButtonTitles:okButton.label, nil];
    
    self.accessibilityLabel = title;
    
    self.alertViewStyle = UIAlertViewStylePlainTextInput;
    if (defaultText)
        [[self textFieldAtIndex:0] setPlaceholder:defaultText];
    
    //----
    NSMutableArray *buttonsArray = [NSMutableArray arrayWithObjects:cancelButton, okButton, nil];
    for(BlockButton *button in buttonsArray)
        button.parentView = self;
    
    [[UIAlertViewHelper sharedHelper] setButtons:buttonsArray forAlert:self];
    
    return self;
}

+(instancetype) showWithTitle:(NSString *)title
                      message:(NSString *)message
                     userName:(NSString *)userName
                     password:(NSString *)password
                 cancelButton:(BlockButton *)cancelButton
                  otherButton:(BlockButton *)okButton
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[UIAlertViewHelper sharedHelper]
                                          cancelButtonTitle:cancelButton.label
                                          otherButtonTitles:okButton.label, nil];
    alert.accessibilityLabel = title;

    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    if (userName)
        [[alert textFieldAtIndex:0] setText:userName];
    if (password)
        [[alert textFieldAtIndex:1] setText:password];

    //----
    NSMutableArray *buttonsArray = [NSMutableArray arrayWithObjects:cancelButton, okButton, nil];
    for(BlockButton *button in buttonsArray)
        button.parentView = alert;

    [[UIAlertViewHelper sharedHelper] setButtons:buttonsArray forAlert:alert];

    return alert;
}


// If we wanted to implement an equivalent -initWithTitle,
// there are some hoops we need to go through.
// Read: http://c-faq.com/varargs/handoff.html which explains the issues to the problem asked at:
// http://stackoverflow.com/questions/1185177/how-to-send-optional-arguments-to-another-function-method?rq=1
// This function is based on sample at https://github.com/jivadevoe/UIAlertView-Blocks
+(instancetype) showWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButton
                 otherButtons:(BlockButton *)otherButtons, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *buttonsArray = [NSMutableArray array];
    BlockButton *eachItem;
    va_list argumentList;
    if (otherButtons)
    {
        [buttonsArray addObject: otherButtons];
        va_start(argumentList, otherButtons);
        while((eachItem = va_arg(argumentList, BlockButton *)))
        {
            [buttonsArray addObject: eachItem];
        }
        va_end(argumentList);
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                               cancelButton:cancelButton
                                          otherButtonsArray:buttonsArray];
    [alert show];
    return alert;
}

-(instancetype) initWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButton
                 otherButtons:(BlockButton *)otherButtons, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *buttonsArray = [NSMutableArray array];
    BlockButton *eachItem;
    va_list argumentList;
    if (otherButtons)
    {
        [buttonsArray addObject: otherButtons];
        va_start(argumentList, otherButtons);
        while((eachItem = va_arg(argumentList, BlockButton *)))
        {
            [buttonsArray addObject: eachItem];
        }
        va_end(argumentList);
    }

    return [[UIAlertView alloc] initWithTitle:title
                                      message:message
                                 cancelButton:cancelButton
                            otherButtonsArray:buttonsArray];
}

-(instancetype) initWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelButton:(BlockButton *)cancelButton
            otherButtonsArray:(NSArray *)buttons
{
    UIAlertView *alert;
    if (cancelButton)
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:message
                                          delegate:[UIAlertViewHelper sharedHelper]
                                 cancelButtonTitle:cancelButton.label
                                 otherButtonTitles:nil];
    else
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:message
                                          delegate:[UIAlertViewHelper sharedHelper]
                                 cancelButtonTitle:nil
                                 otherButtonTitles:nil];
    alert.accessibilityLabel = title;

    NSMutableArray *buttonsArray;
    if (buttons)
        buttonsArray = [NSMutableArray arrayWithArray:buttons];
    else
        buttonsArray = [NSMutableArray array];

    for(BlockButton *button in buttonsArray)
    {
        button.parentView = alert;
        [alert addButtonWithTitle:button.label];
    }

    if(cancelButton)
    {
        cancelButton.parentView = alert;
        [buttonsArray insertObject:cancelButton atIndex:0];
    }

    [[UIAlertViewHelper sharedHelper] setButtons:buttonsArray forAlert:alert];
    
    return alert;
}

-(void)dismiss:(BOOL)animated
{
    [self dismissWithClickedButtonIndex:-1 animated:animated];
}

@end

