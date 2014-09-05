//
//  ServerErrorMessages.h
//  ChargePoint
//
//  Created by Manish Kumar on 01/02/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//

#pragma mark - signup Error Message
#define STR_ERROR_MESSAGE_INVALID_USERNAME                                  NSLocalizedString(@"Invalid username.",@"")
#define STR_ERROR_MESSAGE_INVALID_CHARACTERS                                NSLocalizedString(@"Username must be between 6 and 32 characters.",@"")

#define STR_ERROR_MESSAGE_USERNAME_REQUIRED                                 NSLocalizedString(@"Please provide your username.",@"")
#define STR_ERROR_MESSAGE_USERNAME_NO_SPACE_ALLOWED                         NSLocalizedString(@"Invalid Username. No spaces allowed.",@"")

#define STR_ERROR_MESSAGE_USERNAME_ALREADY_EXISTS                           NSLocalizedString(@"The username you entered already exists.",@"")

#define STR_ERROR_MESSAGE_INVALID_BLANK_EMAIL                               NSLocalizedString(@"Please provide your email address.",@"")
#define STR_ERROR_MESSAGE_INVALID_EMAIL                                     NSLocalizedString(@"Email address must contain a valid email address.",@"")

#define STR_ERROR_MESSAGE_INVALID_PASSWORD                                  NSLocalizedString(@"Passwords must be at least 6 characters and contain at least 2 numbers.",@"")
#define STR_ERROR_MESSAGE_INVALID_PASSWORD_CHARACTER                        NSLocalizedString(@"Invalid Password. Please use valid characters.",@"")

#define STR_ERROR_MESSAGE_PASSWORD_REQUIRED                                 NSLocalizedString(@"Passwords must be at least 6 characters and contain at least 2 numbers.",@"")
#define STR_ERROR_MESSAGE_PASSWORD_DO_NOT_MATCH                             NSLocalizedString(@"Verify Password does not match.",@"")
#define STR_ERROR_MESSAGE_PASSWORD_NO_SPACE_ALLOWED                         NSLocalizedString(@"Invalid Password. No spaces allowed.",@"")

#define STR_ERROR_MESSAGE_INVALID_EVATAR_NAME                               NSLocalizedString(@"EVatar name must be between 6 and 32 characters.",@"")
#define STR_ERROR_MESSAGE_EVATAR_NAME_REQUIRED                              NSLocalizedString(@"Please provide your EVatar name.",@"")
#define STR_ERROR_MESSAGE_EVATAR_NO_SPACE_ALLOWED                           NSLocalizedString(@"Invalid EVatar name. No spaces allowed.",@"")
#define STR_ERROR_MESSAGE_EVATAR_NAME_ALREADY_EXISTS                        NSLocalizedString(@"This EVatar name already exists. Please provide a different name.",@"")
#define STR_ERROR_MESSAGE_INVALID_EVATAR                                    NSLocalizedString(@"Please select an EVatar.",@"")
#define STR_ERROR_MESSAGE_EVATAR_IMAGE_REQUIRED                             NSLocalizedString(@"Please select an EVatar image.",@"")

#define STR_ERROR_MESSAGE_AGREE_TO_TERMS                                    NSLocalizedString(@"Please accept Terms & Conditions.",@"")


#pragma mark - Add a credit card Error Message
#define STR_ERROR_MESSAGE_LANG_TXT_CC_GENERIC_FAIL                          NSLocalizedString(@"We cannot process your request at this time. Please try again shortly. Our apologies.",@"")

#define STR_ERROR_MESSAGE_FIRSTNAME_REQUIRED                                NSLocalizedString(@"Please enter First Name.",@"")
#define STR_ERROR_MESSAGE_LASTNAME_REQUIRED                                 NSLocalizedString(@"Please enter Last Name.",@"")
#define STR_ERROR_MESSAGE_GENDER_REQUIRED                                   NSLocalizedString(@"Please select your Gender.",@"")

