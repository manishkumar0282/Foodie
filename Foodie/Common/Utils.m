//
//  Utils.m
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#define ynResetDefaults 0

#import "CommonHeader.h"
//#import "StationData.h"
#import "LocationManager.h"
//#import "ImageDownloadManager.h"
//#import "UIButton+AFNetworking.h"
//#import "UIImageView+AFNetworking.h"
//#import "FilterModel.h"
//#import "User.h"
#import "TTTLocationFormatter.h"


@implementation Utils : NSObject

#pragma mark -
+(BOOL)isNumericWithSpaces:(NSString *)txt
{
    return NO;
}

#pragma mark - Text Validation
+(BOOL)isTextEmpty:(NSString *)strText
{
    if (!strText)
    {
        return YES;
    }
    
    strText =   [strText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (strText.length == 0)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - Label Height

+(CGSize)calculateLabelSize:(NSString *)messageString
                  labelWidth:(int)labelWidth
                    fontSize:(int)fontSize
{
    CGSize returnsize   =   CGSizeZero;
    
    @try {
        returnsize   =   [messageString sizeWithFont:[UIFont systemFontOfSize:fontSize]
                                   constrainedToSize:CGSizeMake(labelWidth,CGFLOAT_MAX)];
        
//        NSLogInfo(@"calculateLabelSize : %@ \n Height is %f and width is %f",messageString, returnsize.height, returnsize.width);
        
        return returnsize;
    }
        @catch (NSException *exception) {
    
        NSLogError(@"calculateLabelSize exception for %@ - %@",messageString,[exception debugDescription]);
    }
}

//-------------------------------------------------------------------------
// Method:			calculateLabelHeight
//
// Description:		calculate the height for the supplied argument
//
// Parameter:		NSString : messageString
//					int	:	labelWidth
//					int :	fontSize
//-------------------------------------------------------------------------
+(float)calculateLabelHeight:(NSString *)messageString
                  labelWidth:(int)labelWidth
                    fontSize:(int)fontSize
{
    CGSize returnsize   =   CGSizeZero;
    
    @try {
        returnsize  =   [messageString sizeWithFont:[UIFont systemFontOfSize:fontSize]
                                  constrainedToSize:CGSizeMake(labelWidth,300)];
        
        return returnsize.height;
    }
    @catch (NSException *exception) {
        NSLogError(@"calculateLabelHeight exception for %@ - %@",messageString,[exception debugDescription]);
    }
}

//-------------------------------------------------------------------------
// Method:			calculateLabelHeight
//
// Description:		calculate the height for the supplied argument
//
// Parameter:		NSString : messageString
//					int	:	labelWidth
//					int :	fontSize
//-------------------------------------------------------------------------
+(float)calculateLabelWidth:(NSString *)messageString
                  labelWidth:(int)labelWidth
                    fontSize:(int)fontSize
{
    CGSize returnsize   =   CGSizeZero;
    
    @try {
        returnsize   =   [messageString sizeWithFont:[UIFont systemFontOfSize:fontSize]
                                   constrainedToSize:CGSizeMake(labelWidth,300)
                                       lineBreakMode:NSLineBreakByCharWrapping];
        return returnsize.width;
    }
    @catch (NSException *exception) {
        
        NSLogError(@"calculateLabelHeight exception for %@ - %@",messageString,[exception debugDescription]);
    }
}


#pragma mark Height Width for controls
#pragma mark -Button
+(float)getButtonWidth:(UIButton *)but
{
    return [but imageForState:UIControlStateNormal].size.width/2;
}


+(float)getButtonHeight:(UIButton *)but
{
    return [but imageForState:UIControlStateNormal].size.height/2;
}
#pragma mark - Image caching
+(void)initializeImageCache
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:CONST_IMAGE_CACHE_DICTIONARY];
    
    //IF DIRECTORY EXISTS, DELETE IT
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:dataPath error:nil];
    }
    
    //CREATE THE DICTIONARY
    [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
}

#pragma mark - Image
+(float)getImageHeight:(NSString *)imgName
{
    UIImage *img = [UIImage imageNamed:imgName];
    float h = img.size.height;
    if (h == 0) {
        NSLogInfo(@"getImageHeight: h = 0: %@", img.accessibilityIdentifier);
    }
    
    img = nil;
    
    return h;
}

+(float)getImageWidth:(NSString *)imgName
{
    UIImage *img = [UIImage imageNamed:imgName];
    float w = img.size.width;
    if (w == 0) {
        NSLogInfo(@"getImageWidth: w = 0: name - %@ %@",imgName , img.accessibilityIdentifier);
    }
    return w;
}

+(UIImage *)getImage:(NSString *)filename{
    NSError *error;
    UIImage *img;
    img = [UIImage imageNamed:filename];
    
    if (img.size.width == 0)
    {
//        NSLogInfo(@"getImage (local): %@ %.0f x %.0f", filename, img.size.width, img.size.height);
    }
    else
    {
//        NSLogInfo(@"getImage (local): %@ %.0f x %.0f", filename, img.size.width, img.size.height);
    }

    if (error) {
        NSLogInfo(@"getImage: ? %@", [error description]);
    }
    if ([filename.lowercaseString rangeOfString:@".png"].location == NSNotFound) {
        NSLogInfo(@"getImage: ? extension .png missing %@", filename);
    }

    return img;
}
#pragma mark -
#pragma mark Alert View Methods

//-------------------------------------------------------------------------
// Method:			showAlertWithTitle
//
// Description:
//
// Parameter:		NSString :title
//					NSString :message
//					id		 :delegate
//
//-------------------------------------------------------------------------

+(void)showAlertWithTitle:(NSString *)title
				  message:(NSString *)message
				 delegate:(id)delegate
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:delegate
										  cancelButtonTitle:STR_BUTTON_TITLE_OK
										  otherButtonTitles:nil];
	[alert show];
	alert = nil;
}

//-------------------------------------------------------------------------
// Method:			showAlertViewWithTitle
//
// Description:
//
// Parameter:		NSString :title
//					NSString :message
//						id	 :delegate
//					NSString :cancelButtonTitle
//					NSString :otherButtonTitle
//
//-------------------------------------------------------------------------
+(void)showAlertViewWithTitle:(NSString *)title
					  message:(NSString *)message
					 delegate:(id)delegate
			cancelButtonTitle:(NSString *)cancelButtonTitle
			 otherButtonTitle:(NSString *)otherButtonTitle
{
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
												   message:message
												  delegate:delegate
										 cancelButtonTitle:cancelButtonTitle
										 otherButtonTitles:otherButtonTitle, nil];
	
	[alert show];
	
	alert = nil;
}

//-------------------------------------------------------------------------
// Method:			showAlertViewWithTitle
//
// Description:
//
// Parameter:		NSString :title
//					NSString :message
//						id	 :delegate
//					NSString :cancelButtonTitle
//					NSString :otherButtonTitle
//					NSInteger:tag
//-------------------------------------------------------------------------
+(void)showAlertViewWithTitle:(NSString *)title
					  message:(NSString *)message
					 delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle
                          tag:(NSInteger)tag
{
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
												   message:message
												  delegate:delegate
										 cancelButtonTitle:cancelButtonTitle
										 otherButtonTitles:otherButtonTitle, nil];
	
	
	[alert setTag:tag];
	[alert show];
	alert = nil;
}

//-------------------------------------------------------------------------
// Method:			showAlertWithMessageAndTag
//
// Description:
//
// Parameter:		NSString :message
//
//-------------------------------------------------------------------------
+(void)showAlertWithMessageAndTag:(NSString *)message
						 alertTag:(int)alertTag
                            title:(NSString *)title
						 delegate:(id)delegate
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:delegate
										  cancelButtonTitle:STR_BUTTON_TITLE_OK
										  otherButtonTitles:nil];
	[alert setTag:alertTag];
	
	[alert show];
	alert = nil;
}

#pragma mark -
#pragma mark PList file handling

//--------------------------------------------------------------------------------------------------
// getFilePath
// Description: return path to the file in home directory.
//
// Parameters	:	file name
// Return type	:	file path
//
//--------------------------------------------------------------------------------------------------
+(NSString *)getFilePath:(NSString *)fileName
{
	NSArray *filepaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *filePath = nil;
	
	//check for the NSDocumentDirectory array - if it's count is > 0, then the 1st entry will be our path to "Documents"
	if ([filepaths count] > 0)
	{
		NSString *documentDirectory = [filepaths objectAtIndex:0];
		filePath					= [documentDirectory stringByAppendingPathComponent:fileName];
	}
	
	return filePath;
}
//--------------------------------------------------------------------------------------------------
// saveDictionaryDataToFile
// Description: save dictionary data to file.
//
// Parameters	:	file name and dictionary to write
// Return type	:	return TRUE if saved else return false
//
//---------------------------------------------------------------------------------------------------
+(NSDictionary *)loadUserEvatar
{
    return [Utils readFromPlist:@"EvatarUserCaching.plist" keyName:@"CachedUserEvatarDictionary"];
}
+(BOOL)saveUserEvatar:(NSDictionary *)dict
{
    return [Utils saveDictionaryDataToFile:@"EvatarUserCaching.plist" dict:dict];
}

+(NSDictionary *)loadVehicleData
{
    return [Utils readFromPlist:@"VehicleCaching.plist" keyName:@"CachedVehicleDictionary"];
}
+(BOOL)saveVehicleData:(NSDictionary *)dict
{
    return [Utils saveDictionaryDataToFile:@"VehicleCaching.plist" dict:dict];
}

+(NSDictionary *)loadEvatars
{
    return [Utils readFromPlist:@"EvatarCaching.plist" keyName:@"CachedEvatarDictionary"];
}
+(BOOL)saveEvatars:(NSDictionary *)dict
{
    return [Utils saveDictionaryDataToFile:@"EvatarCaching.plist" dict:dict];
}

+(BOOL)saveDictionaryDataToFile:(NSString *)fileName dict:(NSDictionary *)dictData
{
	NSString *filePath	= [self getFilePath:fileName];
	BOOL result			= FALSE;
	
	if (filePath != nil)
	{
        __unused NSError *error = nil;
		result = [dictData writeToFile:filePath atomically:YES];
	}
	
	return result;
}

//-------------------------------------------------------------------------
// Method:			writeToPList
//
// Description:		return the path of the data file
//
// Parameter:		NSString	:fileName
//
//-------------------------------------------------------------------------
+ (NSString *)dataFilePath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *filePath = [[NSString alloc] init];
	if([paths count] > 0)
	{
		NSString *documentsDirectory = [paths objectAtIndex:0];
		filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
	}
	return filePath;
}


//-------------------------------------------------------------------------
// Method:			writeToPList
//
// Description:		Write contents to file
//
// Parameter:		NSString	:fileName
//					NSString	:keyName
//					NSDictionary:contentsDictionary
//
//-------------------------------------------------------------------------
+(BOOL)writeToPList:(NSString *)fileName keyName:(NSString *)keyName contents:(NSDictionary *)contentsDictionary
{
	//get the address of property list
	NSString *filePath = [self dataFilePath:fileName];
	
	//retrieve main dictionary
	NSMutableDictionary *userDataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	
	//retrieve the current dictionary
	
	NSMutableDictionary *previousDictionary = [[NSDictionary dictionaryWithDictionary:userDataDictionary ]objectForKey:keyName];
	
	//remove the current dictionary from main dictionary
	[userDataDictionary removeObjectForKey:keyName];
	
	//retrieve the keys and values for the desired dictionar
	for(id aKey in [previousDictionary allKeys])
	{
//		NSLogInfo(@"Write to Property List %@ = %@",aKey, [contentsDictionary objectForKey:aKey]);
        if ([contentsDictionary objectForKey:aKey])
        {
            [previousDictionary removeObjectForKey:aKey];
            [previousDictionary setObject:[Utils validateString:[contentsDictionary objectForKey:aKey]] forKey:aKey];
        }
	}
	
	//add the updated dictionary to the main dictionary
	[userDataDictionary setObject:previousDictionary forKey:keyName];
	
	//write the main dictionary back to the property list
	BOOL result			= FALSE;
	
	if (filePath != nil)
	{
		result = [userDataDictionary writeToFile:filePath atomically:YES];
	}
	
	userDataDictionary = nil;
	previousDictionary = nil;
	
	return result;
}

//-------------------------------------------------------------------------
// Method:			writeToPList
//
// Description:		Get the current contents of the file
//
// Parameter:		NSString	:fileName
//					NSString	:keyName
//
//-------------------------------------------------------------------------
+(NSDictionary *)readFromPlist:(NSString *)fileName keyName:(NSString *)keyName
{
	NSString *filePath = [self dataFilePath:fileName];
	
	NSDictionary *dictionary = nil;//[[NSDictionary alloc] init];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
	{
		NSMutableDictionary	* tempDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
		dictionary = [NSDictionary dictionaryWithDictionary:[tempDict objectForKey:keyName]];
		tempDict = nil;
	}
	return dictionary;
}

//-------------------------------------------------------------------------
// Method:			fileExistsAtPath
//
// Description:		chec if file with fileName exists
//
// Parameter:		NSString	:fileName
//
//-------------------------------------------------------------------------
+(BOOL)fileExistsAtPath:(NSString *)fileName
{
    NSString *filePath = [self dataFilePath:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath])
    {
//        NSLogInfo(@"Image exists at %@",filePath);
        return YES;
    }
    
    NSLogInfo(@"Image needs to be downloaded %@",filePath);
    return NO;
}
//-------------------------------------------------------------------------
// Method:			writeFileToDisk
//
// Description:		write file with fileName to disk
//
// Parameter:		NSString	:fileName
//
//-------------------------------------------------------------------------
+(BOOL)writeFileToDisk:(NSString *)fileName fileData:(NSData*)fileData
{
    NSString *filePath = [self dataFilePath:fileName];
    NSLogInfo(@"write at path %@",filePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:filePath])
    {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        BOOL success    =   [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
        fileManager = nil;
        return success;
        //       return [fileData writeToFile:filePath atomically:YES];
    }
    return NO;
}

+ (void)deletePList:(NSString*)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSError *error;
    if(![[NSFileManager defaultManager] removeItemAtPath:path error:&error])
    {
        //TODO: Handle/Log error
    }
}

#pragma mark - Image
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//-(UIImage *)getImage:(NSString *)filename{
//    NSError *error;
//    UIImage *img;
//    if (!self.ynUseLocalWebContent.boolValue) {
//        NSString *urlString = [NSString stringWithFormat:@"%@%@", [self getUrlWebContent], filename];
//        img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
//        NSLogInfo(@"getImage: (web) %@\n%.0fx%.0f", urlString, img.size.width, img.size.height);
//    } else {
//        img = [UIImage imageNamed:filename];
//        if (img.size.width == 0) {
//            NSLogInfo(@"getImage (local): %@ %.0f x %.0f", filename, img.size.width, img.size.height);
//        } else {
//            //            NSLogInfo(@"getImage (local): %@ %.0f x %.0f", filename, img.size.width, img.size.height);
//        }
//    }
//    if (error) {
//        NSLogInfo(@"getImage: ? %@", [error description]);
//    }
//    if ([filename.lowercaseString rangeOfString:@".png"].location == NSNotFound) {
//        NSLogInfo(@"getImage: ? extension .png missing %@", filename);
//    }
//    [img setAccessibilityIdentifier:filename];
//    
//    [self addImageListUnique:filename image:img];
//    return img;
//}


#pragma mark - Text Methods
+(NSString *)validateString:(NSString *)strToValidate
{
	NSString *validString = nil;
	if (strToValidate != ( NSString *) [ NSNull null ] && strToValidate != nil)
	{
		validString = strToValidate;
	}
	else
	{
		validString = @"";
	}
	return validString;
}


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
						   textSize:(NSInteger)textSize
{
	UILabel *label = [[UILabel alloc]initWithFrame:rect];
	[label setFont:[UIFont boldSystemFontOfSize:textSize]];
	[label setText:title];
	[label setTextAlignment:textAlignment];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor blackColor]];
	
	return label;
}

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
							 textSize:(NSInteger)textSize
{
	UILabel *label = [[UILabel alloc]initWithFrame:rect];
	[label setFont:[UIFont systemFontOfSize:textSize]];
	[label setText:title];
	[label setTextAlignment:textAlignment];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor blackColor]];
