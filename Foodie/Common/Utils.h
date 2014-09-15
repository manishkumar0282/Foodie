//
//  Utils.h
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "Strings.h"
//#import "StationAnnotation.h"
//#import "StationData.h"
//#import "TextFieldCustom.h"
//#import "PickerView.h"
//#import "PickerDateTime.h"

@interface Utils : NSObject


#pragma mark -

#pragma mark - Text Validation
+(BOOL)isTextEmpty:(NSString *)strText;

#pragma mark Label Height
+(CGSize)calculateLabelSize:(NSString *)messageString
                 labelWidth:(int)labelWidth
                   fontSize:(int)fontSize;

+(float)calculateLabelHeight:(NSString *)messageString
                  labelWidth:(int)labelWidth
                    fontSize:(int)fontSize;

#pragma mark Height Width for controls
#pragma mark Button

+(float)getButtonWidth:(UIButton *)but;
+(float)getButtonHeight:(UIButton *)but;

#pragma mark - Image caching
+(void)initializeImageCache;
+(UIImageView*)getDownloadableImageLogo:(NSString *)iconUrl
                               iconRect:(CGRect)iconRect;
+(void)setImageForImageView:(UIImageView*)imgView
                    fromUrl:(NSString *)imageUrl;
+(UIButton*)createButtonWithImageFromURL:(NSString *)iconUrl
                                iconRect:(CGRect)iconRect;
#pragma mark Image
+(float)getImageHeight:(NSString *)imgName;
+(float)getImageWidth:(NSString *)imgName;
+(UIImage *)getImage:(NSString *)filename;
+(UIImage *)imageWithImage:(UIImage *)image
              scaledToSize:(CGSize)newSize;

#pragma mark - Alert Methods
+(void)showAlertWithTitle:(NSString *)title
				  message:(NSString *)message
				 delegate:(id)delegate;

+(void)showAlertViewWithTitle:(NSString *)title
					  message:(NSString *)message
					 delegate:(id)delegate
			cancelButtonTitle:(NSString *)cancelButtonTitle
			 otherButtonTitle:(NSString *)otherButtonTitle;

+(void)showAlertWithMessageAndTag:(NSString *)message
						 alertTag:(int)alertTag
                            title:(NSString *)title
						 delegate:(id)delegate;

+(void)showAlertViewWithTitle:(NSString *)title
					  message:(NSString *)message
					 delegate:(id)delegate
			cancelButtonTitle:(NSString *)cancelButtonTitle
			 otherButtonTitle:(NSString *)otherButtonTitle
						  tag:(NSInteger)tag;

#pragma mark Plist Handling Methods
+ (NSString *)dataFilePath:(NSString *)fileName;
+(BOOL)writeToPList:(NSString *)fileName keyName:(NSString *)keyName contents:(NSDictionary *)contentsDictionary;
+(NSDictionary *)readFromPlist:(NSString *)fileName keyName:(NSString *)keyName;
+ (void)deletePList:(NSString*)fileName;

+(NSDictionary *)loadUserEvatar;
+(BOOL)saveUserEvatar:(NSDictionary *)dict;
+(NSDictionary *)loadVehicleData;
+(BOOL)saveVehicleData:(NSDictionary *)dict;
+(NSDictionary *)loadEvatars;
+(BOOL)saveEvatars:(NSDictionary *)dict;
+(BOOL)saveDictionaryDataToFile:(NSString *)fileName dict:(NSDictionary *)dictData;
+(NSString *)getFilePath:(NSString *)fileName;
+(BOOL)fileExistsAtPath:(NSString *)fileName;
+(BOOL)writeFileToDisk:(NSString *)fileName fileData:(NSData*)fileData;

#pragma mark - Text Methods
+(NSString *)validateString:(NSString *)strToValidate;

#pragma mark -
#pragma mark Label Creation Methods

//-------------------------------------------------------------------------
// Method:			createLabelWithBoldFont
//
// Description:
//
// Parameter:		NSString :title
//					CGRect	 :rect
//					NSTextAlignment :textAlignment
//					NSInteger :textSize
//
//-------------------------------------------------------------------------

+(UILabel *)createLabelWithBoldFont:(NSString *)title
							   rect:(CGRect)rect
					  textAlignment:(NSTextAlignment)textAlignment
						   textSize:(NSInteger)textSize;