#pragma mark - mailing address
#define STR_ERROR_MESSAGE_ADDRESS_LINE_ONE_REQUIRED                         NSLocalizedString(@"Please enter address line 1.",@"")
#define STR_ERROR_MESSAGE_INVALID_CONTACT_ADDRESS                           NSLocalizedString(@"Invalid contact address.",@"")
#define STR_ERROR_MESSAGE_ADDRESS_LINE_TWO_REQUIRED                         NSLocalizedString(@"Please enter address line 2.",@"")
#define STR_ERROR_MESSAGE_ADDRESS_ZIP_REQUIRED                              NSLocalizedString(@"Please enter Postal code.",@"")
#define STR_ERROR_MESSAGE_ADDRESS_ZIP_INVALID                               NSLocalizedString(@"Invalid Postal code.",@"")
#define STR_ERROR_MESSAGE_ADDRESS_CITY_REQUIRED                             NSLocalizedString(@"Please enter City.",@"")
#define STR_ERROR_MESSAGE_COUNTRY_REQUIRED                                  NSLocalizedString(@"Please select a valid Country.",@"")
#define STR_ERROR_MESSAGE_STATE_REQUIRED                                    NSLocalizedString(@"Please select a valid State.",@"")

#pragma mark - Shipping address
#define STR_ERROR_MESSAGE_SHIPPING_ADDRESS_LINE_ONE_REQUIRED                         NSLocalizedString(@"Please enter shipping address line 1.",@"")
#define STR_ERROR_MESSAGE_SHIPPING_ADDRESS_LINE_TWO_REQUIRED                         NSLocalizedString(@"Please enter shipping address line 2.",@"")
#define STR_ERROR_MESSAGE_SHIPPING_ADDRESS_ZIP_REQUIRED                              NSLocalizedString(@"Please enter shipping Postal code.",@"")
#define STR_ERROR_MESSAGE_SHIPPING_ADDRESS_ZIP_INVALID                               NSLocalizedString(@"Invalid shipping Postal code.",@"")
#define STR_ERROR_MESSAGE_SHIPPING_ADDRESS_CITY_REQUIRED                             NSLocalizedString(@"Please enter shipping City.",@"")
#define STR_ERROR_MESSAGE_SHIPPING_COUNTRY_REQUIRED                                  NSLocalizedString(@"Please select a valid shipping Country.",@"")
#define STR_ERROR_MESSAGE_SHIPPING_STATE_REQUIRED                                    NSLocalizedString(@"Please select a valid shipping State.",@"")
#define STR_ERROR_MESSAGE_INVALID_SHIPPING_ADDRESS                           NSLocalizedString(@"Invalid shipping address.",@"")
#pragma mark - Activate Cards
#define STR_ERROR_MESSAGE_NICKNAME_REQUIRED                                 NSLocalizedString(@"Enter nick name.",@"")
#define STR_ERROR_MESSAGE_SERIAL_NUMBER_REQUIRED                            NSLocalizedString(@"Enter serial number.",@"")
#define STR_ERROR_MESSAGE_SERIAL_NUMBER_INVALID                             NSLocalizedString(@"Invalid serial number",@"")
#define STR_ERROR_MESSAGE_SERIAL_NUMBER_DUPLICATE                           NSLocalizedString(@"Duplicate serial number",@"")
#define STR_ERROR_MESSAGE_CREDIT_CARD_DETAILS_NOTA_AVAILABLE                NSLocalizedString(@"Credit Card details not available.",@"")
#define STR_ERROR_MESSAGE_INVALID_POST_DATA                                 NSLocalizedString(@"Please provide valid data in fields.",@"")
#define STR_ERROR_MESSAGE_CARD_LIMIT_EXCEEDED                               NSLocalizedString(@"Card limit exceeded. Maximum number of allowed cards is %d. You have exceeded the limit by %d.",@"")
#define STR_ERROR_MESSAGE_CARDS_DATA_EMPTY                                  NSLocalizedString(@"Please provide valid data in fields.",@"")
#define STR_ERROR_MESSAGE_UNKNOWN_ERROR                                     NSLocalizedString(@"An unknown error occured.",@"")
//#define STR_ERROR_MESSAGE_INVALID_USERNAME                                  NSLocalizedString(@"Invalid username.",@"")

#define STR_ERROR_MESSAGE_AUTHORIZATION_FAILED                              NSLocalizedString(@"Invalid user session. Please log in again.",@"")