//	[label setLineBreakMode:UILineBreakModeWordWrap];
	[label setNumberOfLines:10];
	return label;
}

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
							 textSize:(NSInteger)textSize
{
	UILabel *label = [[UILabel alloc]initWithFrame:rect];
	[label setFont:[UIFont italicSystemFontOfSize:textSize]];
	[label setText:title];
	[label setTextAlignment:textAlignment];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor blackColor]];
	
	return label;
}



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
							  numberOfLines:(NSInteger)lines
{
	UILabel *label = [[UILabel alloc]initWithFrame:rect];
	[label setFont:[UIFont  boldSystemFontOfSize:CONST_FONT_SIZE_FIFTEEN_POINTS]];
	[label setText:title];
	[label setTextAlignment:textAlignment];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor blackColor]];
	[label setNumberOfLines:lines];
	
	return label;
}

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
{
    
	UILabel *textLabel = [[UILabel alloc] initWithFrame:labelRect];
	[textLabel setText:labelText];
	[textLabel setBackgroundColor:bgColor];
	[textLabel setTextColor:textColor];
    [textLabel setTextAlignment:NSTextAlignmentLeft];
	[textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [textLabel setNumberOfLines:0];
	if (isTextBold)
	{
		[textLabel setFont:[UIFont boldSystemFontOfSize:labelTextFontSize]];
	}
	else
	{
		[textLabel setFont:[UIFont systemFontOfSize:labelTextFontSize]];
	}
	
	
	return textLabel;
}

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
			 numberOfLines:(int)numberOfLines
{
	UILabel *textLabel = [[UILabel alloc] initWithFrame:labelRect];
	[textLabel setBackgroundColor:bgColor];
	[textLabel setTextColor:textColor];
	if (isTextBold)
	{
		[textLabel setFont:[UIFont boldSystemFontOfSize:labelTextFontSize]];
	}
	else
	{
		[textLabel setFont:[UIFont systemFontOfSize:labelTextFontSize]];
	}
	
	[textLabel setNumberOfLines:numberOfLines];
	
	return textLabel;
}

+(UILabel*)createErrorMessage:(NSString *)errorMessage
{
    UILabel  *lblError   =   [Utils createTextLabel:CGRectZero
                                               text:errorMessage
                                    backGroundColor:[UIColor clearColor]
                                          textColor:[UIColor redColor]
                                         isTextBold:NO
                                           fontSize:CONST_FONT_SIZE_TEN_POINTS];
    
    UIFont *errorFont   =   [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_LIGHT
                                            size:CONST_FONT_SIZE_TEN_POINTS];
    [lblError setFont:errorFont];
    return lblError;
}

+(UILabel*)createCaptionMessage:(NSString *)captionMessage
{
    UILabel  *lblCaption   =   [Utils createTextLabel:CGRectZero
                                                 text:captionMessage
                                      backGroundColor:[UIColor clearColor]
                                            textColor:[UIColor whiteColor]
                                           isTextBold:NO
                                             fontSize:TEXTFIELD_CAPTION_FONT_SIZE];
    
    UIFont *lblCaptionFont   =   [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_LIGHT
                                                 size:TEXTFIELD_CAPTION_FONT_SIZE];
    [lblCaption setFont:lblCaptionFont];
    return lblCaption;
}

#pragma mark - Button Methods
+(UIButton*)createButtonWithImage:(NSString *)btnImg
                             rect:(CGRect)btnRect
                         delegate:(id)btnDelegate
                     actionMethod:(SEL)actionMethod
                           btnTag:(int)btnTag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:btnRect];
	[button setBackgroundImage:[UIImage imageNamed:btnImg] forState:UIControlStateNormal];
	[button addTarget:btnDelegate
               action:actionMethod
     forControlEvents:UIControlEventTouchUpInside];
    [button setTag:btnTag];
    return button;
}

+(UIButton*)createButtonWithImage:(NSString *)btnImg
             highlightedImageName:(NSString *)highlightedImage
                             rect:(CGRect)btnRect
                         delegate:(id)btnDelegate
                     actionMethod:(SEL)actionMethod
                           btnTag:(int)btnTag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:btnRect];
	[button setBackgroundImage:[UIImage imageNamed:btnImg]
                      forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage]
                      forState:UIControlStateHighlighted];
	[button addTarget:btnDelegate
               action:actionMethod
     forControlEvents:UIControlEventTouchUpInside];
    [button setTag:btnTag];
    return button;
}

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
						  actionMethod:(SEL)action
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:rect];
	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:fontColor forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:titleFontSize]];
    [[button titleLabel] setTextAlignment:NSTextAlignmentCenter];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	return button;
}

+(UIButton *)createButtonWithImageAndText:(NSString *)title
                        titleFontColor:(UIColor*)fontColor
                         titleFontSize:(CGFloat)titleFontSize
                         normalImage:(NSString *)normalImage
                         highlightedImage:(NSString *)strHighlightedImage
								  rect:(CGRect)rect
							  delegate:(id)delegate
						  actionMethod:(SEL)action
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:rect];
	[button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:strHighlightedImage] forState:UIControlStateHighlighted];
	[button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];

    [button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:fontColor forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:titleFontSize]];
    [[button titleLabel] setTextAlignment:NSTextAlignmentCenter];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	return button;
}

//-------------------------------------------------------------------------
// Method:			createButtonWithStretchedImageName
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
+(UIButton *)createButtonWithStretchedImageName:(NSString *)title
                        titleFontColor:(UIColor*)fontColor
                         titleFontSize:(CGFloat)titleFontSize
							 imageName:(UIImage *)image
								  rect:(CGRect)rect
							  delegate:(id)delegate
						  actionMethod:(SEL)action
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:rect];
	[button setImage:image forState:UIControlStateNormal];
	[button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];

    [button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:fontColor forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:titleFontSize]];
    [[button titleLabel] setTextAlignment:NSTextAlignmentCenter];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	return button;
}

+(CGSize)calcualteButtonSizeWithText:(NSString *)btnText
                            fontSize:(CGFloat)fontSize
{
    CGSize  btnSize =   [Utils calculateLabelSize:btnText
                                       labelWidth:CGFLOAT_MAX
                                         fontSize:fontSize];
    CGSize  modifiedSize    =   CGSizeMake(btnSize.width + 4*CONST_DEFAULT_PADDING, btnSize.height+2*CONST_DEFAULT_PADDING);
    return modifiedSize;
}

#pragma mark - Font Color 
+(UIColor *)getColorLight
{
    return [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1];
}

+(UIColor *)getColorDark
{
    return [UIColor colorWithRed:.25 green:.25 blue:.25 alpha:1];
}

+(UIColor *)getColorMedium
{
    return [UIColor colorWithRed:.35 green:.35 blue:.35 alpha:1];
}

#pragma mark - create Table Methods
+(UITableView*)getGroupedTable:(CGRect)tableFrame
					  delegate:(id)delegate
{
	UITableView *tableView	=	[[UITableView alloc]initWithFrame:tableFrame style:UITableViewStyleGrouped];
	tableView.delegate = delegate;
	tableView.dataSource = delegate;
	tableView.scrollEnabled = YES;
	[tableView setBackgroundColor:[UIColor clearColor]];
	return	tableView;
}

+(UITableView*)getPlainStyleTable:(CGRect)tableFrame
                         delegate:(id)delegate
{
	UITableView *tableView	=	[[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
	tableView.delegate = delegate;
	tableView.dataSource = delegate;
	tableView.scrollEnabled = YES;
	[tableView setBackgroundColor:[UIColor clearColor]];
	return	tableView;
}

+(void)setTransparentBackgroundForTableView:(UITableView *) tbl
{
	[tbl setBackgroundColor:[UIColor clearColor]];
	[tbl setBackgroundView:nil];
    [tbl setBackgroundView:[[UIView alloc] init]];
}

#pragma mark - Log the frame
+(void)logTheFrameForControl:(id)control
{
    if ([control isKindOfClass:[UIView class]]) {
       UIView *view =   (UIView*)control;
            NSLogInfo(@"Frame for control %@ coordinates are : x = %f y = %f w = %f h = %f", [view description],view.frame.origin.x, view.frame.origin.y, view.frame.size.width,view.frame.size.height);
    }

    
}

#pragma mark - Utility Methods
+(void)printKeyValuesForDictionary:(NSDictionary *)dictToPrint
{
    for (NSString *key in dictToPrint)
    {
        NSLogInfo(@"Key = %@ Value = %@",key,[dictToPrint objectForKey:key]);
    }
}

#pragma mark - Conversion methods
+(NSString *)formatDoubleValueToRender:(NSNumber*)numberToRender
{
    NSNumberFormatter   *nsNumberFormatter  =   [[NSNumberFormatter alloc] init];
    [nsNumberFormatter setMinimumIntegerDigits:0];
    [nsNumberFormatter setMaximumFractionDigits:2];
    NSString *str   =   [nsNumberFormatter stringFromNumber:numberToRender];
    
//    NSLogInfo(@"%s : original value - %f, Modified value - %@",__FUNCTION__,numberToRender.floatValue,str);
    return str;
}

+(NSString *)formatDoubleValueToRender:(NSNumber*)numberToRender
           minimumDigitsBeforeDecimal:(int)minimumDigitsBeforeDecimal
           maximumDigitsAfterDecimal:(int)maximumDigitsAfterDecimal
           minimumDigitsAfterDecimal:(int)minimumDigitsAfterDecimal
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumIntegerDigits:minimumDigitsBeforeDecimal];
    [formatter setMinimumFractionDigits:minimumDigitsAfterDecimal];
    [formatter setMaximumFractionDigits:maximumDigitsAfterDecimal];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:numberToRender];
    return numberString;
}

+(NSNumber*)convertMeterToMiles:(NSNumber*)distanceInMeters
{
    double numberToConvert  =   distanceInMeters.doubleValue;
    numberToConvert =   numberToConvert * CONST_METER_TO_KM_CONVERTING_FACTOR;
    numberToConvert =   numberToConvert * CONST_KM_TO_MILES_CONVERTING_FACTOR;
//    NSLogInfo(@"Distance is %f",numberToConvert);
    NSNumber    *desiredValue    =   [NSNumber numberWithDouble:numberToConvert];
    return desiredValue;
}

+(NSNumber *)convertFeetToMeters:(NSNumber*)distanceInFeet
{
    double numberToConvert  =   distanceInFeet.doubleValue;
    numberToConvert =   numberToConvert * 0.3048;
    
    NSNumber    *desiredValue    =   [NSNumber numberWithDouble:numberToConvert];
    return desiredValue;
    
}

+(NSNumber*)convertFeetToMiles:(NSNumber*)distanceInFeet
{
    double numberToConvert  =   distanceInFeet.doubleValue;
    numberToConvert =   numberToConvert * 0.000189394;

    NSNumber    *desiredValue    =   [NSNumber numberWithDouble:numberToConvert];
    return desiredValue;
}

+ (NSString *)distanceShortString:(CLLocationDistance)distance
{
    TTTLocationFormatter *locationFormatter = [[TTTLocationFormatter alloc] init];
    [locationFormatter setUnitSystem:TTTImperialSystem];
    NSString *strDistance = [locationFormatter stringFromDistance:distance];
    strDistance = [strDistance stringByReplacingOccurrencesOfString:@"miles" withString:@"mi"];
    strDistance = [strDistance stringByReplacingOccurrencesOfString:@"mile" withString:@"mi"];
    return strDistance;
}

+ (NSString *)distanceLongString:(CLLocationDistance)distance
{
    TTTLocationFormatter *locationFormatter = [[TTTLocationFormatter alloc] init];
    [locationFormatter setUnitSystem:TTTImperialSystem];
    NSString *strDistance = [locationFormatter stringFromDistance:distance];
    strDistance = [strDistance stringByReplacingOccurrencesOfString:@"ft" withString:@"feet"];
    strDistance = [strDistance stringByReplacingOccurrencesOfString:@"yds" withString:@"yards"];
    return strDistance;
}

#pragma mark - Date Formatting Methods
+(NSString *)convert24HourTo12HourFormat:(NSString *)strDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = CONST_24HOUR_HOUR_MINUTE_FORMAT;
    NSDate *date = [dateFormatter dateFromString:strDate];
    
    dateFormatter.dateFormat = CONST_12HOUR_HOUR_AM_PM_FORMAT;
    NSString *pmamDateString = [dateFormatter stringFromDate:date];
    
    NSLogInfo(@"%@", pmamDateString);
    return pmamDateString;
}

//-------------------------------------------------------------------------
// Method:			validateString
//
// Description:		validate the given string if it is proper String
//
// Parameter:		strToValidate:NSString
//--------------------------------------------------------------------------
+(NSString *)formatDateToString:(NSDate*)date format:(NSString *)stringFormat
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:stringFormat];
	[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
	NSString *dateString = [dateFormatter stringFromDate:date];
	
	dateFormatter = nil;
	
	return dateString;
}

+(NSString *) Convert24hourFormatDateTo12hourFormatFromDate:(NSString *) strDate
{
    //First convert string date to NSDate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:CONST_RESERVATION_DATE_FORMAT]; // "3:19 PM"
    NSDate *dtDate = [formatter dateFromString:strDate];
    
    NSString *strNewDate=[self formatDateToString:dtDate format:CONST_RESERVATION_DATE_DISPLAY_FORMAT];
    
    return strNewDate;
    
}

#pragma mark - Location Manager class methods

+(void)saveLocationInUserDefaultsAsLastKnownCurrentLocation:(CLLocationCoordinate2D)foundLocation
{
//    NSLogInfo(@"location to be saved = %f, %f",foundLocation.latitude, foundLocation.longitude);

    NSMutableDictionary    *dictLocationInfo    =   [[NSMutableDictionary alloc] init];
    [dictLocationInfo setObject:[NSNumber numberWithDouble:foundLocation.latitude] forKey:CONST_KEY_SAVED_LATITUDE];
    [dictLocationInfo setObject:[NSNumber numberWithDouble:foundLocation.longitude] forKey:CONST_KEY_SAVED_LONGITUDE];

    if (dictLocationInfo)
    {
        //write contents to property list
        BOOL result = [Utils writeToPList:CONST_COULOMBTECH_PREFERENCE_FILE keyName:CONST_CURRENT_LOCATION_DICTIONARY contents:dictLocationInfo];

        if (result) {
        }

        dictLocationInfo = nil;
    }
}

+(CLLocation*)getSavedCLLocation
{
    NSDictionary *dictCurrentLocation    =   [Utils readFromPlist:CONST_COULOMBTECH_PREFERENCE_FILE
                                                  keyName:CONST_CURRENT_LOCATION_DICTIONARY];

    //get lat from dict
    double  lat =   [[dictCurrentLocation objectForKey:CONST_KEY_SAVED_LATITUDE] doubleValue];
    double  lon =   [[dictCurrentLocation objectForKey:CONST_KEY_SAVED_LONGITUDE] doubleValue];
    
//    double lat  =   [[[NSUserDefaults standardUserDefaults] objectForKey:CONST_KEY_SAVED_LATITUDE] doubleValue];
//    double  lon =   [[[NSUserDefaults standardUserDefaults] objectForKey:CONST_KEY_SAVED_LONGITUDE] doubleValue];

    CLLocation  *savedLocation  =   [[CLLocation alloc] initWithLatitude:lat
                                                               longitude:lon];
    return savedLocation;
}

+(CLLocationCoordinate2D)getSavedCLLocationCoordinate2D
{
//    double lat  =   [[[NSUserDefaults standardUserDefaults] objectForKey:CONST_KEY_SAVED_LATITUDE] doubleValue];
//    double  lon =   [[[NSUserDefaults standardUserDefaults] objectForKey:CONST_KEY_SAVED_LONGITUDE] doubleValue];
    NSDictionary *dictCurrentLocation    =   [Utils readFromPlist:CONST_COULOMBTECH_PREFERENCE_FILE
                                                          keyName:CONST_CURRENT_LOCATION_DICTIONARY];
    
    //get lat from dict
    double  lat =   [[dictCurrentLocation objectForKey:CONST_KEY_SAVED_LATITUDE] doubleValue];
    double  lon =   [[dictCurrentLocation objectForKey:CONST_KEY_SAVED_LONGITUDE] doubleValue];

    CLLocationCoordinate2D savedLocation  =   CLLocationCoordinate2DMake(lat, lon);
    
    return savedLocation;
}