//-------------------------------------------------------------------------
// Method:			createLabelWithSystemFont
//
// Description:
//
// Parameter:		NSString :title
//					CGRect	 :rect
//					NSTextAlignment :textAlignment
//					NSInteger :textSize
//
//-------------------------------------------------------------------------

+(UILabel *)createLabelWithSystemFont:(NSString *)title
								 rect:(CGRect)rect
						textAlignment:(NSTextAlignment)textAlignment
							 textSize:(NSInteger)textSize;
//-------------------------------------------------------------------------
// Method:			createLabelWithItalicFont
//
// Description:
//
// Parameter:		NSString :title
//					CGRect	 :rect
//					NSTextAlignment :textAlignment
//					NSInteger :textSize
//
//-------------------------------------------------------------------------

+(UILabel *)createLabelWithItalicFont:(NSString *)title
								 rect:(CGRect)rect
						textAlignment:(NSTextAlignment)textAlignment
							 textSize:(NSInteger)textSize;


//-------------------------------------------------------------------------
// Method:			createLabelWithBoldFontAndLines
//
// Description:
//
// Parameter:		NSString :title
//					CGRect	 :rect
//					NSTextAlignment :textAlignment
//					NSInteger :textSize
//
//-------------------------------------------------------------------------

+(UILabel *)createLabelWithBoldFontAndLines:(NSString *)title
									   rect:(CGRect)rect
							  textAlignment:(NSTextAlignment)textAlignment
							  numberOfLines:(NSInteger)lines;
//-------------------------------------------------------------------------
// Method:			createTextLabel
//
// Description:
//
// Parameter:		text:(NSString *)labelText
//					backGroundColor:(UIColor)bgColor
//					textColor:(UIColor) textColor
//					fontSize:(CGFloat)labelTextFontSize
//--------------------------------------------------------------------------
+(UILabel*)createTextLabel:(CGRect)labelRect
					  text:(NSString *)labelText
		   backGroundColor:(UIColor*)bgColor
				 textColor:(UIColor*)textColor
				isTextBold:(BOOL)isTextBold
				  fontSize:(CGFloat)labelTextFontSize;

//-------------------------------------------------------------------------
// Method:			createTextLabel
//
// Description:
//
// Parameter:		text:(NSString *)labelText
//					backGroundColor:(UIColor)bgColor
//					textColor:(UIColor) textColor
//					fontSize:(CGFloat)labelTextFontSize
//--------------------------------------------------------------------------
+(UILabel*)createTextLabel:(CGRect)labelRect
					  text:(NSString *)labelText
		   backGroundColor:(UIColor*)bgColor
				 textColor:(UIColor*)textColor
				isTextBold:(BOOL)isTextBold
				  fontSize:(CGFloat)labelTextFontSize
			 numberOfLines:(int)numberOfLines;

+(UILabel*)createErrorMessage:(NSString *)errorMessage;
+(UILabel*)createCaptionMessage:(NSString *)captionMessage;

#pragma mark - Font Color
+(UIColor *)getColorLight;
+(UIColor *)getColorDark;
+(UIColor *)getColorMedium;

#pragma mark - Button Methods
+(UIButton*)createButtonWithImage:(NSString *)btnImg
                             rect:(CGRect)btnRect
                         delegate:(id)btnDelegate
                     actionMethod:(SEL)actionMethod
                           btnTag:(int)btnTag;

+(UIButton*)createButtonWithImage:(NSString *)btnImg
             highlightedImageName:(NSString *)highlightedImage
                             rect:(CGRect)btnRect
                         delegate:(id)btnDelegate
                     actionMethod:(SEL)actionMethod
                           btnTag:(int)btnTag;
//-------------------------------------------------------------------------
// Method:			createButtonWithImageName
//
// Description:
//
// Parameter:		NSString :title
//					UIImage :image
//					CGRect	:rect
//					id		:delegate
//					(SEL)	 action
//
//-------------------------------------------------------------------------
+(UIButton *)createButtonWithImageName:(NSString *)title
                        titleFontColor:(UIColor*)fontColor
                         titleFontSize:(CGFloat)titleFontSize
							 imageName:(UIImage *)image
								  rect:(CGRect)rect
							  delegate:(id)delegate
						  actionMethod:(SEL)action;