#pragma mark - Start Session
#define STR_ERROR_MESSAGE_STATION_PORT_ALREADY_CHARGING               NSLocalizedString(@"You are already charging on this station.",@"")
#define STR_ERROR_MESSAGE_CONTACT_ERROR_TRY_AGAIN                     NSLocalizedString(@"Unable to start session. Please try again.",@"")
#define STR_ERROR_MESSAGE_SESSION_COULD_NOT_BE_STARTED                NSLocalizedString(@"Unable to start session. Please try again.",@"")
#define STR_ERROR_MESSAGE_FREE_USER_CANNOT_START_CHARGING             NSLocalizedString(@"To start charging on a station with fees, add a credit card to your account by going to My Account.",@"")
#define STR_ERROR_MESSAGE_STATION_RESERVED_BY_OTHER_CARD              NSLocalizedString(@"Station reserved by other.",@"")
#define STR_ERROR_MESSAGE_RESERVATION_REQUIRED                        NSLocalizedString(@"You need to resreve station before start.",@"")
#define STR_ERROR_MESSAGE_SERIAL_SESSION_ACTIVE                       NSLocalizedString(@"You are already charging on this station.",@"")
#define STR_ERROR_MESSAGE_VIRTUAL_CARD_DOES_NOT_EXISTS                NSLocalizedString(@"No Mobile ChargePoint Card associated with this account.",@"")
#define STR_ERROR_MESSAGE_VIRTUAL_CARD_SESSION_IN_PROGRESS            NSLocalizedString(@"You are already charging on this station.",@"")
#define STR_ERROR_MESSAGE_STATION_ERROR_SESSION_START                 NSLocalizedString(@"Unable to start session. Please try again.",@"")

#pragma mark -     Stop Session
#define STR_ERROR_MESSAGE_STATION_PORT_NOT_CHARGING                   NSLocalizedString(@"No session running on this station.",@"")
#define STR_ERROR_MESSAGE_SESSION_COULD_NOT_BE_STOPPED                NSLocalizedString(@"Unable to stop session.",@"")

#pragma mark - Dialing code
#define STR_ERROR_MESSAGE_DIALING_CODE_REQUIRED                       NSLocalizedString(@"Please select a valid dialing code.",@"")
#define STR_ERROR_MESSAGE_INVALID_DIALING_CODE                          NSLocalizedString(@"Invalid Dialing code.",@"")

#pragma mark - Mobile number
#define STR_ERROR_MESSAGE_MOBLIE_REQUIRED                               NSLocalizedString(@"Please provide a valid mobile number.",@"")
#define STR_ERROR_MESSAGE_MOBILE_LEN_FALL_SHORT_OR_INVLID               NSLocalizedString(@"Mobile number length fall short or invalid.",@"")
#define STR_ERROR_MESSAGE_MOBILE_LEN_EXCEEDED_OR_INVLID                 NSLocalizedString(@"Mobile number length exceeded or invalid.",@"")
#define STR_ERROR_MESSAGE_MOBILE_INVALID                                NSLocalizedString(@"Please provide a valid mobile number.",@"")
#define STR_ERROR_MESSAGE_INVALID_GENDER                                NSLocalizedString(@"Please select a valid Gender.",@"")

#pragma mark - security Q & A
#define STR_ERROR_MESSAGE_SECURITY_QUESTION_REQUIRED                 NSLocalizedString(@"Please select a valid security question.",@"")
#define STR_ERROR_MESSAGE_SECURITY_ANSWER_REQUIRED                                NSLocalizedString(@"Please provide a security answer.",@"")

#pragma mark - free cards
#define STR_ERROR_MESSAGE_USER_ALREADY_HAS_FREE_CARDS                                NSLocalizedString(@"You already have free cards.",@"")

#pragma mark - Generic Error Messages