+(BOOL)isLastKnownUserLocationAvailableinNSUserDefault
{
    //check if user defaults contains key/value pair for the particular requirement.
    //1. check for saved current location value in nsuserdefaults
    BOOL isLastKnownUserLocationAvailable = NO;
    NSDictionary *dictCurrentLocation    =   [Utils readFromPlist:CONST_COULOMBTECH_PREFERENCE_FILE
                                                          keyName:CONST_CURRENT_LOCATION_DICTIONARY];

//    if ([[NSUserDefaults standardUserDefaults] objectForKey:CONST_KEY_SAVED_LATITUDE] &&
//        [[NSUserDefaults standardUserDefaults] objectForKey:CONST_KEY_SAVED_LONGITUDE])
    if ([dictCurrentLocation objectForKey:CONST_KEY_SAVED_LATITUDE] &&
        [dictCurrentLocation objectForKey:CONST_KEY_SAVED_LONGITUDE])
    {
        isLastKnownUserLocationAvailable    =   YES;
        NSLogInfo(@"saved latitide = %f", [[dictCurrentLocation objectForKey:CONST_KEY_SAVED_LATITUDE] doubleValue]);
        NSLogInfo(@"saved longitude = %f", [[dictCurrentLocation objectForKey:CONST_KEY_SAVED_LONGITUDE] doubleValue]);
    }
    
    return isLastKnownUserLocationAvailable;
}

+(void)initLocationServices:(id)sender
{
    LocationManager *locationManager =   [LocationManager sharedInstance];
    [locationManager setDelegate:sender];
    [locationManager startUpdatingLocation];
}

+(void)addShadow:(id)obj{
    [[obj layer] setShadowColor:[UIColor darkGrayColor].CGColor];
    [[obj layer] setShadowOffset:CGSizeMake(0, 1)];
    [[obj layer] setShadowOpacity:.5];
    [[obj layer] setShadowRadius:1.0];
    
    [obj setClipsToBounds:NO];
}

+(void)addHighlight:(id)obj{
    [[obj layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[obj layer]setShadowOffset:CGSizeMake(3, 3)];
    [[obj layer] setShadowOpacity:1];
    [[obj layer] setShadowRadius:6.0];
    
    [obj setClipsToBounds:NO];
}

+(void)removeHighlight:(id)obj{
    [[obj layer] setShadowColor:[UIColor clearColor].CGColor];
    [[obj layer] setShadowOffset:CGSizeMake(0, 0)];
    [[obj layer] setShadowOpacity:0];
    [[obj layer] setShadowRadius:0.0];
    
    [obj setClipsToBounds:NO];
}

+(float)getWW{
    float ww;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        ww = [[UIScreen mainScreen] bounds].size.height;
        BOOL ynPortraitOnly = [[Utils loadObjFromDefaultsByName:@"ynPortraitOnly"] boolValue];
        if (ynPortraitOnly) {
            ww = [[UIScreen mainScreen] bounds].size.width;
        }
    } else {
        ww = [[UIScreen mainScreen] bounds].size.width;
    }
    return ww;
}

+(float)getHH{
    float hh;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        hh = [[UIScreen mainScreen] bounds].size.width;
        BOOL ynPortraitOnly = [[Utils loadObjFromDefaultsByName:@"ynPortraitOnly"] boolValue];
        if (ynPortraitOnly) {
            hh = [[UIScreen mainScreen] bounds].size.height;
        }
    } else {
        hh = [[UIScreen mainScreen] bounds].size.height;
    }
    return hh;
}

+(float)getHHScroll{
    float hh;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        hh = [[UIScreen mainScreen] bounds].size.width;
        BOOL ynPortraitOnly = [[Utils loadObjFromDefaultsByName:@"ynPortraitOnly"] boolValue];
        if (ynPortraitOnly) {
            hh = [[UIScreen mainScreen] bounds].size.height;
        }
    } else {
        hh = [[UIScreen mainScreen] bounds].size.height;
    }
    
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    hh = hh - statusBarHeight;
    return hh;
}

+(BOOL)isStatusVisible{
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    if (statusBarHeight == 0) {
        return NO;
    } else {
        return YES;
    }
}
    
+(float)getYScroll{
    float y = 0;
//    if ([self isIOS7] && [self isStatusVisible]) {
//        y = 20;
//    }
    return y;
}

+(void)animationOn{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:CONST_ANIMATION_DURATION];
}

+(void)animationOff{
    [UIView commitAnimations];
}

+(UIImageView *)createRoundCornerAndShadowCallout:(UIView *)iv{
    CALayer * l;
    l = [iv layer];
    [l setMasksToBounds:YES];
    
    [l setCornerRadius:8];
    [l setBorderWidth:0];
    [l setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [iv removeFromSuperview];
    UIImageView *iv2 = [[UIImageView alloc] initWithFrame:iv.frame];
    iv.frame = CGRectMake(0, 0, iv.frame.size.width, iv.frame.size.height);
    [iv2 addSubview:iv];
    
    l = [iv2 layer];
    [l setMasksToBounds:NO];
    
    [l setShadowColor:[UIColor darkGrayColor].CGColor];
    [l setShadowOffset:CGSizeMake(0, 5)];
    [l setShadowOpacity:1];
    [l setShadowRadius:5.0];
    return iv2;
}

+(void)addShadowCallout:(id)obj{
    [[obj layer] setShadowColor:[UIColor darkGrayColor].CGColor];
    [[obj layer]setShadowOffset:CGSizeMake(0, 5)];
    [[obj layer] setShadowOpacity:.75];
    [[obj layer] setShadowRadius:2.0];
    
    [obj setClipsToBounds:NO];
}


+(void)roundCorner:(UIView *)v color:(UIColor *)color{
    CALayer * l;
    l = [v layer];
    [l setMasksToBounds:YES];
    
    float h = v.frame.size.height;
    if (color == nil) {
        [l setCornerRadius:4];
        [l setBorderColor:[[UIColor clearColor] CGColor]];
        return;
    }
    if (color == [UIColor blackColor]) {
        [l setCornerRadius:6];
        [l setBorderColor:[[UIColor colorWithRed:.25 green:.25 blue:.25 alpha:.35] CGColor]];
        [l setBorderWidth:4];
        return;
    }
    if (color == [UIColor purpleColor])  //purple color
    {
        [l setCornerRadius:4];
        [l setBorderColor:[[UIColor colorWithRed:.25 green:.25 blue:.25 alpha:.35] CGColor]];
        [l setBorderWidth:2];
        return;
    }
    if (color == [UIColor whiteColor]) {
        [l setCornerRadius:10];
        [l setBorderColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:.35] CGColor]];
        [l setBorderWidth:3.0];
        return;
    }
    if (color == [UIColor blueColor]) {
        [l setCornerRadius:3];
        [l setBorderColor:nil];
        [l setBorderWidth:0];
        return;
    }
    if (color == [UIColor grayColor]) {
        [l setCornerRadius:4];
        [l setBorderColor:[[UIColor grayColor] CGColor]];
        [l setBorderWidth:2];
        return;
    }
    [l setCornerRadius:h/6];
    [l setBorderColor:[color CGColor]];
    [l setBorderWidth:1.0];
}

+(void)unRoundCorner:(UIView *)v color:(UIColor *)color{
    CALayer * l;
    l = [v layer];
    [l setMasksToBounds:YES];
    
    [l setCornerRadius:0];
    [l setBorderColor:[[UIColor clearColor] CGColor]];
    [l setBorderWidth:0];
}

+(id)loadObjFromDefaultsByName:(NSString *)name{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id objAnswer = [defaults objectForKey:name];
    [defaults synchronize];
    NSLogInfo(@"load defaults: %@: %@", name, objAnswer);
    return objAnswer;
}

+(void)clearUserDefaults
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

+(void)saveObjToDefaults:(id)obj name:(NSString *)name{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:name];
    NSLogInfo(@"save defaults: %@: %@", name, obj);
    [defaults synchronize];
}

+(void)clearObjForKeyFromDefaults:(NSString *)name{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:name];
    [defaults synchronize];
}

+(BOOL)isIphone5{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            return NO;
        }
        if(result.height == 568)
        {
            // iPhone 5
            return YES;
        }
    }
    return NO;
}

+(float)getDistanceMiles:(CLLocationCoordinate2D)loc1 toLoc:(CLLocationCoordinate2D)loc2{
    float dLat = loc2.latitude - loc1.latitude;
    float dLon = loc2.longitude - loc1.longitude;
    
    float dist = sqrtf((dLat * dLat) + (dLon * dLon));

    dist = dist * 69.11;
    return dist;
}

#pragma mark - Screen Pixel density
+(CGFloat)getPointToPixelConversionFactor
{
    CGFloat pointTOPixelFactor  =   [[UIScreen mainScreen] scale];
    if (pointTOPixelFactor == CGFLOAT_MIN)
    {
        pointTOPixelFactor  =   1;
    }
    return pointTOPixelFactor;
}

#pragma mark - 
+(void)roundCornerWV:(UIView *)v
{
    CALayer * l;
    l = [v layer];
    [l setMasksToBounds:YES];
    
    [l setCornerRadius:4];
    [l setBorderColor:[[UIColor clearColor] CGColor]];
    [l setBorderWidth:1.0];
}
+(NSString *)getTemporaryMessage
{
    NSString *txtHtml;
    static int cnt = 0;
    cnt++;
//    if ((cnt % 2) == 0) {
//        txtHtml = @"<font face=arial size=2 color=ffffff><center>";
//        txtHtml = [txtHtml stringByAppendingString:@"<img style=position:absolute;left:0;top:0; src=settings_message.png width=75>"];
//        txtHtml = [txtHtml stringByAppendingString:@"Sign up for bonus points<br>as you drive."];
//    } else {
        txtHtml = @"";
        txtHtml = [txtHtml stringByAppendingString:@"<img style=position:absolute;left:-7;top:-5; src=settings_message.png width=75>"];
        txtHtml = [txtHtml stringByAppendingString:@"<span style=font-family:GothamNarrow-Book;font-size:12;color:ffffff;position:absolute;left:60;top:8;>"];
    txtHtml = [txtHtml stringByAppendingString:@"Welcome to the ChargePoint 5.0 mobile app !!</span>"];//Complete your profile to take<br>full advantage of ChargePoint</span>"];
//    }
    return txtHtml;
}

+(void)moveView:(UIView *)view x:(float)dx y:(float)dy{
    CGRect frame = view.frame;
    view.frame = CGRectMake(frame.origin.x + dx, frame.origin.y + dy, frame.size.width, frame.size.height);
}
#pragma mark - Validate location
+(BOOL)isLocationValid:(CLLocation*)referenceLocation
{
    NSLogInfo(@"Lat - %f, Lon - %f",referenceLocation.coordinate.latitude, referenceLocation.coordinate.longitude);
//    if (CLLocationCoordinate2DIsValid(referenceLocation.coordinate))
//    {
//        return YES;
//    }
//

    if (CLLocationCoordinate2DIsValid(referenceLocation.coordinate))
    {
        if (referenceLocation.coordinate.latitude != 0 && referenceLocation.coordinate.longitude != 0)
        {
            return  YES;
        }
    }

    return  NO;
}
+(BOOL)isLocationCoordinateValid:(CLLocationCoordinate2D)locationCoordinate
{
    if (locationCoordinate.latitude && locationCoordinate.longitude)
    {
        return  YES;
    }
    
    return  NO;
}

+(void)rotateLandscapeToPortrait:(UIView *)v{
    v.transform = CGAffineTransformMakeRotation(90/57.29);
    float dx = -20;
    float dy = -[Utils getHH];
    v.transform = CGAffineTransformTranslate(v.transform, dx, dy);
}

+(UILabel *)addBackBorder:(CGRect)rect view:(UIView *)v{
    float w = rect.size.width;
    float h = rect.size.height;
    float y = rect.origin.y;
    float x = rect.origin.x;
    
    float c = 1;
    UIColor *backgroundColor = [UIColor colorWithRed:c green:c blue:c alpha:.75];
    UILabel *labBorder = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    labBorder.backgroundColor = backgroundColor;
    [Utils roundCorner:labBorder color:[UIColor blackColor]];
    [v addSubview:labBorder];
    [v bringSubviewToFront:labBorder];
    return labBorder;
}

+(UILabel *)addCaption:(CGRect)rect view:(UIView *)v caption:(NSString *)caption{
    float w = rect.size.width;
    __unused float h = rect.size.height;
    float y = rect.origin.y;
    float x = rect.origin.x;
    float hCaption = 19;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x + 2, y - hCaption, w, hCaption)];
    UIFont *font = [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_BOOK size:15];
    lab.font = font;
    lab.textColor = [UIColor whiteColor];
    lab.text = caption;
    lab.backgroundColor = [UIColor clearColor];
    
    [Utils addShadow:lab];
    [v addSubview:lab];
    return lab;
}

+(UILabel *)addCaptionBelow:(CGRect)rect view:(UIView *)v caption:(NSString *)caption{
    float w = rect.size.width;
    float h = rect.size.height;
    float y = rect.origin.y + h;
//    UIFont *font = [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_BOOK size:15];
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    float wText = [caption sizeWithFont:font].width;
    float hText = [caption sizeWithFont:font].height;
    float x = rect.origin.x + (w - wText)/2;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x + 2, y, wText, hText)];
    lab.font = font;
    lab.textColor = [UIColor whiteColor];
    lab.text = caption;
    lab.backgroundColor = [UIColor clearColor];
    
    [Utils addShadow:lab];
    [v addSubview:lab];
    return lab;
}

+(void)addRequiredFields:(CGRect)rect view:(UIView *)v{
    float w = rect.size.width;
    float y = rect.origin.y;
    UIFont *font = [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_BOOK size:10];
    NSString *title = STR_REQUIRED_FIELDS;
    float x = rect.origin.x + w - [title sizeWithFont:font].width - 2;
    float hCaption = 12;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x + 2, y - hCaption, w, hCaption)];
    lab.font = font;
    lab.textColor = [UIColor whiteColor];
    lab.text = title;
    lab.backgroundColor = [UIColor clearColor];
    
    [Utils addShadow:lab];
    [v addSubview:lab];
}

+(void)addBlurbAtY:(float)y view:(UIView *)v caption:(NSString *)caption fontSize:(float)fontSize ynBold:(BOOL)ynBold{
    UIFont *font;
    if (ynBold) {
        font = [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_BOOK size:fontSize];
    } else {
        font = [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_LIGHT size:fontSize];
    }
    float w = [caption sizeWithFont:font].width;
    float h = [caption sizeWithFont:font].height;
    float x = ([Utils getWW] - w)/2;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    lab.font = font;
    lab.textColor = [UIColor whiteColor];
    lab.text = caption;
    lab.backgroundColor = [UIColor clearColor];
    
    [Utils addShadow:lab];
    [v addSubview:lab];
}

+(UILabel *)addBlurbAtXY:(float)x y:(float)y view:(UIView *)v caption:(NSString *)caption fontSize:(float)fontSize ynBold:(BOOL)ynBold{
    UIFont *font;
    if (ynBold) {
        font = [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_BOOK size:fontSize];
    } else {
        font = [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_LIGHT size:fontSize];
    }
    float w = [caption sizeWithFont:font].width;
    float h = [caption sizeWithFont:font].height;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    lab.font = font;
    lab.textColor = [UIColor whiteColor];
    lab.text = caption;
    lab.backgroundColor = [UIColor clearColor];
    
    [Utils addShadow:lab];
    [v addSubview:lab];
    return lab;
}

+(UILabel *)addCopyrightToView:(UIView *)v{
    UIScrollView *sv = (UIScrollView*)v;
    UIFont *font = [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_BOOK size:13];
    float w = [STR_COPYRIGHT sizeWithFont:font].width;
    float h = [STR_COPYRIGHT sizeWithFont:font].height;
    float x = ([Utils getWW] - w)/2;
    float y = sv.contentSize.height - 25;
    
    UILabel *labCopyright = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    labCopyright.text = STR_COPYRIGHT;
    labCopyright.backgroundColor = [UIColor clearColor];
    labCopyright.textColor = [UIColor whiteColor];
    labCopyright.font = font;
    [Utils addShadow:labCopyright];
    [sv addSubview:labCopyright];
    return labCopyright;
}

+(BOOL)isIOS7{
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f ) {
        return YES;
    }
    return NO;
}

+(BOOL)isStringLengthValid:(NSString *)checkString
                 minLength:(int)minLength
                 maxLength:(int)maxLength
{
    NSLogInfo(@"%@", checkString);
    if ([checkString length] >= minLength && [checkString length] <= maxLength)
    {
        return YES;
    }
    return NO;
}