+(UIButton *)createButtonWithStretchedImageName:(NSString *)title
                                 titleFontColor:(UIColor*)fontColor
                                  titleFontSize:(CGFloat)titleFontSize
                                      imageName:(UIImage *)image
                                           rect:(CGRect)rect
                                       delegate:(id)delegate
                                   actionMethod:(SEL)action;

+(UIButton *)createButtonWithImageAndText:(NSString *)title
                           titleFontColor:(UIColor*)fontColor
                            titleFontSize:(CGFloat)titleFontSize
                              normalImage:(NSString *)normalImage
                         highlightedImage:(NSString *)strHighlightedImage
                                     rect:(CGRect)rect
                                 delegate:(id)delegate
                             actionMethod:(SEL)action;

+(CGSize)calcualteButtonSizeWithText:(NSString *)btnText
                            fontSize:(CGFloat)fontSize;

#pragma mark - create Table Methods
+(UITableView*)getGroupedTable:(CGRect)tableFrame
					  delegate:(id)delegate;

+(UITableView*)getPlainStyleTable:(CGRect)tableFrame
                         delegate:(id)delegate;

+(void)setTransparentBackgroundForTableView:(UITableView *) tbl;

#pragma mark - Log the frame
+(void)logTheFrameForControl:(id)control;

#pragma mark - Utility Methods
+(void)printKeyValuesForDictionary:(NSDictionary *)dictToPrint;

#pragma mark - Conversion methods
+(NSString *)formatDoubleValueToRender:(NSNumber*)numberToRender;
+(NSString *)formatDoubleValueToRender:(NSNumber*)numberToRender
           minimumDigitsBeforeDecimal:(int)minimumDigitsBeforeDecimal
            maximumDigitsAfterDecimal:(int)maximumDigitsAfterDecimal
            minimumDigitsAfterDecimal:(int)minimumDigitsAfterDecimal;


+(NSNumber*)convertMeterToMiles:(NSNumber*)distanceInMeters;
+(NSNumber*)convertFeetToMiles:(NSNumber*)distanceInMeters;
+(NSNumber *)convertFeetToMeters:(NSNumber*)distanceInFeet;
+ (NSString *)distanceShortString:(CLLocationDistance)distance;
+ (NSString *)distanceLongString:(CLLocationDistance)distance;

#pragma mark - Date Formatting Methods
+(NSString *)convert24HourTo12HourFormat:(NSString *)strDate;
+(NSString *)formatDateToString:(NSDate*)date format:(NSString *)stringFormat;
+(NSString *) Convert24hourFormatDateTo12hourFormatFromDate:(NSString *) strDate;

#pragma mark - Location Manager class methods
+(void)saveLocationInUserDefaultsAsLastKnownCurrentLocation:(CLLocationCoordinate2D)foundLocation;
+(CLLocation*)getSavedCLLocation;
+(CLLocationCoordinate2D)getSavedCLLocationCoordinate2D;
+(BOOL)isLastKnownUserLocationAvailableinNSUserDefault;
+(void)initLocationServices:(id)sender;
+(void)addShadow:(id)obj;
+(float)getWW;
+(float)getHH;
+(void)animationOn;
+(void)animationOff;
+(void)roundCorner:(UIView *)v color:(UIColor *)color;
+(id)loadObjFromDefaultsByName:(NSString *)name;
+(void)clearUserDefaults;
+(void)saveObjToDefaults:(id)obj name:(NSString *)name;
+(BOOL)isIphone5;
+(float)getDistanceMiles:(CLLocationCoordinate2D)loc1 toLoc:(CLLocationCoordinate2D)loc2;
+(void)roundCornerWV:(UIView *)v;
+(NSString *)getTemporaryMessage;