#pragma mark - purchase card using existing cc
#define STR_ERROR_MESSAGE_CC_TIMEOUT                                    NSLocalizedString(@"Could Not connect to Payment Gateway. Please try again Later.", @"")
#define STR_ERROR_MESSAGE_CC_MISSING_FIELDS                             NSLocalizedString(@"Your request is missing one or more required fields.", @"")
#define STR_ERROR_MESSAGE_CC_INCORRECT_INFORMATION                      NSLocalizedString(@"One or more fields in your request contains incorrect information.", @"")
#define STR_ERROR_MESSAGE_CC_UNABLE_TO_VERIFY                           NSLocalizedString(@"Our apologies, we are unable to verify this transaction. Please try creating your account again and contact your credit card company to confirm accurate billing.", @"")
#define STR_ERROR_MESSAGE_CC_ADDRESS_DOES_NOT_MATCH                     NSLocalizedString(@"The billing address you submitted does not match the billing address for this card.", @"")
#define STR_ERROR_MESSAGE_CC_CALL_ISSUING_BANK                          NSLocalizedString(@"We cannot process your request. Please call your issuing bank and resubmit your request.", @"")
#define STR_ERROR_MESSAGE_CC_CARD_EXPIRED                               NSLocalizedString(@"Your credit card has expired. Please enter a valid card.", @"")
#define STR_ERROR_MESSAGE_CC_REQUEST_DECLINED                           NSLocalizedString(@"Your request was declined.", @"")
#define STR_ERROR_MESSAGE_CC_INSUFFICIENT_FUNDS                         NSLocalizedString(@"Your request was declined due to insufficient funds.", @"")
#define STR_ERROR_MESSAGE_CC_ENTER_VALID_FOUR_DIGIT_CODE                NSLocalizedString(@"Please enter a valid four digit security code for your card.", @"")
#define STR_ERROR_MESSAGE_CC_ENTER_VALID_THREE_DIGIT_CODE               NSLocalizedString(@"Please enter a valid three digit security code for your card.", @"")
#define STR_ERROR_MESSAGE_CC_REQUEST_DECLINED_CALL_BANK                  NSLocalizedString(@"Your request was declined. Please call your issuing bank.", @"")
#define STR_ERROR_MESSAGE_CC_ENTER_VALID_NUMBER                         NSLocalizedString(@"Please enter a valid credit card number.", @"")
#define STR_ERROR_MESSAGE_CC_ENTER_VALID_TYPE                           NSLocalizedString(@"Please select a valid card type.", @"")
#define STR_ERROR_MESSAGE_CC_PROCESSING_ERROR                           NSLocalizedString(@"There was a problem processing this request. Please use another card or try again later.", @"")
#define STR_ERROR_MESSAGE_CC_TYPE_INVALID                               NSLocalizedString(@"The card type sent is invalid or does not correlate with the credit card number.", @"")
#define STR_ERROR_MESSAGE_CC_REQUEST_ALREADY_RECIEVED                               NSLocalizedString(@"Your request for this credit has already been received.", @"")
#define STR_ERROR_MESSAGE_USER_AUTHENTICATION_FAILED                    NSLocalizedString(@"User authentication failed.", @"")
#define STR_ERROR_MESSAGE_REFERENCEID_NOT_FOUND                         NSLocalizedString(@"ReferenceId not found.", @"")

#pragma mark - notification
#define STR_ERROR_MESSAGE_NOTIFICATION_EMAIL_REQUIRED                   NSLocalizedString(@"Please provide your email address.", @"")
#define STR_ERROR_MESSAGE_NOTIFICATION_EMAIL_INVALID                    NSLocalizedString(@"Invalid email address.", @"")
#define STR_ERROR_MESSAGE_NOTIFICATION_INVALID_COUNTRY_CODE             NSLocalizedString(@"Invalid country code.", @"")
#define STR_ERROR_MESSAGE_NOTIFICATION_MOBILE_REQUIRED                  NSLocalizedString(@"Please provide a mobile number.", @"")
#define STR_ERROR_MESSAGE_NOTIFICATION_MOBILE_INVALID                   NSLocalizedString(@"Invalid mobile number. Please enter a valid mobile number.", @"")
#define STR_ERROR_MESSAGE_NOTIFICATION_MOBILE_LEN_FALL_SHORT_INVALID    NSLocalizedString(@"Mobile number cannot be less than 10 digits. Please enter a valid mobile number.", @"")
#define STR_ERROR_MESSAGE_NOTIFICATION_MOBILE_LEN_EXCEEDED_INVALID      NSLocalizedString(@"Mobile number cannot be more than 12 digits. Please enter a valid mobile number.", @"")

#define     STR_ERROR_MESSAGE_GENERIC_ERROR                             NSLocalizedString(@"We have experienced a problem, please try again later.", @"")
#define     STR_ERROR_MESSAGE_INVALID_PAIR_OF_CARD_EXCEEDED                     NSLocalizedString(@"You cannot order more than %d pair of cards. Currently you have %d cards.",@"")




#define STR_ERROR_MESSAGE_MAKE_REQUIRED                         NSLocalizedString(@"Provide make.", @"")
#define STR_ERROR_MESSAGE_INVALID_MAKE                         NSLocalizedString(@"Invalid make.", @"")
#define STR_ERROR_MESSAGE_MODEL_REQUIRED                        NSLocalizedString(@"Provide model.", @"")
#define STR_ERROR_MESSAGE_INVALID_MODEL                         NSLocalizedString(@"Invalid model.", @"")
#define STR_ERROR_MESSAGE_INVALID_YEAR                        NSLocalizedString(@"Invalid year.", @"")
