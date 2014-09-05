//
//  Enum.h
//  ChargePoint
//
//  Created by Manish Kumar on 31/07/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//


typedef enum PlaceActionOption
{
    Operation_None              =  -1,
    Operation_Add               =   0,
    Operation_Edit              =   1,
    Operation_Delete            =   2
}OperationType;

typedef enum FilterTags
{
    Filter_Available        =   0,
    Filter_InUse            =   1,
    Filter_Unknown          =   2,
    Filter_OtherNetwork     =   3,
    Filter_Reservable       =   4,
    Filter_Paid             =   5,
    Filter_LevelOne         =   6,
    Filter_LevelTwo         =   7,
    Filter_DCFast           =   8,
    Filter_Free             =   9,
    Filter_PowerSharing     =   10,
    Filter_ChargePointNetwork     =   11
}Filter_Tag;

typedef enum MapType {
    Map_Hybrid = 0,
    Map_Satellite =1
} MapTypeValue;

typedef enum DriverTipCurrentAction
{
    Tip_Flag                =   0,
    Tip_Thumbsup            =   1,
    Tip_Fetch_New           =   2,
}Tip_Current_Action;


typedef enum StationIconViewRequestIdentifer
{
    Get_Station_Image       =   0,
    Get_Station_Info        =   1
}Station_IconView_Request_Identifer;


typedef enum StationListOption
{
    Station_List_Home               =   0,
    Station_List_Places             =   1,
    Station_Recently_Visited        =   2,
    Station_In_Start_Session_Proximity        =   3,
    Station_List_Connection_Stations             =   4
}Station_List_Option;

enum HTTPRequestState{
    kRequestStateReady,
    kRequestStateLoading,
    kRequestStateComplete,
    kRequestStateError
}RequestState;

typedef enum StationPriceVaryBy{
    Price_Vary_By_Duration          =   0,
    Price_Vary_By_TimeOfDay         =   1,
    Price_Vary_By_Session           =   2,
    Price_Vary_By_None              =   3
}Station_Price_Vary_By;

typedef enum PortAction
{
    Port_Action_None                                    =   0,
    Port_Action_Start_Session                           =   1,
    Port_Action_Start_Session_Acknowledgement           =   2,
    Port_Action_Stop_Session                            =   3,
    Port_Action_Stop_Session_Acknowledgement             =   4
}Port_Action;

typedef enum
{
    SessionState_None				=	0,
    SessionState_Started			=	1,
    SessionState_Stopped			=	2,
    SessionState_StartSubmitted		=	3,
    SessionState_StartSuccessful	=	4,
    SessionState_StopSuccessful		=	5
} SessionState;

typedef enum
{
    ConnectionState_None            =   0,
    ConnectionState_InProgress            =   1,
    ConnectionState_Error            =   2,
    ConnectionState_Success            =   3
} ConnectionState;

typedef enum
{
    Charging_Status_No_Active_Charging_Sessions             =   0,
    Charging_Status_Not_Charging                            =   1,
    Charging_Status_Actively_Charging                       =   2,
    Charging_Status_Session_Fault                           =   3,
} ChargingSessionStatus;

typedef enum
{
    WeService_Request_Type_GET                              =   0,
    WeService_Request_Type_POST                             =   1
} WeServiceRequestType;