#pragma mark - Screen Pixel density
+(CGFloat)getPointToPixelConversionFactor;
+(void)moveView:(UIView *)view x:(float)dx y:(float)dy;
#pragma mark - Validate location
+(BOOL)isLocationValid:(CLLocation*)referenceLocation;
+(BOOL)isLocationCoordinateValid:(CLLocationCoordinate2D)locationCoordinate;
+(void)addShadowCallout:(id)obj;
+(void)unRoundCorner:(UIView *)v color:(UIColor *)color;
+(void)rotateLandscapeToPortrait:(UIView *)v;
+(void)addHighlight:(id)obj;
+(void)removeHighlight:(id)obj;
+(UILabel *)addBackBorder:(CGRect)rect view:(UIView *)v;
+(UILabel *)addCaption:(CGRect)rect view:(UIView *)v caption:(NSString *)caption;
+(void)addBlurbAtY:(float)y view:(UIView *)v caption:(NSString *)caption fontSize:(float)fontSize ynBold:(BOOL)ynBold;
+(UILabel *)addCopyrightToView:(UIView *)v;
+(BOOL)isIOS7;
+(void)addRequiredFields:(CGRect)rect view:(UIView *)v;
+(BOOL)isStringLengthValid:(NSString *)checkString
                 minLength:(int)minLength
                 maxLength:(int)maxLength;
+(BOOL)isAnyWhiteSpaceInTheMessage:(NSString *)text;
+(BOOL)isPasswordValid:(NSString *)passwordText;
+(BOOL)isUserNameValid:(NSString *)username;
+(BOOL)validateEmail:(NSString *)txt;
+(BOOL)validateAlphanumeric:(NSString *)txt;
+(BOOL) isAlphaNumeric:(NSString *)txt;
+(NSString *)getEvatarFilenameFromN:(int)n;
+(UILabel *)addBlurbAtXY:(float)x y:(float)y view:(UIView *)v caption:(NSString *)caption fontSize:(float)fontSize ynBold:(BOOL)ynBold;
+(BOOL)validateZeroLength:(NSString *)txt;
+(BOOL)isNumeric:(NSString *)txt;
+(BOOL)validateNumeric:(NSString *)txt;
+(BOOL)isNumericWithSpaces:(NSString *)txt;
+(BOOL)validateNumericWithSpaces16:(NSString *)txt;
+(BOOL)validateNumeric3:(NSString *)txt;
+(void)fadeToViewController:(id)fromVc to:(id)toVc;
+(void)pushToViewControllerWithFadeEffect:(id)fromVc to:(id)toVc;
+(void)fadeToViewControllerPop:(id)fromVc to:(id)toVc;

#pragma mark - error check method
+(BOOL)isResponseValid:(NSDictionary *)dictValues
                          sender:(id)sender;
+(UIButton *)addButtonLinkAtRect:(CGRect)rect title:(NSString *)title font:(UIFont *)font action:(NSString *)action target:(id)target addSubViewTo:(id)parentView;
+(UIButton *)addButtonAtRect:(CGRect)rect imageFilename:(NSString *)imageFilename action:(NSString *)action target:(id)target addSubViewTo:(id)parentView;
//+(TextFieldCustom*)createCustomTextFieldWithPlaceholder:(NSString *)placeholder
//                                           textFieldTag:(int)textFieldTag
//                                          textFieldRect:(CGRect)textFieldRect
//                                          fieldDelegate:(id)fieldDelegate
//                                                   font:(UIFont*)font;

//+(TextFieldCustom *)addTextFieldAtRect:(CGRect)rect caption:(NSString *)caption note:(NSString *)note placeholder:(NSString *)placeholder delegate:(id)delegate keyboardType:(int)keyboardType addSubViewTo:(id)parentView ynRequiredCaption:(BOOL)ynRequiredCaption;
+(UIImageView *)addImageAtXY:(float)x y:(float)y imageFilename:(NSString *)imageFilename addSubViewTo:(id)parentView;
+(UIImageView *)addImageAtRect:(CGRect)rect imageFilename:(NSString *)imageFilename addSubViewTo:(id)parentView;
+(float)getHHScroll;
+(float)getYScroll;
+(UIImageView *)createRoundCornerAndShadowCallout:(UIView *)iv;
+ (UIColor*) getPixelColorInImage:(CGPoint)point image:(UIImage *)img;
+ (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef)inImage;

#pragma mark - UIImageView methods
+(UIImageView*)bGImageViewForEditModeTextField:(UITextField*)textField;
+(UIImageView*)bGImageViewForNonEditModeTextField:(UITextField*)textField;