+(BOOL)isUserNameValid:(NSString *)username
{
    //CHEKC FOR THE LENGTH OF THE USERNAME
    if (![Utils isStringLengthValid:username
                          minLength:CONST_CHAR_MIN_LIMIT_USERNAME maxLength:CONST_CHAR_MAX_LIMIT_USERNAME])
    {
        return NO;
    }
    
    //check for white space
    if ([Utils isAnyWhiteSpaceInTheMessage:username])
    {
        return NO;
    }
//    return YES;
    
    //TRIM HTE USER NAME
    NSString *trimmedString = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //CHECK FOR WHITESPACES
    NSRange whiteSpaceRange = [trimmedString rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (whiteSpaceRange.location != NSNotFound) {
        NSLog(@"Found whitespace");
        return NO;
    }
    
    return YES;
}

+(BOOL)isAnyWhiteSpaceInTheMessage:(NSString *)text
{
    //CHECK FOR WHITE SPACES
    NSString *trimmedText    =   [text stringByReplacingOccurrencesOfString:CONST_WHITESPACE_CHARACTER withString:@""];
    
    if (![trimmedText isEqualToString:text]) {
        return YES;
    }
    return NO;
}

+(BOOL)isPasswordValid:(NSString *)passwordText
{
    NSLogInfo(@"%@", passwordText);
    
    //SHOULD BE BETWEEN 6 && 32 CHARACTERS
    if(![Utils isStringLengthValid:passwordText
                         minLength:CONST_CHAR_MIN_LIMIT_PASSWORD
                         maxLength:CONST_CHAR_MAX_LIMIT_PASSWORD])
    {
        return NO;
    }
    
    if ([Utils isAnyWhiteSpaceInTheMessage:passwordText])
    {
        return NO;
    }
    
    int numberOfIntegers    =   0;
    int numberOfcharacters  =   0;
    
    //CHECK FOR AT LEAST 2 DIGIT AND 1 ALPHABET
    for (int charIndex = 0 ; charIndex < [passwordText length]; charIndex++)
    {
        //FETCH EACH CHARACTER FROM THE STRING
        char currentChar   =   [passwordText characterAtIndex:charIndex];
        
        //CHECK FOR NUMBER OF INTEGERS
        if (isdigit(currentChar))
        {
            numberOfIntegers++;
        }
        
        //CHECK FOR ALPHABET
        if (isalpha(currentChar))
        {
            numberOfcharacters++;
        }
        
    }
    if (numberOfIntegers > 1 && numberOfcharacters > 0)
    {
        return YES;
    }
    return NO;
}

+(BOOL)validateEmail:(NSString *)txt{
    if ([txt rangeOfString:@"@"].length == 0) {
        return NO;
    }
    if ([txt rangeOfString:@"."].length == 0) {
        return NO;
    }
    NSUInteger n = [txt rangeOfString:@"."].location;
    if (n == (txt.length - 1)) {
        return NO;
    }
    n = [txt rangeOfString:@"@"].location;
    if (n == 0) {
        return NO;
    }
    if (txt.length <= 5) {
        return NO;
    }
    return YES;
}

+(BOOL)validateAlphanumeric:(NSString *)txt
{
    
    if (txt.length < 6) {
        return NO;
    }
    if (txt.length > 32) {
        return NO;
    }
    if (![self isAlphaNumeric:txt]) {
        return NO;
    }
    
    return YES;
}

+(BOOL)validateNumeric:(NSString *)txt{
    if (![self isNumeric:txt]) {
        return NO;
    }
    return YES;
}

+(BOOL)validateNumericWithSpaces16:(NSString *)txt{
    if (![self isNumericWithSpaces16:txt]) {
        return NO;
    }
    return YES;
}

+(BOOL)validateNumeric3:(NSString *)txt{
    if (![self isNumeric:txt]) {
        return NO;
    }
    if (txt.length != 3) {
        return NO;
    }
    return YES;
}

+(BOOL)isNumeric:(NSString *)txt{
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([txt rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        return YES;
    }
    return NO;
}

+(BOOL)isNumericWithSpaces16:(NSString *)txt{
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *txt2 = [txt stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!([txt2 rangeOfCharacterFromSet:notDigits].location == NSNotFound))
    {
        return NO;
    }
    if (txt2.length != 16) {
        return NO;
    }
    return YES;
}

+(BOOL)validateZeroLength:(NSString *)txt{
    if (txt.length == 0) {
        return NO;
    }
    return YES;
}

//+(UIImageView*)getDownloadableImageLogo:(NSString *)iconUrl
//                               iconRect:(CGRect)iconRect
//{
//    UIImageView		*orgLogoView	=	[[UIImageView alloc] initWithImage:[UIImage imageNamed:[Utils validateString:iconUrl]]];
//    [orgLogoView setFrame:iconRect];
//    orgLogoView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    [orgLogoView setBackgroundColor:[UIColor clearColor]];
//    
//    dispatch_queue_t imageQ = dispatch_queue_create("imageQ", NULL);
//    
//    dispatch_async(imageQ, ^{
//        
//        ImageDownloadManager *imageDownLoader = [[ImageDownloadManager alloc] init];
//        [imageDownLoader setDelegate:orgLogoView];
//        [imageDownLoader downloadImage:[Utils validateString:iconUrl]];
//        imageDownLoader =   nil;
//    });
//    
//    return orgLogoView;
//
//    UIImageView *imgView    =   [[UIImageView alloc] initWithFrame:iconRect];
//    [imgView setContentMode:UIViewContentModeScaleAspectFit];
//    NSURL   *imageUrl   =   [NSURL URLWithString:iconUrl];
//    [imgView setImageWithURL:imageUrl];
//    return imgView;
//}

//+(UIButton*)createButtonWithImageFromURL:(NSString *)iconUrl
//                               iconRect:(CGRect)iconRect
//{
//    UIButton		*btn	=	[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setFrame:iconRect];
//    [btn setContentMode:UIViewContentModeScaleAspectFill];
//    NSURL *url  =   [NSURL URLWithString:iconUrl];
//
//    [btn setImageForState:UIControlStateNormal withURL:url];
//    
//    return btn;
//}

+(void)setImageForImageView:(UIImageView*)imgView
                    fromUrl:(NSString *)imageUrl
{
//    NSURL *url  =   [NSURL URLWithString:imageUrl];
//    NSURLRequest    *imageRequest   =   [[NSURLRequest alloc] initWithURL:url];
//
//    __weak UIImageView *weakImageView = imgView;
//
//    [imgView setImageWithURLRequest:imageRequest
//                   placeholderImage:nil
//                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                // Here you can animate the alpha of the imageview from 0.0 to 1.0 in 0.3 seconds
//                                [weakImageView setAlpha:0.0];
//                                [UIView beginAnimations:nil context:NULL];
//                                [UIView setAnimationDuration:0.3];
//                                [weakImageView setAlpha:1.0];
//                                [UIView commitAnimations];
//                            }
//                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                // Your failure handle code
//                            }];
}

+(BOOL)isAlphaNumeric:(NSString *)txt{
    NSCharacterSet *unwantedCharacters =
    [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    return ([txt rangeOfCharacterFromSet:unwantedCharacters].location == NSNotFound) ? YES : NO;
}

+(NSString *)getEvatarFilenameFromN:(int)n{
    NSString *filename = [NSString stringWithFormat:@"evatar_%03d.png", n];
    return filename;
}

+(void)fadeToViewController:(id)fromVc to:(id)toVc{
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.15;
    transition.type = kCATransitionFade;
    
    [[fromVc view].layer addAnimation:transition forKey:kCATransition];
    [fromVc pushViewController:toVc animated:NO];
}

+(void)pushToViewControllerWithFadeEffect:(id)fromVc to:(id)toVc{
    CATransition* transition = [CATransition animation];

    transition.duration = 0.15;
    transition.type = kCATransitionFade;

    [[fromVc view].layer addAnimation:transition forKey:kCATransition];
    [[fromVc navigationController] pushViewController:toVc animated:NO];
}

+(void)fadeToViewControllerPop:(id)fromVc to:(id)toVc{
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    
    [[fromVc view].layer addAnimation:transition forKey:kCATransition];
//    [fromVc pushViewController:toVc animated:NO];
    [fromVc popToViewController:toVc animated:NO];
}

#pragma mark - error check method
+(BOOL)isResponseValid:(NSDictionary *)dictValues
                          sender:(id)sender
{
//    if (dictValues && [dictValues objectForKey:CONST_SERVER_ERROR])
//    {
//        NSString    *strError   =   [dictValues objectForKey:CONST_SERVER_ERROR];
//        [Utils showAlertWithTitle:STR_ALERT_TITLE_CHARGEPOINT_ALERT
//                          message:strError
//                         delegate:self];
//        return NO;
//    }
//    if (dictValues && [dictValues[@"status"] integerValue] == 0)
//    {
//        NSString    *strError   =   [dictValues objectForKey:CONST_SERVER_MESSAGE];
//        [Utils showAlertWithTitle:STR_ALERT_TITLE_CHARGEPOINT_ALERT
//                          message:strError
//                         delegate:self];
//        return NO;
//    }
    return YES;
}

+(UIImageView *)addImageAtXY:(float)x y:(float)y imageFilename:(NSString *)imageFilename addSubViewTo:(id)parentView{
    UIImage *img = [UIImage imageNamed:imageFilename];
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
    float w = img.size.width;
    float h = img.size.height;
    iv.frame = CGRectMake(x, y, w, h);
    [Utils addShadow:iv];
    [parentView addSubview:iv];
    return iv;
}

//+(TextFieldCustom*)createCustomTextFieldWithPlaceholder:(NSString *)placeholder
//                                           textFieldTag:(int)textFieldTag
//                                          textFieldRect:(CGRect)textFieldRect
//                                          fieldDelegate:(id)fieldDelegate
//                                                   font:(UIFont*)font
//{
//    TextFieldCustom *tfCustom   =   [[TextFieldCustom alloc] initWithFrame:textFieldRect];
//    tfCustom.placeholder =   placeholder;
//    [tfCustom setBackgroundColor:[UIColor lightTextColor]];
//    [Utils roundCorner:tfCustom color:[UIColor purpleColor]];
//    [tfCustom setTag:textFieldTag];
//    [tfCustom setDelegate:fieldDelegate];
//    [tfCustom.btnClear setTag:textFieldTag];
////    tfCustom.delegate    =   fieldDelegate;
//    [tfCustom setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//    [tfCustom setTextColor:[UIColor blackColor]];
//    [tfCustom setAutocapitalizationType:UITextAutocapitalizationTypeWords];
//
//    [Utils addShadow:tfCustom];
//    if (!font)
//    {
//        font    =   [UIFont fontWithName:CONST_FONT_GOTHAM_NARROW_LIGHT
//                                    size:CONST_FONT_SIZE_FIFTEEN_POINTS];
//    }
//    [tfCustom setFont:font];
//    return tfCustom;
//}
//
//+(TextFieldCustom *)addTextFieldAtRect:(CGRect)rect caption:(NSString *)caption note:(NSString *)note placeholder:(NSString *)placeholder delegate:(id)delegate keyboardType:(int)keyboardType addSubViewTo:(id)parentView ynRequiredCaption:(BOOL)ynRequiredCaption{
//    
//    TextFieldCustom *tf = [[TextFieldCustom alloc] initWithFrame:rect];
//    tf.delegate = delegate;
//    
//    UILabel *labBack = [Utils addBackBorder:rect view:parentView];
//    [tf addSubview:labBack];
//    
//    tf.accessibilityLabel = note;
//    tf.keyboardType = keyboardType;
//    [parentView addSubview:tf];
//    
//    if (caption) {
//        UILabel *labCaption = [Utils addCaption:rect view:parentView caption:caption];
//        [tf addSubview:labCaption];
//    }
//    if (ynRequiredCaption) {
//        [Utils addRequiredFields:rect view:parentView];
//    }
//    
//    tf.placeholder = placeholder;
//    
//    NSString *defaultValue = [Utils loadObjFromDefaultsByName:note];
//    tf.text = defaultValue;
//    return tf;
//}

+(UIButton *)addButtonAtRect:(CGRect)rect imageFilename:(NSString *)imageFilename action:(NSString *)action target:(id)target addSubViewTo:(id)parentView{
    UIButton *but;
    but = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img = [UIImage imageNamed:imageFilename];
    but.frame = rect;
    [but addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDown];
    [but setBackgroundImage:img forState:UIControlStateNormal];
    [Utils addShadow:but];
    [parentView addSubview:but];
    return but;
}

+(UIButton *)addButtonLinkAtRect:(CGRect)rect title:(NSString *)title font:(UIFont *)font action:(NSString *)action target:(id)target addSubViewTo:(id)parentView{
    float w = rect.size.width;
    float h = rect.size.height;
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = rect;
    [but setTitle:title forState:UIControlStateNormal];
    but.titleLabel.font = font;
    
    [but addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDown];
    [parentView addSubview:but];
    
    float y = h;
    h = 1;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, y, w, h)];
    lab.backgroundColor = [UIColor whiteColor];
    [but addSubview:lab];
    
    return but;
}

+ (UIColor*) getPixelColorInImage:(CGPoint)point image:(UIImage *)img
{
    
    UIColor* color = nil;
    
    CGImageRef inImage;
    
    inImage =img.CGImage;
    
    
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) { return nil; /* error */ }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);
    int alpha;
    
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        //offset locates the pixel in the data from x,y.
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        int offset = 4*((w*round(point.y))+round(point.x));
        alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    }
    
    // When finished, release the context
    //CGContextRelease(cgctx);
    // Free image data memory for the context
    if (data) { free(data); }
    
    return color;
}

+ (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef)inImage
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
#pragma clang diagnostic pop
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

#pragma mark - UIImageView methods
+(UIImageView*)bGImageViewForEditModeTextField:(UITextField*)textField
{
    UIImageView *bgImgView  =   [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_BG_TEXTVIEW_EDITING]];
    [bgImgView setFrame:textField.frame];

    return bgImgView;
}

+(UIImageView*)bGImageViewForNonEditModeTextField:(UITextField*)textField
{
    UIImageView *bgImgView  =   [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_BG_TEXTVIEW_DEFAULT]];
    [bgImgView setFrame:textField.frame];

    return bgImgView;
}