typedef enum
{
#pragma - mailing address
    LANG_txt_invalid_contact_address                        =   0,
    LANG_txt_unknown_error                                  =   1,
    LANG_txt_invalid_postal_code                            =   2,
    LANG_txt_postal_code_required                           =   3,
    LANG_txt_user_invalid_address                           =   4,
    LANG_txt_first_name_required                            =   5,
    LANG_txt_last_name_required                             =   6,
    LANG_txt_address1_required                              =   7,
    LANG_txt_city_required                                  =   8,
    LANG_txt_state_id_required                              =   9,
    LANG_txt_country_id_required                            =   10,
    
#pragma - activate cards
    LANG_txt_cards_data_empty                               =   11,//[when nothing is filled and submit button is clicked e.g. in case of empty cards array]
    LANG_txt_empty_nick_name                                =   12,
    LANG_txt_empty_serial_number                            =   13,
    LANG_txt_duplicate_serial_number                        =   14,
    LANG_txt_invalid_serialnumber                           =   15,
    LANG_txt_credit_card_details_not_available              =   16,
    LANG_txt_invalid_post_data                              =   17,
    LANG_txt_card_limit_exceeded                            =   18,
    LANG_txt_auth_failed                                    =   19,
    
#pragma Sign up
    LANG_txt_username_no_spaces_allowed                     =   20,
    LANG_txt_username_len_between_6_and_32                  =   21,
    LANG_txt_username_invalid_characters                    =   22,
    LANG_txt_uname_exists                                   =   23,
    LANG_txt_username_required                              =   24,
    
    LANG_txt_email_username_required                        =   25,
    LANG_txt_email_username_exists                          =   26,
    LANG_txt_email_username_no_spaces_allowed               =   27,
    LANG_txt_email_username_invalid_characters              =   28,
    LANG_txt_email_username_len_between_6_and_32            =   29,
    LANG_txt_invalid_email_username                         =   30,
    
    LANG_txt_password_no_spaces_allowed                     =   31,
    LANG_txt_password_len_between_6_and_32                  =   32,
    LANG_txt_password_invalid_characters                    =   33,
    LANG_txt_password_choose_at_least_2_numbers             =   34,
    LANG_txt_password_choose_atleast_1_letter               =   35,
    LANG_txt_password_required                              =   36,
    
    LANG_txt_evatarname_no_spaces_allowed                   =   37,
    LANG_txt_evatarname_len_between_6_and_32                =   38,
    LANG_txt_evatarname_invalid_characters                  =   39,
    LANG_txt_evatarname_already_exists                      =   40,
    LANG_txt_evatarname_required                            =   41,

    LANG_txt_invalid_evtar                                  =   42,
    LANG_txt_evatarImage_required                           =   43,

    LANG_txt_invalid_email                                  =   44,
    LANG_txt_email_required                                 =   45,
    
#pragma - Card operation
    LANG_txt_serial_number_required                         =   46,
    LANG_txt_nick_name_required                             =   47,
    LANG_txt_invalid_user_serial_number                     =   48,
    
#pragma mark - Start Session
    LANG_txt_station_port_already_charging                  =   49,
    LANG_txt_contact_error_try_again                        =   50,
    LANG_txt_session_could_not_be_started                   =   51,
    LANG_txt_free_user_can_not_start_charging               =   52,
    LANG_txt_station_reseved_by_other_card                  =   53,
    LANG_txt_resevation_required                            =   54,
    LANG_txt_station_serial_session_active                  =   55,
    LANG_txt_virtual_card_does_not_exists                   =   56,
    LANG_txt_virtual_card_session_in_progress               =   57,
    LANG_txt_station_error_session_start                    =   58,
#pragma mark -     Stop Sessio
    
    LANG_txt_station_port_not_charging                      =   59,
    LANG_txt_session_could_not_be_stopped                   =   60,
    
#pragma - update account
    
    LANG_txt_invalid_required                               =   61,
    LANG_txt_dialing_code_required                          =   62,
    LANG_txt_invalid_dialing_code                           =   63,
    LANG_txt_mobile_required                                =   64,
    LANG_txt_mobile_len_fall_short_or_invalid_ext           =   65,
    LANG_txt_mobile_len_exceeded_or_invalid_ext             =   66,
    LANG_txt_invalid_mobile                                 =   67,

#pragma mark - Shipping address
    LANG_txt_shipping_address1_required                     =   68,
    LANG_txt_shipping_city_required                         =   69,
    LANG_txt_shipping_state_id_required                     =   70,
    LANG_txt_shipping_country_id_required                   =   71,
    LANG_txt_shipping_postal_code_required                  =   72,
    LANG_txt_user_invalid_shipping_address                  =   73,
    LANG_txt_invalid_shipping_postal_code                   =   74,
    
#pragma mark - Security Q&A
    LANG_txt_question_id_required                           =   75,
    LANG_txt_security_answer_required                       =   76,
    
#pragma mark - Forgot password
    LANG_txt_invalid_username                               =   77,
#pragma mark - Payment
    LANG_txt_CC_payment_cancelled                           =   78,
    LANG_txt_CC_generic_fail                                =   79,
    
    LANG_txt_password_do_not_match                          =   80,
    
#pragma mark - free cards
    LANG_txt_user_already_have_free_cards                   =   81,
    
#pragma mark - Data not found
    LANG_txt_data_not_found                                 =   82,
    
#pragma mark - Purchase cards using existing CC
    LANG_txt_card_limit_exceed                                 =   83,
    LANG_txt_CC_time_out                                 =   84,
    LANG_txt_CC_missing_fields                                 =   85,
    LANG_txt_CC_incorrect_information                                 =   86,
    LANG_txt_CC_unable_to_verify                                 =   87,
    LANG_txt_CC_address_does_not_match                                 =   88,
    LANG_txt_CC_call_issuing_bank                                 =   89,
    LANG_txt_CC_card_expired                                 =   90,
    LANG_txt_CC_request_declined                                 =   91,
    LANG_txt_CC_insufficent_funds                                 =   92,
    LANG_txt_CC_enter_valid_four_digit_code                                 =   93,
    LANG_txt_CC_enter_valid_three_digit_code                                 =   94,
    LANG_txt_CC_request_declined_call_bank                                 =   95,
    LANG_txt_CC_enter_valid_number                                 =   96,
    LANG_txt_CC_enter_valid_type                                 =   97,
    LANG_txt_CC_processing_error                                 =   98,
    LANG_txt_CC_type_invalid                                 =   99,
    LANG_txt_CC_request_already_received                                 =   100,
    LANG_txt_user_authentication_failed                                 =   101,
    LANG_txt_referenceid_not_found                                 =   102,
    
#pragma mark - notification
    LANG_txt_notification_email_required                    =   103,
    LANG_txt_invalid_country_code                    =   104,
    LANG_txt_invalid_notification_email                    =   105,
    LANG_txt_notification_mobile_required                    =   106,
    LANG_txt_invalid_notification_mobile                    =   107,
    LANG_txt_notification_mobile_len_fall_short_or_invalid_ext                    =   108,
    LANG_txt_notification_mobile_len_exceeded_or_invalid_ext                    =   109,
    LANG_txt_internal_server_error                              =   110,

#pragma mark - signup
    LANG_txt_agree_signup_terms_conditions_required                    =   111,
    
    
#pragma mark - MANAGE EV
    LANG_txt_make_required                    =   112,
    LANG_txt_invalid_make                       =   113,
    LANG_txt_model_required                    =   114,
    LANG_txt_invalid_year                    =   115,
    LANG_txt_invalid_model                    =   116,
    LANG_txt_year_required                     =   117,

#pragma mark - Gender
    LANG_txt_invalid_gender                     =   118
} WebServiceErrorResponseCode;

typedef enum
{
    Map_View   =   0,
    List_View    =   1
} LastAccessedView;


typedef enum {
    FilterPanelFirstTime        =   1,
    OnBootNoCCFile              =   2,
    CompleteYourProfile         =   3,
    NoCCTryToOrderCard          =   4,
    AddConnectionFirstTime      =   5,
    AddDTNoCCOnFile             =   6,
    AddDTCCOnFileNoEvatar       =   7,
    AddDTNoCCNoEvatar           =   8,
    UserNotification            =   9
}InAppMessageCategory;

typedef enum {    
    Conn_Pending                =   1,
    Conn_Approved               =   2,
    Conn_Deleted                =   3,
    Conn_Rejected               =   4,
    Conn_Not_Requested          =   5
}ConnectionStatus;

typedef enum{
    kShareFacebook,
    kShareTwitter,
    kShareEmail,
    kShareMessage
}ShareOptions;

typedef enum{
    kShare,
    kReport
}ActionSheetOption;

typedef enum{
    kNoPower,
    kDamaged,
    kMissing,
    kIncorrectInfo,
    kOther
}ReportOptions;