#pragma mark - Share Feature
//+(NSString *)getShareTheStationInfoMessage:(StationData*)station;
//+(NSString *)getShareMessageForEmailOption:(StationData*)station driverTips:(NTJSON *)tips;
//+(NSString *)getShareMessageForEmailOptionFromChargingStatus:(NSString*)name address:(NSString*)address portInfo:(NSString*)portInfo description:(NSString*)description tip:(NSString*)tip;
//+(NSString *)getShareMessageForEmailOption:(StationData*)station;
//+(NSString *)getShareMessageForMessageOption:(StationData*)station;
//+(NSString *)getShareMessageForFaceBookOption:(StationData*)station;
//+(NSString *)getShareMessageForTwitterOption:(StationData*)station;
//+(NSString *)getShareMessageForFoursquareOption:(StationData*)station;
+(BOOL)isStatusVisible;
+(UILabel *)addCaptionBelow:(CGRect)rect view:(UIView *)v caption:(NSString *)caption;

#pragma mark - Reachability
//+(BOOL)isNetworkReachable;
//+(BOOL)isHostReachable;
//+(void)startNotificationForReachabilityStatus;
//+(void)stopNotificationForReachabilityStatus;

#pragma mark - connection monitoring
+(void)connectionDidFailWithError:(NSError*)error;





+(float)getHHScroll2:(UIView *)v;
+(void)addBackgroundToView:(id)view imageName:(NSString *)imageName;
+(CGRect)getScrollRect:(float)headerHeight;
+(CGRect)getRectForRightBottomButtonFromImageNamed:(NSString *)imageName view:(id)view;
+(CGRect)getRectForCenterBottomButtonFromImageNamed:(NSString *)imageName view:(id)view;
+(UIImageView *)addLogoToViewAtCenterY:(float)cy view:(UIView *)view imageName:(NSString *)imageName;
//+(CustomNavigationBarView *)addNavigationBarToVC:(id)vc imageName:(NSString *)imageName title:(NSString *)title height:(float)height;
+(float)getXX:(float)x;
+(UIScrollView *)addScrollAtRect:(CGRect)rect delegate:(id)delegate addSubViewTo:(id)parentView imageName:(NSString *)imageName useImageHeightAsContentHeight:(BOOL)ynUseImageHeight;
//+(UIImageView *)addImageAtRect:(CGRect)rect imageFilename:(NSString *)imageFilename addSubViewTo:(id)parentView;

+(CGRect)getRectForLeftBottomButtonFromImageNamed:(NSString *)imageName view:(id)view;
+(void)addTapToView:(id)view target:(id)target;
+(void)addTapToView2:(id)view target:(id)target;
+(void)addTapHandlerToView:(id)view target:(id)target action:(SEL)actionMethod;
//+(PickerView *)addPickerAtRect:(CGRect)rect caption:(NSString *)caption note:(NSString *)note choices:(NSArray *)ar delegate:(id)delegate addSubViewTo:(id)parentView ynRequiredCaption:(BOOL)ynRequiredCaption validationType:(NSString *)validationType validationNote:(NSString *)validationNote;
//+(PickerView *)addPickerAtRect2:(CGRect)rect caption:(NSString *)caption note:(NSString *)note choices:(NSArray *)ar delegate:(id)delegate addSubViewTo:(id)parentView ynRequiredCaption:(BOOL)ynRequiredCaption validationType:(NSString *)validationType validationNote:(NSString *)validationNote parentViewForPicker:(id)parentViewForPicker;
//+(TextFieldCustom *)addTextFieldAtRect2:(CGRect)rect caption:(NSString *)caption note:(NSString *)note placeholder:(NSString *)placeholder delegate:(id)delegate keyboardType:(int)keyboardType addSubViewTo:(id)parentView ynRequiredCaption:(BOOL)ynRequiredCaption validationType:(NSString *)validationType validationNote:(NSString *)validationNote;
+(void)cleanView:(id)v;
+(void)addBreakAtY:(float)y v:(UIView *)v;
+(UILabel *)addBlurbAtXYwithDefaultFromNote:(float)x y:(float)y view:(UIView *)v note:(NSString *)txtNote fontSize:(float)fontSize ynBold:(BOOL)ynBold;
+(UILabel *)addBlurbSystemFontAtXY:(float)x y:(float)y view:(UIView *)v caption:(NSString *)caption fontSize:(float)fontSize ynBold:(BOOL)ynBold;