#pragma mark - Share Feature
//+(NSString *)getShareTheStationInfoMessage:(StationData*)station
//{
//    NSMutableString *strShareStationInfo    =   [[NSMutableString alloc] init];
//
//    //Name
//    if (station.stationName)
//    {
//        [strShareStationInfo appendString:station.stationName];
//    }
//
//    //Address
//    if (station.stationAddress)
//    {
//        if (strShareStationInfo.length > 0)
//        {
//            [strShareStationInfo appendString:CONST_SYMBOL_NEW_LINE];
//        }
//        [strShareStationInfo appendString:station.stationAddress];
//    }
//
//
//    //Port Desription
//    if (station.stationAddress)
//    {
//        if (strShareStationInfo.length > 0)
//        {
//            [strShareStationInfo appendString:CONST_SYMBOL_NEW_LINE];
//        }
//        [strShareStationInfo appendString:@"Port Desription goes here"]; //message to be changed
//    }
//
//
//    //Pricing
//    if (station.stationAddress)
//    {
//        if (strShareStationInfo.length > 0)
//        {
//            [strShareStationInfo appendString:CONST_SYMBOL_NEW_LINE];
//        }
//        [strShareStationInfo appendString:@"Pricing goes here"]; //message to be changed
//    }
//    
//    //Station Description
//    if (station.stationAddress)
//    {
//        if (strShareStationInfo.length > 0)
//        {
//            [strShareStationInfo appendString:CONST_SYMBOL_NEW_LINE];
//        }
//        [strShareStationInfo appendString:@"station description goes here"]; //message to be changed
//    }
//
//
//    //Highest Rated Driver Tip
//    if (station.stationAddress)
//    {
//        if (strShareStationInfo.length > 0)
//        {
//            [strShareStationInfo appendString:CONST_SYMBOL_NEW_LINE];
//        }
//        [strShareStationInfo appendString:@"Highest Rated Driver Tip"]; //message to be changed
//    }
//
//    //Marketing splash message
//    if (station.stationAddress)
//    {
//        if (strShareStationInfo.length > 0)
//        {
//            [strShareStationInfo appendString:CONST_SYMBOL_NEW_LINE];
//        }
//        [strShareStationInfo appendString:@"Marketing splash message goes here"]; //message to be changed
//    }
//    /*
//     The information will include the station name, station address, port description, pricing information (public price), station description, highest rated driver tip, and a marketing splash message
//     */
//
//    return strShareStationInfo;
//}
//
//+(NSString *)getShareMessageForEmailOption:(StationData*)station driverTips:(NTJSON *)tips
//{
//    /*
//     Name: <name of station>
//     Address: <street number, street name, city, and state>
//     Plug Type: <connector information>
//     Station Description: <station details>
//     Driver Tip: <top rated Driver Tip>
//
//     See whether this charging station is availble before you go by downloading the free ChargePoint mobile application for Android and iPhone
//     */
//    
//    NSMutableString *strShareStationInfo    =   [[NSMutableString alloc] init];
//
//    //Name
//    if (station.stationName)
//    {
//        [strShareStationInfo appendFormat:@"%@ %@", NSLocalizedString(@"Name :", nil), station.stationName];
//    }
//
//    //Address
//    if (station.stationAddress)
//    {
//        [strShareStationInfo appendFormat:@"\n%@ %@", NSLocalizedString(@"Address :", nil), station.stationAddress];
//    }
//
//    //Port Desription
//    if (station.portTypeInfo)
//    {
//        NSArray *portStatusArray    =   [station portStatuses];
//
//        for (NSInteger index=0; index<portStatusArray.count; index++) {
//            PortStatus  *status=   portStatusArray[index];
//            [strShareStationInfo appendFormat:@"\n%@ %@", NSLocalizedString(@"Plug Type :", nil), status.labelText];
//        }
//    }
//
//    //Station Description
//    if (station.stationDescription)
//    {
//        [strShareStationInfo appendFormat:@"\n%@ %@", NSLocalizedString(@"Station Description :", nil), station.stationDescription];
//    }
//
//
//    //Highest Rated Driver Tip
//    NSString *text  =   @"-";
//    if (tips)
//    {
//        NSString *tipKey = tips[@"tip_index"][0];
//        NTJSON *tip = tips[@"tip_map"][tipKey];
//        
//        text = tip[@"tip_text"];
//        if (!text) {
//            text    =   @"-";
//        }
//    }
//    
//    [strShareStationInfo appendFormat:@"\n%@ %@", NSLocalizedString(@"Driver Tip :", nil), text]; //TODO : highest rated driver tip is to be shown to the user
//    
//    //Marketing splash message
//    [strShareStationInfo appendString:NSLocalizedString(@"\n\nSee whether this charging station is availble before you go by downloading the free ChargePoint mobile application for Android and iPhone.",@"")];
//
//    return strShareStationInfo;
//}
//
//
//+(NSString *)getShareMessageForEmailOptionFromChargingStatus:(NSString*)name address:(NSString*)address portInfo:(NSString*)portInfo description:(NSString*)description tip:(NSString*)tip
//{
//    /*
//     Name: <name of station>
//     Address: <street number, street name, city, and state>
//     Plug Type: <connector information>
//     Station Description: <station details>
//     Driver Tip: <top rated Driver Tip>
//     
//     See whether this charging station is availble before you go by downloading the free ChargePoint mobile application for Android and iPhone
//     */
//    
//    NSMutableString *strShareStationInfo    =   [[NSMutableString alloc] init];
//    
//    //Name
//    if (name.length >0)
//    {
//        [strShareStationInfo appendFormat:@"%@ %@", NSLocalizedString(@"Name :", nil), name];
//    }
//    
//    //Address
//    if (address.length >0)
//    {
//        [strShareStationInfo appendFormat:@"\n%@ %@", NSLocalizedString(@"Address :", nil), address];
//    }
//    
//    //Port Desription
//    if (portInfo.length >0)
//    {
//        [strShareStationInfo appendFormat:@"\n%@ %@", NSLocalizedString(@"Plug Type :", nil), portInfo];
//    }
//    
//    //Station Description
//    if (description)
//    {
//        [strShareStationInfo appendFormat:@"\n%@ %@", NSLocalizedString(@"Station Description :", nil), description];
//    }
//    
//    if (tip)
//    {
//        [strShareStationInfo appendFormat:@"\n%@ %@", NSLocalizedString(@"Driver Tip :", nil), tip];
//    }
//    
//    //Marketing splash message
//    [strShareStationInfo appendString:NSLocalizedString(@"\n\nSee whether this charging station is availble before you go by downloading the free ChargePoint mobile application for Android and iPhone.",@"")];
//    
//    return strShareStationInfo;
//}
//
//+(NSString *)getShareMessageForMessageOption:(StationData*)station
//{
//    /*
//     Check out this charging station at <street number, street name, city, state>. Find it on the ChargePoint mobile app.
//     */
//
//    NSMutableString *strShareStationInfo    =   [[NSMutableString alloc] init];
//
//    //fixed message
//    [strShareStationInfo appendString:NSLocalizedString(@"Check out this charging station",@"")];
//
//    //Address
//    if (station.stationAddress)
//    {
//        [strShareStationInfo appendFormat:@" %@ %@.",STR_AT, station.stationAddress];
//    }
//
//    [strShareStationInfo appendFormat:@" %@",NSLocalizedString(@"Find it on the ChargePoint mobile app.",@"")];
//    
//    return strShareStationInfo;
//}
//
//+(NSString *)getShareMessageForFaceBookOption:(StationData*)station
//{
//    /*
//     Check out this charging station <12345678901234/12345678901234> at <street number, street name, city, state>. Find it on the ChargePoint mobile app.
//     */
//
//    NSMutableString *strShareStationInfo    =   [[NSMutableString alloc] init];
//
//    //fixed message
//    [strShareStationInfo appendString:NSLocalizedString(@"Check out this charging station ",@"")];
//
//    //Name
//    if (station.stationName)
//    {
//        [strShareStationInfo appendString:station.stationName];
//    }
//
//    //Address
//    if (station.stationAddress)
//    {
//        [strShareStationInfo appendFormat:@" %@ %@.",STR_AT, station.stationAddress];
//    }
//
//    //Marketing splash message
//    [strShareStationInfo appendFormat:@" %@",NSLocalizedString(@"Find it on the ChargePoint mobile app.",@"")];
//
//    return strShareStationInfo;
//}
//
//+(NSString *)getShareMessageForTwitterOption:(StationData*)station
//{
//    /*
//     Check out this #EV charging station at <street number, street name, city, state> on the @ChargePointnet app.
//     */
//
//    NSMutableString *strShareStationInfo    =   [[NSMutableString alloc] init];
//
//    //fixed message
//    [strShareStationInfo appendString:NSLocalizedString(@"Check out this #EV charging station ",@"")];
//
//    //Address
//    if (station.stationAddress)
//    {
//        [strShareStationInfo appendFormat:@"%@ %@ ",STR_AT, station.stationAddress];
//    }
//
//    //Marketing splash message
//    [strShareStationInfo appendString:NSLocalizedString(@"on the @ChargePointnet app.",@"")];
//
//    return strShareStationInfo;
//}
//
//+(NSString *)getShareMessageForFoursquareOption:(StationData*)station
//{
//    /*
//     Check out this charging station <12345678901234/12345678901234> at <street number, street name, city, state> on the ChargePoint app.
//     */
//
//    NSMutableString *strShareStationInfo    =   [[NSMutableString alloc] init];
//
//    //fixed message
//    [strShareStationInfo appendFormat:@"%@ %@",STR_SHARE_STATION_INFO_VIA_MAIL_SUBJECT, CONST_SYMBOL_WHITESPACE];
//
//    //Name
//    if (station.stationName)
//    {
//        [strShareStationInfo appendString:station.stationName];
//    }
//
//    //Address
//    if (station.stationAddress)
//    {
//
//        [strShareStationInfo appendFormat:@"%@ %@",STR_AT, station.stationAddress];
//    }
//
//    //Marketing splash message
//    [strShareStationInfo appendString:CONST_SYMBOL_WHITESPACE];
//    [strShareStationInfo appendString:STR_SHARE_STATION_INFO_VIA_FOURSQUARE_PM_MESSAGE];
//
//
//    return strShareStationInfo;
//}
//
#pragma mark - Reachability
//+(BOOL)isNetworkReachable
//{
//    Reachability   *reachabilityForInternetConnection = [Reachability reachabilityForInternetConnection];
//    Reachability   *reachabilityForLocalWiFi = [Reachability reachabilityForLocalWiFi];
//    if ([reachabilityForInternetConnection currentReachabilityStatus] || [reachabilityForLocalWiFi currentReachabilityStatus])
//    {
//        return YES;
//    }
//    return NO;
//}

//+(BOOL)isHostReachable
//{
//    Reachability *reachabilityWithHostName  =   [Reachability reachabilityWithHostName:CONST_URL_POST_WEBSERVICE];
//    return [reachabilityWithHostName currentReachabilityStatus];
//}

//+(void)startNotificationForReachabilityStatus
//{
//    Reachability   *reachabilityForInternetConnection = [Reachability reachabilityForInternetConnection];
//    [reachabilityForInternetConnection startNotifier];
//
//    Reachability   *reachabilityForLocalWiFi = [Reachability reachabilityForLocalWiFi];
//    [reachabilityForLocalWiFi startNotifier];
//
//    Reachability *reachabilityWithHostName  =   [Reachability reachabilityWithHostName:CONST_URL_POST_WEBSERVICE];
//    [reachabilityWithHostName startNotifier];
//}

//+(void)stopNotificationForReachabilityStatus
//{
//    Reachability   *reachabilityForInternetConnection = [Reachability reachabilityForInternetConnection];
//    [reachabilityForInternetConnection stopNotifier];
//
//    Reachability   *reachabilityForLocalWiFi = [Reachability reachabilityForLocalWiFi];
//    [reachabilityForLocalWiFi stopNotifier];
//
//    Reachability *reachabilityWithHostName  =   [Reachability reachabilityWithHostName:CONST_URL_POST_WEBSERVICE];
//    [reachabilityWithHostName stopNotifier];
//}


#pragma mark - connection monitoring
+(void)connectionDidFailWithError:(NSError*)error
{
    
//    NSDictionary    *errorDict  =   [error userInfo];
//    
//    NSMutableString *strError   =   [[NSMutableString alloc] init];
//    if([errorDict respondsToSelector:@selector(allKeys)])
//    {
//        for (NSString *key in [errorDict allKeys])
//        {
//            if ([errorDict objectForKey:key])
//            {
//                [strError appendFormat:@"\n%@ - %@", key,[errorDict objectForKey:key]];
//            }
//        }
//    }
//    if ([Utils validateString:[error localizedDescription]].length > 0)
//    {
//        [strError appendFormat:@"\nlocalizedDescription - %@",[error localizedDescription]];
//    }
//
//    if ([Utils validateString:[error localizedFailureReason]].length > 0)
//    {
//        [strError appendFormat:@"\nlocalizedFailureReason - %@",[error localizedFailureReason]];
//    }
//    
//    NSArray *arr    =   [error localizedRecoveryOptions];
//
//    for (int index=0; index<[arr count]; index++)
//    {
//        if ([Utils validateString:[arr objectAtIndex:index]].length > 0)
//        {
//            [strError appendFormat:@"\n %@",[Utils validateString:[arr objectAtIndex:index]]];
//        }
//    }
//    
//    if ([Utils validateString:[error localizedRecoverySuggestion]].length > 0)
//    {
//        [strError appendFormat:@"\nlocalizedRecoverySuggestion - %@",[error localizedRecoverySuggestion]];
//    }
//
//    [strError appendFormat:@"Error code - %ld",(long)[error code]];
//    [strError appendFormat:@"Error Domain - %@",[error domain]];
//
//    NSLog(@"\n\n\n\n Error - %@ \n\n\n\n",strError);
//    
////    [self showAlertWithTitle:[error localizedDescription] message:strError delegate:nil];
//    NSLog(@"\n \n Error occured - %@",strError);
    NSString    *errorMsg   =   STR_ALERT_CANNOT_CONNECT_TO_HOST;
    if ([error code] == -1009)
    {
        errorMsg    =   STR_ALERT_NETWORK_CONNECTION_REQUIRED;
    }
    [Utils showAlertWithTitle:STR_ALERT_TITLE_CHARGEPOINT_ALERT message:errorMsg delegate:nil];
}



+(float)getXX:(float)x
{
    float ww = [Utils getWW];
    float xAnswer = (ww - CONST_DESIGN_WIDTH_320)/2 + x;
    return xAnswer;
}

+(UIScrollView *)addScrollAtRect:(CGRect)rect delegate:(id)delegate addSubViewTo:(id)parentView imageName:(NSString *)imageName useImageHeightAsContentHeight:(BOOL)ynUseImageHeight
{

    float x = rect.origin.x;
    x = [Utils getXX:x];
    rect.origin.x = x;

    UIImage *img = [UIImage imageNamed:imageName];
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:rect];
    float hContent = rect.size.height;
    float hCheckNoScroll = [parentView frame].size.height + [Utils getYScroll];
    if (ynUseImageHeight) {
        hContent = img.size.height;
        if (hContent < hCheckNoScroll) {
            hContent = hCheckNoScroll;
        }
    }
    sv.contentSize = CGSizeMake(rect.size.width, hContent);
    sv.delegate = delegate;
    sv.tag = -1;
    [parentView addSubview:sv];

    //scrollable
    if (hContent == hCheckNoScroll) {
        sv.scrollEnabled = NO;
    }

    float hImage = hContent;
    x = (320.0 - [parentView frame].size.width)/2;
    rect = CGRectMake(x, 0, [parentView frame].size.width, hImage);
    UIImageView *iv = [[UIImageView alloc] initWithFrame:rect];
    iv.image = img;
    [sv addSubview:iv];
    //sv.clipsToBounds = NO;
    sv.translatesAutoresizingMaskIntoConstraints = NO;
    return sv;
}

+(CGRect)getScrollRect:(float)headerHeight
{
    float x = 0;
    float y = [Utils getYScroll] + headerHeight;
    float w = [Utils getWW];
    float h = [Utils getHH] - y;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

+(float)getHHScroll2:(UIView *)v
{
    float h;
    if ([Utils isIOS7]) {
        h = [Utils getHH] - v.frame.origin.y;
    } else {
        //ios 6 (with viewcontrollers with header)
        h = [Utils getHH] - v.frame.origin.y - [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    return h;
}


+(void)addBackgroundToView:(id)view imageName:(NSString *)imageName
{
    float x = 0;
    float y = 0;
    float w = [Utils getWW];
    float h = [Utils getHHScroll2:view];
    CGRect rect = CGRectMake(x, y, w, h);
    UIImageView *iv = [[UIImageView alloc] initWithFrame:rect];
    iv.image = [UIImage imageNamed:imageName];
    [view addSubview:iv];
}

+(CGRect)getRectForRightBottomButtonFromImageNamed:(NSString *)imageName view:(id)view
{
    UIImage *img = [UIImage imageNamed:imageName];
    float w = img.size.width;
    float x = 165;
    float h = img.size.height;
    float hView;
    if ([view class] == [UIScrollView class]) {
        hView = [view contentSize].height;
    } else {
        x = [Utils getXX:x];
        hView = [view frame].size.height;
    }
    float y = hView - h - 30;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

+(CGRect)getRectForCenterBottomButtonFromImageNamed:(NSString *)imageName view:(id)view
{
    UIImage *img = [UIImage imageNamed:imageName];
    float w = img.size.width;
    float x;
    float h = img.size.height;
    float hView;
    if ([view class] == [UIScrollView class]) {
        x = (CONST_DESIGN_WIDTH_320 - w)/2;
        hView = [view contentSize].height;
    } else {
        x = ([Utils getWW] - w)/2;
        hView = [view frame].size.height;
        if (![Utils isIOS7]) {
            hView = hView - [[UIApplication sharedApplication] statusBarFrame].size.height;
        }
    }
    float y = hView - h - 30;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

+(UIImageView *)addLogoToViewAtCenterY:(float)cy view:(UIView *)view imageName:(NSString *)imageName
{
    UIImage *img = [UIImage imageNamed:imageName];
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
    float w = img.size.width;
    float h = img.size.height;
    float x;
    if ([view class] == [UIScrollView class]) {
        x = (CONST_DESIGN_WIDTH_320 - w)/2;
    } else {
        x = ([view frame].size.width - w)/2;
    }
    float y = cy - h/2;
    CGRect rect = CGRectMake(x, y, w, h);
    iv.frame = rect;
    [view addSubview:iv];
    return iv;
}

//+(CustomNavigationBarView *)addNavigationBarToVC:(id)vc imageName:(NSString *)imageName title:(NSString *)title height:(float)height
//{
//    CGFloat controlWidth        =  [Utils getWW];
//    CGFloat controlHeight       =   height;
//    CGFloat startXCoordinate    =   0;
//    CGFloat startYCoordinate    =   [Utils getYScroll];
//    CGRect  controlRect         =   CGRectZero;
//
//    CustomNavigationBarView *customNavigationBarView =   [[CustomNavigationBarView alloc] initWithFrame:CGRectZero];
//    customNavigationBarView.firstButtonTitle    =   nil;
//    customNavigationBarView.secondButtonTitle   =   nil;
//    customNavigationBarView.screenTitle         =   title;
//    [customNavigationBarView setCpViewDelegate:vc];
//
//    [[vc view] addSubview:customNavigationBarView];
//
//    controlRect =   CGRectMake(startXCoordinate, startYCoordinate, controlWidth, controlHeight);
//    [customNavigationBarView setFrame:controlRect];
//    customNavigationBarView.isBackOnlyVisible = [NSNumber numberWithBool:YES];
//    [customNavigationBarView arrange];
//
//    customNavigationBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
//    return customNavigationBarView;
//}
+(UIImageView *)addImageAtRect:(CGRect)rect imageFilename:(NSString *)imageFilename addSubViewTo:(id)parentView
{
    if ([parentView class] != [UIScrollView class]) {
        float x = rect.origin.x;
        x = [Utils getXX:x];
        rect.origin.x = x;
    }
    UIImage *img = [UIImage imageNamed:imageFilename];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:rect];
    iv.image = img;
    [Utils addShadow:iv];
    [parentView addSubview:iv];
    return iv;
}

+(CGRect)getRectForLeftBottomButtonFromImageNamed:(NSString *)imageName view:(id)view
{
    UIImage *img = [UIImage imageNamed:imageName];
    float w = img.size.width;
    float x = 50;
    float h = img.size.height;
    float hView;
    if ([view class] == [UIScrollView class]) {
        hView = [view contentSize].height;
    } else {
        x = [Utils getXX:x];
        hView = [view frame].size.height;
    }
    float y = hView - h - 30;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

+(void)addTapHandlerToView:(id)view target:(id)target action:(SEL)actionMethod
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:actionMethod];
    [view addGestureRecognizer:tap];
}

+(void)addTapToView:(id)view target:(id)target
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(tapped)];
    [view addGestureRecognizer:tap];
}

+(void)addTapToView2:(id)view target:(id)target
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(tapped2:)];
    [view addGestureRecognizer:tap];
}

//+(PickerView *)addPickerAtRect:(CGRect)rect caption:(NSString *)caption note:(NSString *)note choices:(NSArray *)ar delegate:(id)delegate addSubViewTo:(id)parentView ynRequiredCaption:(BOOL)ynRequiredCaption validationType:(NSString *)validationType validationNote:(NSString *)validationNote{
//
//    [Utils addCaption:rect view:parentView caption:caption];
//
//    PickerView *pv = [[PickerView alloc] init];
//
//    pv.frame = [parentView frame];
//
//    // Initialization code
//    [pv setCpViewDelegate:delegate];
//
//    pv.arDropDown = (NSMutableArray *)ar;
//
//    // add no choice to choices
//    [pv.arDropDown insertObject:@"" atIndex:0];
//
//    pv.scroll = parentView;
//    pv.note = note;
//    pv.validationNote = validationNote;
//    pv.validationType = validationType;
//
//    [pv addDropDown:rect note:note];
//
//    if (ynRequiredCaption) {
//        [Utils addRequiredFields:rect view:parentView];
//    }
//
//    return pv;
//}
//
//+(PickerView *)addPickerAtRect2:(CGRect)rect caption:(NSString *)caption note:(NSString *)note choices:(NSArray *)ar delegate:(id)delegate addSubViewTo:(id)parentView ynRequiredCaption:(BOOL)ynRequiredCaption validationType:(NSString *)validationType validationNote:(NSString *)validationNote parentViewForPicker:(id)parentViewForPicker
//{
//
//    [Utils addCaption:rect view:parentView caption:caption];
//
//    PickerView *pv = [[PickerView alloc] init];
//
//    pv.frame = [parentView frame];
//
//    // Initialization code
//    [pv setCpViewDelegate:delegate];
//
//    pv.arDropDown = (NSMutableArray *)ar;
//
//    // add no choice to choices
//    [pv.arDropDown insertObject:@"" atIndex:0];
//
//    pv.scroll = parentView;
//    pv.note = note;
//    pv.validationNote = validationNote;
//    pv.validationType = validationType;
//
//    [pv addDropDown:rect note:note];
//
//    if (ynRequiredCaption) {
//        [Utils addRequiredFields:rect view:parentView];
//    }
//
//    if (parentViewForPicker) {
//        pv.parentViewForPicker = parentViewForPicker;
//        pv.frame = [parentViewForPicker frame];
//    }
//
//    return pv;
//}
//
//+(TextFieldCustom *)addTextFieldAtRect2:(CGRect)rect caption:(NSString *)caption note:(NSString *)note placeholder:(NSString *)placeholder delegate:(id)delegate keyboardType:(int)keyboardType addSubViewTo:(id)parentView ynRequiredCaption:(BOOL)ynRequiredCaption validationType:(NSString *)validationType validationNote:(NSString *)validationNote{
//
//    if ([parentView class] != [UIScrollView class]) {
//        float x = rect.origin.x;
//        x = [Utils getXX:x];
//        rect.origin.x = x;
//    }
//
//    TextFieldCustom *tf = [[TextFieldCustom alloc] initWithFrame:rect];
//    tf.delegate = delegate;
////    [tf setCustomTextFieldDelegate:delegate];
//    [tf setDelegate:delegate];
//    tf.accessibilityLabel = note;
//    tf.note = note;
//    tf.keyboardType = keyboardType;
//    [parentView addSubview:tf];
//
//    UILabel *labBack = [Utils addBackBorder:rect view:parentView];
//    [parentView insertSubview:labBack belowSubview:tf];
//    tf.labBack = labBack;
//
//    if (caption) {
//        UILabel *labCaption = [Utils addCaption:rect view:parentView caption:caption];
//        [parentView addSubview:labCaption];
//        tf.labCaption = labCaption;
//    }
//    if (ynRequiredCaption) {
//        [Utils addRequiredFields:rect view:parentView];
//    }
//
//    tf.placeholder = placeholder;
//
//    NSString *defaultValue = [Utils loadObjFromDefaultsByName:note];
//    if (!defaultValue) {
//        defaultValue = STR_NOTE_ZERO_LENGTH;
//    }
//    tf.text = defaultValue;
//
//    tf.validationType = validationType;
//    tf.validationNote = validationNote;
//
//    tf.placeHolder = placeholder;
//    [tf setBackgroundColor:[UIColor greenColor]];
//    return tf;
//}

+(void)cleanView:(id)v
{
    for (id subV0 in [v subviews]) {
        id subV = subV0;
        [subV removeFromSuperview];
        subV = nil;
    }
}

+(void)addBreakAtY:(float)y v:(UIView *)v
{
    UIImage *img = [UIImage imageNamed:IMG_BREAKER];
    float x = 0;
    float w = [Utils getWW];
    float h = img.size.height;
    h = .5;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    lab.backgroundColor = [UIColor whiteColor];
    [v addSubview:lab];
}

+(UILabel *)addBlurbAtXYwithDefaultFromNote:(float)x y:(float)y view:(UIView *)v note:(NSString *)txtNote fontSize:(float)fontSize ynBold:(BOOL)ynBold
{
    NSString *txtCaption = [Utils loadObjFromDefaultsByName:txtNote];
    return [Utils addBlurbAtXY:x y:y view:v caption:txtCaption fontSize:fontSize ynBold:ynBold];
}

+(UILabel *)addBlurbSystemFontAtXY:(float)x y:(float)y view:(UIView *)v caption:(NSString *)caption fontSize:(float)fontSize ynBold:(BOOL)ynBold
{
    UIFont *font;
    if (ynBold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    float w = [caption sizeWithFont:font].width;
    float h = [caption sizeWithFont:font].height;
    if ([v class] != [UIScrollView class]) {
        x = [Utils getXX:x];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    lab.font = font;
    lab.textColor = [UIColor whiteColor];
    lab.text = caption;
    lab.backgroundColor = [UIColor clearColor];

    [Utils addShadow:lab];
    [v addSubview:lab];
    return lab;
}






+(CGRect)getRectForViewBelowHeaderOfHeight:(float)hHeader
{
    float hStatus = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGRect rect = CGRectMake(0, 0, [Utils getWW], [Utils getHH] - hHeader - hStatus);
    return rect;
}

+(BOOL)isCreditCardOnFile
{
    BOOL ynValidatedCreditCard = [[Utils loadObjFromDefaultsByName:CONST_IS_CREDIT_CARD_ON_FILE_CLASS_NAME] boolValue];
    return ynValidatedCreditCard;
}

+(NSMutableArray *)loadArrayWithCountryCodes:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"+1 USA"];
    [ar addObject:@"+52 Mexico"];
    [ar addObject:@"+1 Canada"];
    return ar;
}

+(NSMutableArray *)loadArrayWithCurrency:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"USD"];
    [ar addObject:@"Euro"];
    [ar addObject:@"Canadian"];
    return ar;
}

+(NSMutableArray *)loadArrayWithStates:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"ALABAMA"];
    [ar addObject:@"ALASKA"];
    [ar addObject:@"ARIZONA"];
    [ar addObject:@"ARKANSAS"];
    [ar addObject:@"CALIFORNIA"];
    [ar addObject:@"COLORADO"];
    [ar addObject:@"CONNECTICUT"];
    [ar addObject:@"DELAWARE"];
    [ar addObject:@"FLORIDA"];
    [ar addObject:@"GEORGIA"];
    [ar addObject:@"HAWAII"];
    [ar addObject:@"IDAHO"];
    return ar;
}

+(NSMutableArray *)loadArrayWithCountries:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"US"];
    [ar addObject:@"CANADA"];
    [ar addObject:@"MEXICO"];
    return ar;
}

+(NSMutableArray *)loadArrayWithMonthsCreditCard:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"Jan 01"];
    [ar addObject:@"Feb 02"];
    [ar addObject:@"Mar 03"];
    [ar addObject:@"Apr 04"];
    [ar addObject:@"May 05"];
    [ar addObject:@"Jun 06"];
    [ar addObject:@"Jul 07"];
    [ar addObject:@"Aug 08"];
    [ar addObject:@"Sep 09"];
    [ar addObject:@"Oct 10"];
    [ar addObject:@"Nov 11"];
    [ar addObject:@"Dec 12"];
    return ar;
}

+(NSMutableArray *)loadArrayWithYearsCreditCard:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"2013"];
    [ar addObject:@"2014"];
    [ar addObject:@"2015"];
    [ar addObject:@"2016"];
    [ar addObject:@"2017"];
    [ar addObject:@"2018"];
    [ar addObject:@"2019"];
    [ar addObject:@"2020"];
    [ar addObject:@"2021"];
    [ar addObject:@"2022"];
    [ar addObject:@"2023"];
    return ar;
}

+(NSMutableArray *)loadArrayWithMakesEV:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"Toyota"];
    [ar addObject:@"BMW"];
    [ar addObject:@"Ford"];
    [ar addObject:@"Tesla"];
    return ar;
}

+(NSMutableArray *)loadArrayWithModelsEV:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"Tercel"];
    [ar addObject:@"i8"];
    [ar addObject:@"Focus"];
    [ar addObject:@"Roadster"];
    return ar;
}

+(NSMutableArray *)loadArrayWithYearsEV:(NSMutableArray *)ar
{
    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"2010"];
    [ar addObject:@"2011"];
    [ar addObject:@"2012"];
    [ar addObject:@"2013"];
    return ar;
}

+(NSMutableArray *)loadArrayWithStations:(NSMutableArray *)ar
{
    NSMutableDictionary *dict;
    ar = [[NSMutableArray alloc] init];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"001" forKey:@"station_id"];
    [dict setObject:@"ORG NAME / STATION NAME" forKey:@"org_station_name"];
    [dict setObject:@"0000 Any Street Name Goes Here," forKey:@"address_1"];
    [dict setObject:@"City Name, State, 00000, USA" forKey:@"address_2"];
    [dict setObject:@"0" forKey:@"port_level_1"];
    [dict setObject:@"1" forKey:@"port_level_2"];
    [dict setObject:@"10" forKey:@"port_level_DC"];
    [dict setObject:@"2.3" forKey:@"distance"];
    [dict setObject:@".5" forKey:@"distance_on_foot"];
    [dict setObject:@"YES" forKey:@"power_sharing"];
    [dict setObject:@"NO" forKey:@"connections"];
    [dict setObject:@"YES" forKey:@"paid"];
    [dict setObject:@"YES" forKey:@"reservable"];
    [dict setObject:@"pin_available.png" forKey:@"imageFilename"];
    [dict setObject:@"1.05" forKey:@"fee"];
    [dict setObject:[NSArray arrayWithObjects:@"Port 1", @"Port 2", nil] forKey:@"ports"];
    [ar addObject:dict];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"002" forKey:@"station_id"];
    [dict setObject:@"Target" forKey:@"org_station_name"];
    [dict setObject:@"101 W Garnett Ave" forKey:@"address_1"];
    [dict setObject:@"Santa Cruz, CA 95060, USA" forKey:@"address_2"];
    [dict setObject:@"1" forKey:@"port_level_1"];
    [dict setObject:@"0" forKey:@"port_level_2"];
    [dict setObject:@"10" forKey:@"port_level_DC"];
    [dict setObject:@"2.4" forKey:@"distance"];
    [dict setObject:@".6" forKey:@"distance_on_foot"];
    [dict setObject:@"NO" forKey:@"power_sharing"];
    [dict setObject:@"Target" forKey:@"connections"];
    [dict setObject:@"NO" forKey:@"paid"];
    [dict setObject:@"YES" forKey:@"reservable"];
    [dict setObject:@"pin_in_use-dc.png" forKey:@"imageFilename"];
    [dict setObject:@"0.99" forKey:@"fee"];
    [dict setObject:[NSArray arrayWithObjects:@"Port 1", @"Port 2", @"Port 3", nil] forKey:@"ports"];
    [ar addObject:dict];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"003" forKey:@"station_id"];
    [dict setObject:@"Ace Hardware" forKey:@"org_station_name"];
    [dict setObject:@"23033 Mission St" forKey:@"address_1"];
    [dict setObject:@"Campbell, CA 00000, USA" forKey:@"address_2"];
    [dict setObject:@"0" forKey:@"port_level_1"];
    [dict setObject:@"1" forKey:@"port_level_2"];
    [dict setObject:@"0" forKey:@"port_level_DC"];
    [dict setObject:@"2.5" forKey:@"distance"];
    [dict setObject:@".7" forKey:@"distance_on_foot"];
    [dict setObject:@"NO" forKey:@"power_sharing"];
    [dict setObject:@"NO" forKey:@"connections"];
    [dict setObject:@"YES" forKey:@"paid"];
    [dict setObject:@"YES" forKey:@"reservable"];
    [dict setObject:@"pin_other.png" forKey:@"imageFilename"];
    [dict setObject:@"1.35" forKey:@"fee"];
    [dict setObject:[NSArray arrayWithObjects:@"Port 1", @"Port 2", @"Port 3", @"Port DC", nil] forKey:@"ports"];
    [ar addObject:dict];

    return ar;
}