+(CGRect)getRectForViewBelowHeaderOfHeight:(float)hHeader;
+(BOOL)isCreditCardOnFile;
+(NSMutableArray *)loadArrayWithCountryCodes:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithCurrency:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithStates:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithCountries:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithMonthsCreditCard:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithYearsCreditCard:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithMakesEV:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithModelsEV:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithYearsEV:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithStations:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithReservations:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithCards:(NSMutableArray *)ar;
+(NSMutableArray *)loadArrayWithPortChoices;
+(NSMutableArray *)loadArrayWithCardChoices;

#pragma mark - input helpers
+(BOOL)textFieldShouldReturn:(UITextField *)textField arFirstResponders:(NSArray *)arFirstResponders;
+(void)textChanged:(id)sender;
+(void)closePickers:(NSArray *)arPickers;
+(void)resignFirstResponders:(NSArray *)arFirstResponders;
+(void)tapped:(UIView *)v scroll:(UIView *)scroll;
+(void)gotFocus:(UIView *)v sender:(id)sender;
+(NSString *)validateInputs2:(NSArray *)arInputs view:(id)v;
+(NSString *)validateInputs:(NSArray *)arInputs;

+(CGRect)getRectForSaveChangesButtonFromImageNamedHeightCentered:(NSString *)imageName view:(id)view;
+(CGRect)getRectForSaveChangesButtonFromImageNamed:(NSString *)imageName view:(id)view;
+(void)resetViewOriginY:(id)v;
+(void)addSwipeRightToViewWithAction:(id)view action:(NSString *)action;
+(NSString *)convertDateToStringMonthDayYear:(NSDate *)date;
//+(PickerDateTime *)addPickerDateTimeAtRect:(CGRect)rect caption:(NSString *)caption note:(NSString *)note choices:(NSArray *)ar delegate:(id)delegate addSubViewTo:(id)parentView parentViewForPicker:(id)parentViewForPicker ynRequiredCaption:(BOOL)ynRequiredCaption validationType:(NSString *)validationType validationNote:(NSString *)validationNote;
+(NSString *)checkReservationsForAvailability:(NSArray *)ar checkReservation:(NSDictionary *)dictCheck ignoreReservation:(NSDictionary *)dictIgnore;
+(NSDate *)dateFromString:(NSString *)strDate;
+(NSString *)convertDateToStringWeekDayAndDate:(NSDate *)date;
+(NSString *)convertDateToStringHoursMinutes:(NSDate *)date;
+(BOOL)overlapTwoReservations:(NSDictionary *)dictReservation1 otherReservation:(NSDictionary *)dictReservation2;
+(BOOL)isTimeBeforeTime:(NSDate *)dateCheck beforeTime:(NSDate *)date;
+(NSString *)convertDateToString:(NSDate *)date;

#pragma mark - Defaults
+(void)resetDefaultsForActivateCard;
+(void)resetDefaultsForConditionalPrompts;
+(void)resetDefaultsForMailingAddress;
+(void)resetDefaultsForNotifications;
+(void)resetDefaultsForPayment;
+(void)resetDefaultsForSignupSignup;
+(void)resetDefaultsForTextAlertView;
+(void)resetDefaultsForYourCar;
+(UIAlertView *)showAlertWithTitle2:(NSString *)title
                            message:(NSString *)message
                           delegate:(id)delegate;
+(void)addSwipeRightBack:(id)target;
+(NSDate *)addMinutesToDate:(NSDate *)date minutes:(int)minutesAdd;
+(NSString *)convertDateToString15Minutes:(NSDate *)date;
+(BOOL)validatePhone10:(NSString *)txt;
+(BOOL)validateZip5:(NSString *)txt;
+(BOOL)isZip5:(NSString *)txt;
+(BOOL)isPhone10:(NSString *)txt;
+(void)alternateBackground:(UIView *)v sequence:(int)sequence;
+(id)addNavigationBarToVC:(id)vc imageName:(NSString *)imageName title:(NSString *)title height:(float)height;

#pragma mark - gte common post header
+(NSDictionary *)getPostHeaderWithCookieForRequest:(NSMutableURLRequest*)request;

#pragma mark - Client info
+(NSString *)getClientName;

#pragma mark - clearUserSessionVariables
+(void)clearUserSessionVariables;

#pragma mark - User Authorization required to access Feature
+(BOOL)userAuthorizationExpired;
@end