+(NSMutableArray *)loadArrayWithReservations:(NSMutableArray *)ar
{
    NSString *txtToday;
    NSMutableDictionary *dict;
    ar = [[NSMutableArray alloc] init];

    txtToday = [Utils convertDateToStringMonthDayYear:[NSDate date]];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"r004" forKey:@"reservation_id"];
    [dict setObject:@"003" forKey:@"station_id"];
    [dict setObject:@"Ace Hardware" forKey:@"org_station_name"];
    [dict setObject:@"23033 Mission St" forKey:@"address_1"];
    [dict setObject:@"Campbell, CA 00000, USA" forKey:@"address_2"];

    [dict setObject:[NSString stringWithFormat:@"%@ 7:00 am", txtToday] forKey:@"start_time"];
    [dict setObject:[NSString stringWithFormat:@"%@ 8:00 am", txtToday] forKey:@"end_time"];
    [dict setObject:@"000000000003 - Nick Name Three" forKey:@"card"];
    [dict setObject:@"1.35" forKey:@"fee"];
    [dict setObject:@"Port DC" forKey:@"port_reserved"];
    [dict setObject:[NSArray arrayWithObjects:@"Port 1", @"Port 2", @"Port 3", @"Port DC", nil] forKey:@"ports"];
    [ar addObject:dict];


    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"r003" forKey:@"reservation_id"];
    [dict setObject:@"003" forKey:@"station_id"];
    [dict setObject:@"Ace Hardware" forKey:@"org_station_name"];
    [dict setObject:@"23033 Mission St" forKey:@"address_1"];
    [dict setObject:@"Campbell, CA 00000, USA" forKey:@"address_2"];
    [dict setObject:[NSString stringWithFormat:@"%@ 8:00 am", txtToday] forKey:@"start_time"];
    [dict setObject:[NSString stringWithFormat:@"%@ 12:30 pm", txtToday] forKey:@"end_time"];
    [dict setObject:@"000000000002 - Nick Name Two" forKey:@"card"];
    [dict setObject:@"1.35" forKey:@"fee"];
    [dict setObject:@"Port 3" forKey:@"port_reserved"];
    [dict setObject:[NSArray arrayWithObjects:@"Port 1", @"Port 2", @"Port 3", @"Port DC", nil] forKey:@"ports"];
    [ar addObject:dict];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"r001" forKey:@"reservation_id"];
    [dict setObject:@"001" forKey:@"station_id"];
    [dict setObject:@"ORG NAME / STATION NAME" forKey:@"org_station_name"];
    [dict setObject:@"0000 Any Street Name Goes Here," forKey:@"address_1"];
    [dict setObject:@"City Name, State, 00000, USA" forKey:@"address_2"];
    [dict setObject:[NSString stringWithFormat:@"%@ 1:00 pm", txtToday] forKey:@"start_time"];
    [dict setObject:[NSString stringWithFormat:@"%@ 2:30 pm", txtToday] forKey:@"end_time"];
    [dict setObject:@"000000000001 - Nick Name One" forKey:@"card"];
    [dict setObject:@"1.05" forKey:@"fee"];
    [dict setObject:@"Port 1" forKey:@"port_reserved"];
    [dict setObject:[NSArray arrayWithObjects:@"Port 1", @"Port 2", nil] forKey:@"ports"];
    [ar addObject:dict];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"r002" forKey:@"reservation_id"];
    [dict setObject:@"002" forKey:@"station_id"];
    [dict setObject:@"Target" forKey:@"org_station_name"];
    [dict setObject:@"101 W Garnett Ave" forKey:@"address_1"];
    [dict setObject:@"Santa Cruz, CA 95060, USA" forKey:@"address_2"];
    [dict setObject:[NSString stringWithFormat:@"%@ 3:30 pm", txtToday] forKey:@"start_time"];
    [dict setObject:[NSString stringWithFormat:@"%@ 7:30 pm", txtToday] forKey:@"end_time"];
    [dict setObject:@"000000000002 - Nick Name Two" forKey:@"card"];
    [dict setObject:@".99" forKey:@"fee"];
    [dict setObject:@"Port 2" forKey:@"port_reserved"];
    [dict setObject:[NSArray arrayWithObjects:@"Port 1", @"Port 2", nil] forKey:@"ports"];
    [ar addObject:dict];

    return ar;
}

+(NSMutableArray *)loadArrayWithCards:(NSMutableArray *)ar
{
    NSMutableDictionary *dict;
    ar = [[NSMutableArray alloc] init];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Nick Name One" forKey:@"nick_name"];
    [dict setObject:@"000000000001" forKey:@"serial_number"];
    [ar addObject:dict];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Nick Name Two" forKey:@"nick_name"];
    [dict setObject:@"000000000002" forKey:@"serial_number"];
    [ar addObject:dict];

    dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Nick Name Three" forKey:@"nick_name"];
    [dict setObject:@"000000000003" forKey:@"serial_number"];
    [ar addObject:dict];

    return ar;
}

+(NSMutableArray *)loadArrayWithPortChoices
{
    NSMutableArray *ar;

    ar = [[NSMutableArray alloc] init];
    [ar addObject:@"Port 1"];
    [ar addObject:@"Port 2"];

    return ar;
}

+(NSMutableArray *)loadArrayWithCardChoices
{
    NSMutableArray *ar;
    NSMutableArray *arCards;
    NSMutableDictionary *dict;
    NSString *txt;
    NSString *txtSerialNumber;
    NSString *txtNickName;

    ar = [[NSMutableArray alloc] init];
    arCards = [Utils loadObjFromDefaultsByName:@"arCards"];

    for (int n = 0; n < arCards.count; n++) {
        dict = [arCards objectAtIndex:n];
        txtSerialNumber = dict[@"serial_number"];
        txtNickName = dict[@"nick_name"];
        txt = [NSString stringWithFormat:@"%@ - %@", txtSerialNumber, txtNickName];
        [ar addObject:txt];
    }

    return ar;
}

#pragma mark - input helpers
//+(BOOL)textFieldShouldReturn:(UITextField *)textField arFirstResponders:(NSArray *)arFirstResponders
//{
//    int n = -1;
//    for (id obj in arFirstResponders) {
//        if ([[obj note] isEqualToString:textField.accessibilityLabel]) {
//            n = [arFirstResponders indexOfObject:obj];
//            break;
//        }
//    }
//
//    if (n == -1) {
//        return NO;
//    }
//
//    n++;
//    if (n >= arFirstResponders.count) {
//        n = 0;
//    }
//    id obj = [arFirstResponders objectAtIndex:n];
//    [obj becomeFirstResponder];
//
//    return YES;
//}
//
//+(void)textChanged:(id)sender
//{
//    if (!sender) {
//        return;
//    }
//    TextFieldCustom *tf = sender;
//
//    NSString *type = tf.note;
//    [Utils saveObjToDefaults:tf.text name:type];
//}
//
//+(void)closePickers:(NSArray *)arPickers{
//    for (id obj in arPickers) {
//        PickerView *pv = obj;
//        [pv.picker removeFromSuperview];
//
//        [pv removeFromSuperview];
//        pv = nil;
//    }
//}

+(void)resignFirstResponders:(NSArray *)arFirstResponders{
    for (id obj in arFirstResponders) {
        id obj0 = obj;
        if ([obj0 canPerformAction:@selector(resignFirstResponder) withSender:nil]) {
            [obj0 resignFirstResponder];
        }
    }
}

+(void)tapped:(UIView *)v scroll:(UIScrollView *)scroll
{
    [Utils animationOn];
    if ([v canPerformAction:@selector(resignFirstResponders) withSender:nil]) {
        [v performSelector:@selector(resignFirstResponders) withObject:nil];
    }
    if ([v canPerformAction:@selector(closePickers) withSender:nil]) {
        [v performSelector:@selector(closePickers) withObject:nil];
    }
    if ([scroll class] == [UIScrollView class]) {
        float yOffset = 0;
        [Utils animationOn];
        scroll.contentOffset = CGPointMake(0, yOffset);
        [Utils animationOff];
    } else {
        CGRect rect = v.frame;
        rect.origin.y = [Utils getYScroll];
        v.frame = rect;
    }
    if ([v canPerformAction:@selector(loseFocus) withSender:nil]) {
        [v performSelector:@selector(loseFocus) withObject:nil];
    }
    [Utils animationOff];
}

//+(void)gotFocus:(UIView *)v sender:(id)sender
//{
//    if ([v respondsToSelector:@selector(closePickers)]) {
//        [v performSelector:@selector(closePickers) withObject:nil];
//    }
//    if ([[sender superview] class] == [UIScrollView class]) {
//        UIScrollView *sv = (UIScrollView *)[sender superview];
//        float offsetY = [sender frame].origin.y - 150;  // dist from top (all controls)
//
//        // top limit
//        if (offsetY < 0) {
//            offsetY = 0;
//        }
//
//        // bot limit
//        float maxOffsetY = sv.contentSize.height - sv.frame.size.height + 215;  // distance above keyboard
//        if (offsetY > maxOffsetY) {
//            offsetY = maxOffsetY;
//        }
//        [Utils animationOn];
//        sv.contentOffset = CGPointMake(0, offsetY);
//        [Utils animationOff];
//    } else {
//        UIButton *but = (UIButton *)sender;
//        if (but.tag != 333) {
//            float offsetY = [sender frame].origin.y - 150;  // dist from top (all controls)
//
//            // top limit
//            if (offsetY < 0) {
//                offsetY = 0;
//            }
//
//            // bot limit
//            float maxOffsetY = 215;  // distance above keyboard
//            if (offsetY > maxOffsetY) {
//                offsetY = maxOffsetY;
//            }
//            if ([v canPerformAction:@selector(setFrame:) withSender:nil]) {
//                [Utils animationOn];
//                CGRect rect = v.frame;
//                rect.origin.y = -offsetY;
//                v.frame = rect;
//                [Utils animationOff];
//            }
//        }
//    }
//
//    // special case (check for default value)
//    if ([[sender note] isEqualToString:STR_NOTE_MY_ACCOUNT_CHOOSE_EVATAR_EVATAR_NAME]) {
//        TextFieldCustom *tf = sender;
//        if ([tf.text isEqualToString:STR_NAME_YOUR_EVATAR]) {
//            tf.text = STR_NOTE_ZERO_LENGTH;
//        }
//    }
//    if ([v respondsToSelector:@selector(gotFocus2:)]) {
//        [v performSelector:@selector(gotFocus2:) withObject:sender];
//    }
//}
//
//+(NSString *)validateInputs2:(NSArray *)arInputs view:(id)v
//{
//    NSString *txtError = @"";
//    for (id obj in arInputs) {
//        if (![obj validate]) {
//            txtError = [txtError stringByAppendingFormat:@"%@\n", [obj validationNote]];
//        }
//    }
//
//    BOOL ynValidated = YES;
//    if (txtError.length > 0) {
//        ynValidated = NO;
//    }
//    NSString *txtNote = NSStringFromClass([v class]);
//    [Utils saveObjToDefaults:[NSNumber numberWithBool:ynValidated] name:txtNote];
//    return txtError;
//}
//
//+(NSString *)validateInputs:(NSArray *)arInputs
//{
//    NSString *txtError = @"";
//    for (id obj in arInputs) {
//        if (![obj validate]) {
//            txtError = [txtError stringByAppendingFormat:@"%@\n", [obj validationNote]];
//        }
//    }
//    if (txtError.length == 0) {
//        txtError = nil;
//    }
//    return txtError;
//}

+(CGRect)getRectForSaveChangesButtonFromImageNamedHeightCentered:(NSString *)imageName view:(id)view
{
    UIImage *img = [UIImage imageNamed:imageName];
    float w = img.size.width;
    float x = [view frame].size.width - w - 10;
    float h = img.size.height;
    float hView;
    if ([view class] == [UIScrollView class]) {
        hView = [view contentSize].height;
    } else {
        x = [Utils getXX:x];
        hView = [view frame].size.height;
    }
    float y = (hView - h) / 2;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

+(CGRect)getRectForSaveChangesButtonFromImageNamed:(NSString *)imageName view:(id)view
{
    UIImage *img = [UIImage imageNamed:imageName];
    float w = img.size.width;
    float x = [view frame].size.width - w - 10;
    float h = img.size.height;
    float hView;
    if ([view class] == [UIScrollView class]) {
        hView = [view contentSize].height;
    } else {
        x = [Utils getXX:x];
        hView = [view frame].size.height;
    }
    float y = hView - h - 10;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

+(void)resetViewOriginY:(id)v
{
    if ([v canPerformAction:@selector(setFrame:) withSender:nil]) {
        CGRect rect = [v frame];
        rect.origin.y = 0;
        [v setFrame:rect];
    }
}

+(void)addSwipeRightToViewWithAction:(id)view action:(NSString *)action
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:view action:NSSelectorFromString(action)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [view addGestureRecognizer:swipe];
}

+(NSString *)convertDateToStringMonthDayYear:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setAMSymbol:@"am"];
    [outputFormatter setPMSymbol:@"pm"];
    [outputFormatter setDateFormat:@"MM/dd/yy"];

    return [outputFormatter stringFromDate:date];
}

//+(PickerDateTime *)addPickerDateTimeAtRect:(CGRect)rect caption:(NSString *)caption note:(NSString *)note choices:(NSArray *)ar delegate:(id)delegate addSubViewTo:(id)parentView parentViewForPicker:(id)parentViewForPicker ynRequiredCaption:(BOOL)ynRequiredCaption validationType:(NSString *)validationType validationNote:(NSString *)validationNote
//{
//    CGRect rectCaption = rect;
//    rectCaption.origin.x = rectCaption.origin.x - 92;
//    rectCaption.origin.y = rectCaption.origin.y + 25;
//    [Utils addCaption:rectCaption view:parentView caption:caption];
//
//    PickerDateTime *pv = [[PickerDateTime alloc] initWithFrame:rect];
//
//    pv.title = caption;
//    [pv setCpViewDelegate:delegate];
//
//    pv.arDropDown = (NSMutableArray *)ar;
//
//    // add no choice to choices
//    [pv.arDropDown insertObject:@"" atIndex:0];
//
//    pv.scroll = parentView;
//    pv.note = note;
//    pv.validationNote = validationNote;
//    pv.validationType = validationType;
//
//    [pv addDropDown:rect note:note];
//
//    pv.parentViewForPicker = parentViewForPicker;
//
//    return pv;
//}

+(NSString *)checkReservationsForAvailability:(NSArray *)ar checkReservation:(NSDictionary *)dictCheck ignoreReservation:(NSDictionary *)dictIgnore
{
    NSString *start_time_check;
    NSString *end_time_check;
    NSDate *dateStart_check;
    NSDate *dateEnd_check;

    BOOL ynOverlap;
    NSDictionary *dictOverlap;
    NSString *txt;
    int nOverlap;
    int startSearch;


    // return next available alternative, if available
    // keep checking: starts at end of conflicting reservation, same duration as check

    start_time_check = dictCheck[@"start_time"];
    end_time_check = dictCheck[@"end_time"];
    dateStart_check = [Utils dateFromString:start_time_check];
    dateEnd_check = [Utils dateFromString:end_time_check];

    // duration of check
    NSTimeInterval tDuration_check = [dateEnd_check timeIntervalSinceDate:dateStart_check];

    nOverlap = -1;
    do {
        // start after last overlap
        startSearch = nOverlap + 1;

        // check for overlap
        ynOverlap = NO;
        for (int n = startSearch; n < ar.count; n++) {
            dictOverlap = [ar objectAtIndex:n];

            // avoid ignore
            if (dictIgnore != dictOverlap) {
                ynOverlap = [Utils overlapTwoReservations:dictOverlap otherReservation:dictCheck];
                if (ynOverlap) {
                    nOverlap = n;
                    break;
                }
            }
        }

        if (ynOverlap) {
            // check start: immediately after overlap
            start_time_check = dictOverlap[@"end_time"];
            dateStart_check = [Utils dateFromString:start_time_check];
            [dictCheck setValue:start_time_check forKey:@"start_time"];

            // check end: same duration
            dateEnd_check = dateStart_check;
            dateEnd_check = [dateEnd_check dateByAddingTimeInterval:tDuration_check];
            end_time_check = [Utils convertDateToString:dateEnd_check];
            [dictCheck setValue:end_time_check forKey:@"end_time"];
        } else {
            if (startSearch == 0) {
                return nil;
            } else {
                NSString *start_time_check_hours_mins = [Utils convertDateToStringHoursMinutes:dateStart_check];
                NSString *end_time_check_hours_mins = [Utils convertDateToStringHoursMinutes:dateEnd_check];
                txt = [NSString stringWithFormat:@"However the plug is available\nbetween %@ - %@", start_time_check_hours_mins, end_time_check_hours_mins];
                return txt;
            }
        }
    } while (YES);
}

+(NSDate *)dateFromString:(NSString *)strDate
{
    if (!strDate) {
        return nil;
    }
    strDate = [strDate stringByReplacingOccurrencesOfString:@" - " withString:@" "];


    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setAMSymbol:@"am"];
    [outputFormatter setPMSymbol:@"pm"];
    [outputFormatter setDateFormat:@"M/d/yy h:mm a"];

    NSDate *date = [outputFormatter dateFromString:strDate];

    //    if (!date) {
    //        NSLog(@"Utils dateFromString: unable to convert string to date: %@", strDate);
    //    }

    return date;
}

+(NSString *)convertDateToStringWeekDayAndDate:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setAMSymbol:@"am"];
    [outputFormatter setPMSymbol:@"pm"];
    [outputFormatter setDateFormat:@"EEEE MM/dd/yy"];

    return [outputFormatter stringFromDate:date];
}

+(NSString *)convertDateToStringHoursMinutes:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setAMSymbol:@"am"];
    [outputFormatter setPMSymbol:@"pm"];
    [outputFormatter setDateFormat:@"h:mm a"];

    return [outputFormatter stringFromDate:date];
}

+(BOOL)isTimeBeforeTime:(NSDate *)dateCheck beforeTime:(NSDate *)date
{
    NSTimeInterval interval = [date timeIntervalSinceDate:dateCheck];
    if (interval >= 0) {
        return YES;
    } else {
        return NO;
    }
}


+(BOOL)overlapTwoReservations:(NSDictionary *)dictReservation1 otherReservation:(NSDictionary *)dictReservation2
{
    BOOL ynOverlap;
    NSString *start_time;
    NSString *end_time;
    NSString *start_time_check;
    NSString *end_time_check;
    NSDate *dateStart;
    NSDate *dateEnd;
    NSDate *dateStart_check;
    NSDate *dateEnd_check;
    NSString *port_reserved;
    NSString *port_reserved_check;
    NSString *station_id;
    NSString *station_id_check;

    start_time = dictReservation1[@"start_time"];
    dateStart = [Utils dateFromString:start_time];
    end_time = dictReservation1[@"end_time"];
    dateEnd = [Utils dateFromString:end_time];
    port_reserved = dictReservation1[@"port_reserved"];
    station_id = dictReservation1[@"station_id"];

    start_time_check = dictReservation2[@"start_time"];
    dateStart_check = [Utils dateFromString:start_time_check];
    end_time_check = dictReservation2[@"end_time"];
    dateEnd_check = [Utils dateFromString:end_time_check];
    port_reserved_check = dictReservation2[@"port_reserved"];
    station_id_check = dictReservation2[@"station_id"];


    ynOverlap = YES;
    if ([Utils isTimeBeforeTime:dateEnd_check beforeTime:dateStart]) {
        ynOverlap = NO;
    }

    if ([Utils isTimeBeforeTime:dateEnd beforeTime:dateStart_check]) {
        ynOverlap = NO;
    }

    if (ynOverlap) {
        // port
        if (![port_reserved isEqualToString:port_reserved_check]) {
            ynOverlap = NO;
        }
    }

    if (ynOverlap) {
        // station id
        if (![station_id isEqualToString:station_id_check]) {
            ynOverlap = NO;
        }
    }

    return ynOverlap;
}
+(NSString *)convertDateToString:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setAMSymbol:@"am"];
    [outputFormatter setPMSymbol:@"pm"];
    [outputFormatter setDateFormat:@"M/d/yy - h:mm a"];

    return [outputFormatter stringFromDate:date];
}

#pragma mark - Defaults


+(void)resetDefaultsForActivateCard
{
    if (ynResetDefaults == 0) {
        return;
    }
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_ACTIVATE_CARD_NICK_NAME];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_ACTIVATE_CARD_SERIAL_NUMBER];
}

+(void)resetDefaultsForConditionalPrompts
{
    // support overlay (always)
    [Utils saveObjToDefaults:nil name:CONST_DEFAULT_OPEN_FILTERS];
    [Utils saveObjToDefaults:nil name:CONST_DEFAULT_OPEN_OVERLAY];

    NSLog(@"reset: %d", ynResetDefaults);
    if (ynResetDefaults == 0) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // map filter first time
    [defaults setObject:nil forKey:CONST_DEFAULT_ynDidShowPromptYourCar];

    // no credit card
    [defaults setObject:nil forKey:CONST_DEFAULT_ynDidShowPromptNoCreditCard];

    // connections first time
    [defaults setObject:nil forKey:CONST_DEFAULT_ynDidShowPromptRemindConnections];

    // incomplete profile
    [defaults setObject:nil forKey:CONST_DEFAULT_ynDidShowPromptCompleteProfile];

    // need card to start session
    [defaults setObject:nil forKey:CONST_DEFAULT_ynDidShowPromptNeedCardStart];

    // Driver Tips prompts
    [defaults setObject:nil forKey:CONST_DEFAULT_ynDidShowPromptRemindTipsCredit];
    [defaults setObject:nil forKey:CONST_DEFAULT_ynDidShowPromptRemindTipsEvatar];
    [defaults setObject:nil forKey:CONST_DEFAULT_ynDidShowPromptRemindTipsCreditEvatar];

}

+(void)resetDefaultsForMailingAddress
{
    if (ynResetDefaults == 0) {
        return;
    }
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_FIRST_NAME];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_LAST_NAME];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_GENDER];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_ADDRESS_1];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_ADDRESS_2];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_CITY];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_POSTAL_CODE];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_STATE];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_MAILING_ADDRESS_COUNTRY];
}

+(void)resetDefaultsForNotifications
{
    if (ynResetDefaults == 0) {
        return;
    }
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_NOTIFICATIONS_EMAIL_NOTIFICATION];
}

+(void)resetDefaultsForPayment
{
    if (ynResetDefaults == 0) {
        return;
    }
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_PAYMENT_CURRENCY];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_CARDHOLDER];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_CARDNUMBER];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_CCV];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_PAYMENT_MONTH];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_PAYMENT_YEAR];
}

+(void)resetDefaultsForSignupSignup
{
    if (ynResetDefaults == 0) {
        return;
    }
    [Utils saveObjToDefaults:[NSNumber numberWithInt:0] name:STR_NOTE_MY_ACCOUNT_CHOOSE_EVATAR_EVATAR];
    [Utils saveObjToDefaults:STR_NAME_YOUR_EVATAR name:STR_NOTE_MY_ACCOUNT_CHOOSE_EVATAR_EVATAR_NAME];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_EMAIL];
    [Utils saveObjToDefaults:[NSNumber numberWithInt:1] name:STR_NOTE_YN_EMAIL_LOGIN];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_USERNAME];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_PASSWORD];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_PASSWORD_VERIFY];
    [Utils saveObjToDefaults:[NSNumber numberWithInt:0] name:STR_NOTE_SIGNUP_AGREE_TERMS];
}

+(void)resetDefaultsForTextAlertView
{
    if (ynResetDefaults == 0) {
        return;
    }
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_TEXT_ALERT_COUNTRY_CODE];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_TEXT_ALERT_MOBILE_NUMBER];
}

+(void)resetDefaultsForYourCar
{
    if (ynResetDefaults == 0) {
        return;
    }
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_YOUR_CAR_MAKE];
    [Utils saveObjToDefaults:STR_NOTE_ZERO_LENGTH name:STR_NOTE_YOUR_CAR_MODEL];
}

+(UIAlertView *)showAlertWithTitle2:(NSString *)title
                            message:(NSString *)message
                           delegate:(id)delegate
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:delegate
										  cancelButtonTitle:STR_BUTTON_TITLE_OK
										  otherButtonTitles:nil];
	[alert show];
	return alert;
}
+(void)alternateBackground:(UIView *)v sequence:(int)sequence
{
    float x;
    float y;
    float w;
    float h;
    CGRect rect;
    UILabel *lab;
    //    UIImage *img;
    
    //    img = [UIImage imageNamed:@"reservation_background_dark.png"];
    rect = v.frame;
    [Utils addImageAtRect:rect
            imageFilename:@"reservation_background_light.png"
             addSubViewTo:v];
    
    
    // overlay (light/dark)
    if ((sequence % 2) == 0) {
        x = 0;
        y = 0;
        w = v.frame.size.width;
        h = v.frame.size.height;
        rect = CGRectMake(x, y, w, h);
        lab = [[UILabel alloc] initWithFrame:rect];
        lab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.25];
        [v addSubview:lab];
    }
    
    // darker to contrast icons
    x = 0;
    y = 0;
    w = v.frame.size.width;
    h = v.frame.size.height;
    rect = CGRectMake(x, y, w, h);
    lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.25];
    [v addSubview:lab];
}
+(void)addSwipeRightBack:(id)target
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:@selector(swipeRight)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [target performSelector:@selector(addGestureRecognizer:) withObject:swipe];
}

+(NSDate *)addMinutesToDate:(NSDate *)date minutes:(int)minutesAdd
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [cal setTimeZone:[NSTimeZone systemTimeZone]];

    NSDateComponents * comp = [cal components:( NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];

    int minutes = [comp minute];
    minutes = minutes + minutesAdd;
    [comp setMinute:minutes];

    date = [cal dateFromComponents:comp];
    return date;
}

+(NSString *)convertDateToString15Minutes:(NSDate *)date
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [cal setTimeZone:[NSTimeZone systemTimeZone]];

    NSDateComponents * comp = [cal components:( NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];

    int minutes = [comp minute];
    minutes = (int) minutes / 15 * 15;
    [comp setMinute:minutes];


    date = [cal dateFromComponents:comp];


    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setAMSymbol:@"am"];
    [outputFormatter setPMSymbol:@"pm"];
    [outputFormatter setDateFormat:@"M/d/yy - h:mm a"];

    return [outputFormatter stringFromDate:date];
}

+(BOOL)validatePhone10:(NSString *)txt
{
    if (![self isPhone10:txt]) {
        return NO;
    }
    return YES;
}

+(BOOL)validateZip5:(NSString *)txt
{
    if (![self isZip5:txt]) {
        return NO;
    }
    return YES;
}

+(BOOL)isZip5:(NSString *)txt
{
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *txt2 = [txt stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!([txt2 rangeOfCharacterFromSet:notDigits].location == NSNotFound))
    {
        return NO;
    }
    if (txt2.length != 5) {
        return NO;
    }
    return YES;
}

+(BOOL)isPhone10:(NSString *)txt
{
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *txt2 = [txt stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!([txt2 rangeOfCharacterFromSet:notDigits].location == NSNotFound))
    {
        return NO;
    }
    if (txt2.length != 10) {
        return NO;
    }
    return YES;
}

//+(CustomNavigationBarView *)addNavigationBarToVC:(id)vc imageName:(NSString *)imageName title:(NSString *)title height:(float)height
//{
//    CGFloat controlWidth        =  [Utils getWW];
//    CGFloat controlHeight       =   height;
//    CGFloat startXCoordinate    =   0;
//    CGFloat startYCoordinate    =   [Utils getYScroll];
//    CGRect  controlRect         =   CGRectZero;
//    
//    CustomNavigationBarView *customNavigationBarView =   [[CustomNavigationBarView alloc] initWithFrame:CGRectZero];
//    customNavigationBarView.firstButtonTitle    =   nil;
//    customNavigationBarView.secondButtonTitle   =   nil;
//    customNavigationBarView.screenTitle         =   title;
//    [customNavigationBarView setCpViewDelegate:vc];
//    
//    [[vc view] addSubview:customNavigationBarView];
//    
//    controlRect =   CGRectMake(startXCoordinate, startYCoordinate, controlWidth, controlHeight);
//    [customNavigationBarView setFrame:controlRect];
//    customNavigationBarView.isBackOnlyVisible = [NSNumber numberWithBool:YES];
//    [customNavigationBarView arrange];
//    
//    customNavigationBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
//    return customNavigationBarView;
//}

#pragma mark - gte common post header
+(NSDictionary *)getPostHeaderWithCookieForRequest:(NSMutableURLRequest*)request
{

//    NSDictionary * headers;
//    //ELSE CHECK FOR THE PREFERENCE DICTIONARY
//    NSDictionary *preferenceData = [Utils readFromPlist:CONST_COULOMBTECH_PREFERENCE_FILE keyName:CONST_LOGIN_CREDENTIAL_DICTIONARY];
//    NSString    *decryptedToken =   [NSString doDecipher:preferenceData[CONST_SERVER_AUTH_TOKEN]];
//    
////    NSString    *strAuthToken   =   [preferenceData objectForKey:CONST_SERVER_AUTH_TOKEN];
//    NSLog(@"auth token is %@",decryptedToken);
//    if (decryptedToken.length > 0)
//    {
//        NSDictionary *properties =  [NSDictionary dictionaryWithObjectsAndKeys:
//                                     request.URL.host, NSHTTPCookieDomain,
//                                     request.URL.path, NSHTTPCookiePath,
//                                     CONST_SERVER_COULOMB_SESSION_TOKEN, NSHTTPCookieName,
//                                     decryptedToken, NSHTTPCookieValue,
//                                     nil];
//        NSHTTPCookie *cookie = (NSHTTPCookie*)[NSHTTPCookie cookieWithProperties:properties];
//        
//        NSArray* cookies = [NSArray arrayWithObjects: cookie, nil];
//        
//        headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
//    }
    return nil;//headers
}

#pragma mark - Client info
+(NSString *)getClientName
{
    //insert client
    NSMutableString    *clientDescription =   (NSMutableString*)[[UIDevice currentDevice] model];
    NSArray *arr    =   [clientDescription componentsSeparatedByString:@" "];
    if ([arr count] > 0)
    {
        clientDescription   =   [arr objectAtIndex:0];
        return clientDescription;
    }
    
    return @"";
}

#pragma mark - clearUserSessionVariables
+(void)clearUserSessionVariables
{
//    NSLogInfo(@"Clear auth token and user data");
//    //SAVE THE SUCCESSFULLY LOGGED IN USER' EMAIL ID
//    NSMutableDictionary *dictAuthToken	=	[[NSMutableDictionary alloc] init];
//    [dictAuthToken setValue:@"" forKey:CONST_SERVER_AUTH_TOKEN];
//    [dictAuthToken setValue:@"" forKey:CONST_SERVER_USER_ID];
//    [dictAuthToken setValue:@"" forKey:CONST_SERVER_USER_NAME];
//    
//    //write contents to property list
//    BOOL result = [Utils writeToPList:CONST_COULOMBTECH_PREFERENCE_FILE keyName:CONST_LOGIN_CREDENTIAL_DICTIONARY contents:dictAuthToken];
//    
//    if (result) {
//        //DO SOMETHING
//    }
//    dictAuthToken = nil;
//
//    //pre populate the user variavles that are independent of the user
//    NSDictionary    *appDict    =   [Utils readFromPlist:CONST_COULOMBTECH_PREFERENCE_FILE keyName:CONST_APP_INFORMATION_DICTIONARY];
//    //Login dictionary
//    NSMutableDictionary *appInfoDict                                =   [[NSMutableDictionary alloc] init];
//    appInfoDict[CONST_SERVER_JAVA_URL]                              =   [Utils validateString:appDict[CONST_SERVER_JAVA_URL]];
//    appInfoDict[CONST_SERVER_LATEST_VERSION]                        =   [Utils validateString:appDict[CONST_SERVER_LATEST_VERSION]];
//    appInfoDict[CONST_SERVER_LAST_AUTHORIZATION_TIMESTAMP]          =   @"";
//    appInfoDict[CONST_SERVER_MY_ACCOUNT_SESSION_LENGTH_IN_SECONDS]  =   appDict[CONST_SERVER_MY_ACCOUNT_SESSION_LENGTH_IN_SECONDS];
//
//    //write contents to property list
//    BOOL appInfoDictResult = [Utils writeToPList:CONST_COULOMBTECH_PREFERENCE_FILE keyName:CONST_APP_INFORMATION_DICTIONARY contents:appInfoDict];
//    
//    if (appInfoDictResult) {
//        //DO SOMETHING
//    }
//    appInfoDict = nil;
//    
//    NSDictionary *filterDict                                =   [FilterModel defaultsForPlist];
//    //write contents to property list
//    BOOL filterDictResult = [Utils writeToPList:CONST_COULOMBTECH_PREFERENCE_FILE keyName:CONST_ADVANCED_FILTER_DICTIONARY contents:filterDict];
//    
//    if (filterDictResult) {
//        //DO SOMETHING
//    }
//    filterDict = nil;
}

#pragma mark - User Authorization required to access Feature
+(BOOL)userAuthorizationExpired
{
//    BOOL isUserAuthorizationExpired =   NO;
//    //check for session auth validity based on the length of session parameter from the server
//    
//    NSDictionary *appInfoDict               =   [Utils readFromPlist:CONST_COULOMBTECH_PREFERENCE_FILE
//                                                  keyName:CONST_APP_INFORMATION_DICTIONARY];
//    
//    NSLogUser(@"print info for info dict to check user validity");
//    [Utils printKeyValuesForDictionary:appInfoDict];
//    
//    long   lengthOfAuthSession           =   [[appInfoDict objectForKey:CONST_SERVER_MY_ACCOUNT_SESSION_LENGTH_IN_SECONDS] longValue];
//    long  lastAuthorizationTimeInterval     =   [[appInfoDict objectForKey:CONST_SERVER_LAST_AUTHORIZATION_TIMESTAMP] longValue];
//    long  currentTimeInterval               =   [NSDate timeIntervalSinceReferenceDate];
//    long timeGapBetweenAuthorization        =   (currentTimeInterval - lastAuthorizationTimeInterval);
//    
//    if (timeGapBetweenAuthorization > lengthOfAuthSession)
//    {
//        isUserAuthorizationExpired   =   YES;
//    }
    return NO;//isUserAuthorizationExpired
}
@end
