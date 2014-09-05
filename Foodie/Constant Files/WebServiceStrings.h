//
//  WebServiceStrings.h
//  CoulomTechiPhone

#pragma mark -
#pragma mark Web Service

//================================================
//Manish just set this to 0 or 1 for QA/PROD.
//I use this #define to display additional info in QA builds.
//================================================
#define PROD_URL 0  // change for production

#if PROD_URL
//    #warning Prod URL
    #define CONST_URL_POST_WEBSERVICE           @"https://webservices.chargepoint.com/backend.php/mobileapi"
#else
//    #warning Test URL
    #define CONST_URL_POST_WEBSERVICE           @"https://apimobile50final.ev-chargepoint.com/backend.php/mobileapi"

#endif

#define CONST_BYPASS_HTTPS_AUTHENTICATION      1    //1- prior to App Store / !1-App store/do not by pass

#define CONST_URL_GET_ALL_STATIONS              @"v1/stations/bound/station"

#define CONST_REQUEST_METHOD_POST               @"POST"
#define CONST_REQUEST_METHOD_GET                @"GET"
#define CONST_REQUEST_CONTENT_JSON_UTF8         @"application/json;charset=UTF-8"
#define CONST_REQUEST_CONTENT_TYPE_VALUE        @"application/json"

#define CONST_REQUEST_CONTENT_TYPE              @"Content-Type"
#define CONST_REQUEST_ACCEPT_TYPE               @"Accept"
#define CONST_TIMEOUT                           180

#define CONST_SERVER_ANNOTATION_TYPE            @"type"
#define CONST_SERVER_LONGITUDE_KEY              @"lon"
#define CONST_SERVER_LATITUDE_KEY               @"lat"
#define CONST_SERVER_STATUS_KEY                 @"status"
#define CONST_SERVER_IS_CHARGING                 @"is_charging"
#define CONST_SERVER_ID_KEY                     @"id"
#define CONST_SERVER_COUNT_KEY                  @"count"
#define CONST_SERVER_DEVICE_NAME                @"device_name"
#define CONST_SERVER_JAVA_URL                   @"java_url"
#define CONST_SERVER_CONTACTUS_URL              @"contact_us_url"
#define CONST_SERVER_CONNECTION_TnC_URL              @"connection_tnc_url"
#define CONST_SERVER_CONNECTION_CUSTOM_TnC_URL              @"connection_custom_tnc_url"
#define CONST_SERVER_STATION_INTERACTION_RANGE              @"station_interaction_range"
#define CONST_SERVER_FAQ_URL                    @"faq_url"
#define CONST_SERVER_SIGNUP_TNC_URL             @"signup_tnc_url"
#define CONST_SERVER_PRIVACY_POLICY_URL         @"privacy_policy_url"
#define CONST_SERVER_DISCONNECT_DRIVER          @"disconnect_driver"
#define CONST_SERVER_SUBMIT_CONNECTION          @"submit_connection"

#define CONST_SERVER_LATEST_VERSION             @"latest_version"
#define CONST_SERVER_LAST_AUTHORIZATION_TIMESTAMP             @"last_authorization_timestamp"
#define CONST_SERVER_VALIDATE_LOGIN             @"validate_login"
#define CONST_SERVER_GET_CHARGING_SPOTS_COUNT   @"get_charging_spots_count"
#define CONST_SERVER_IS_USER_LOGGEDIN           @"is_user_loggedin"
#define CONST_SERVER_GET_APPLICAITON_INFO       @"get_application_info"
#define CONST_SERVER_MY_ACCOUNT_SESSION_LENGTH_IN_SECONDS       @"my_account_sess_len_in_sec"
#define CONST_SERVER_GET_EVATAR                 @"get_evatar"
#define CONST_SERVER_MAP_DATA_TAG               @"map_data"
#define CONST_SERVER_MAP_DATA_SIZE_TAG          @"map_data_size"
#define CONST_SERVER_STATION_LIST_TAG           @"station_list"
#define CONST_SERVER_NEARBY_STATION_LIST_TAG    @"nearby"
#define CONST_SERVER_SUMMARIES                  @"summaries"
#define CONST_SERVER_LEVEL_ONE                  @"level1"
#define CONST_SERVER_LEVEL_TWO                  @"level2"
#define CONST_SERVER_FREE                       @"free"
#define CONST_SERVER_PAID                       @"paid"
#define CONST_SERVER_TOTAL_PORTS                @"total"
#define CONST_SERVER_AVAILABLE_PORTS            @"available" //amre MBL 1412
#define CONST_SERVER_TOTAL_COUNT                @"total_count"
#define CONST_SERVER_DEVICE_ID                  @"device_id"
#define CONST_SERVER_STATION_STATUS             @"station_status"
#define CONST_SERVER_STATION_PAYMENT_TYPE       @"payment_type"
#define CONST_SERVER_STATION_IS_RESERVABLE      @"is_reservable"
#define CONST_SERVER_STATION_IS_HOME            @"is_home"
#define CONST_SERVER_STATION_IS_CURRENTLY_CHARGING            @"current_charging"
#define CONST_SERVER_STATION_IS_CURRENTLY_IN_USE            @"in_use"
#define CONST_SERVER_STATION_IS_CURRENTLY_FULLY_CHARGED            @"fully_charged"
#define CONST_SERVER_STATION_IS_CURRENTLY_CHARGING_FAULT            @"fault"
#define CONST_SERVER_STATION_IS_FAULT            @"is_fault"
#define CONST_SERVER_STATION_NAME_LINE1_LINE2   @"station_name"
#define CONST_SERVER_DISABLE_TOKEN              @"disableToken"
#define CONST_SERVER_STATION_PRICING            @"pricing"
#define CONST_SERVER_ADDRESS                    @"address"
#define CONST_SERVER_FULL_ADDRESS               @"full_address"
#define CONST_SERVER_STATION_PORT_TYPE          @"port_type"
#define CONST_SERVER_DISTANCE                   @"distance"
#define CONST_SERVER_SORT_BY                    @"sort_by"
#define CONST_SERVER_STATION_BEARING            @"bearing"
#define CONST_SERVER_PORT_TYPE_T1               @"t1"
#define CONST_SERVER_PORT_TYPE_T2               @"t2"
#define CONST_SERVER_PORT_TYPE_MAP              @"port_type_map"
#define CONST_SERVER_NORTHEAST_LATITUDE         @"ne_lat"
#define CONST_SERVER_NORTHEAST_LONGITUDE        @"ne_lon"
#define CONST_SERVER_SOUTHWEST_LATITUDE         @"sw_lat"
#define CONST_SERVER_SOUTHWEST_LONGITUDE        @"sw_lon"
#define CONST_SERVER_SCREEN_WIDTH               @"screen_width"
#define CONST_SERVER_SCREEN_HEIGHT              @"screen_height"
#define CONST_SERVER_FILTER                     @"mobile_filter"
#define CONST_SERVER_COUNTRY_ID                 @"country_id"

#define CONST_SERVER_LIST_PAGE_OFFSET           @"page_offset"
#define CONST_SERVER_LIST_LAST_PAGE_OFFSET      @"last_page"
#define CONST_SERVER_PORT_TYPE_COUNT            @"port_type_count"
#define CONST_SERVER_PORT_TYPE_TEXT_MAP         @"port_type_text_map"
#define CONST_SERVER_ADDRESS_LINE_ONE           @"address1"
#define CONST_SERVER_ADDRESS_LINE_TWO           @"address2"
#define CONST_SERVER_CITY                       @"city"
#define CONST_SERVER_COUNTRY_NAME               @"country_name"
#define CONST_SERVER_STATE_NAME                 @"state_name"
#define CONST_SERVER_ZIPCODE                    @"zipcode"

#define CONST_SERVER_TIP                        @"tip"
#define CONST_SERVER_TIP_MAP                    @"tip_map"
#define CONST_SERVER_TIP_TEXT                   @"tip_text"
#define CONST_SERVER_TIP_THUMBSUP_COUNT         @"thumbs_up_count"
#define CONST_SERVER_TIP_THUMBSUP_USER          @"thumbs_up_user"
#define CONST_SERVER_TIP_INDEX                  @"tip_index"
#define CONST_SERVER_THUMBSUP_TIP               @"thumbs_up_tip"
#define CONST_SERVER_ADD_TIP                    @"add_tip"
#define CONST_SERVER_FLAG_TIP                    @"flag_tip"
#define CONST_SERVER_TIP_TIMESTAMP              @"timestamp"
#define CONST_SERVER_STATION_IMAGE              @"station_image"
#define CONST_SERVER_DOWNLOAD_URL               @"url"

#define CONST_SERVER_DISABLE_ALERT             @"disable_alert"
#define CONST_SERVER_ALERT_CODE                 @"alert_code"

#define CONST_SERVER_STATION_INFO               @"station_info"
#define CONST_SERVER_STATION_PORT_STATUS        @"port_status"
#define CONST_SERVER_CONNECTED_ORG_NAME         @"company_name"
#define CONST_SERVER_REFERENCE_DISTANCE         @"reference_distance"
#define CONST_SERVER_USER_DISTANCE              @"user_distance"
#define CONST_SERVER_USER_BEARING               @"user_bearing"
#define CONST_SERVER_PRICING_FREE               @"pricing_free"
#define CONST_SERVER_PRICING_DETAIL             @"pricing_detail"
#define CONST_SERVER_PRICING                    @"pricing"
#define CONST_SERVER_IS_LEGACY                      @"is_legacy"

#define CONST_SERVER_DETAIL                     @"detail"
#define CONST_SERVER_PORT_COUNT                 @"port_count"
#define	CONST_TOTAL                             @"total"

#pragma mark - Station status
#define CONST_SERVER_AVAILABLE                  @"available"
#define CONST_SERVER_INUSE                      @"in_use"
#define CONST_SERVER_UNKNOWN                    @"unknown"
#define CONST_SERVER_OUT_OF_NETWORK             @"out_of_network"
#define CONST_SERVER_AVAILABLE_DC               @"available_dc"
#define CONST_SERVER_INUSE_DC                   @"in_use_dc"
#define CONST_SERVER_UNKNOWN_DC                 @"unknown_dc"
#define CONST_SERVER_OUT_OF_NETWORK_DC          @"out_of_network_dc"

#pragma mark - Place
#define CONST_SERVER_ADD_PLACE                  @"add_place"
#define CONST_SERVER_DELETE_PLACE               @"delete_place"
#define CONST_SERVER_EDIT_PLACE                 @"edit_place"
#define CONST_SERVER_PLACE_ID                   @"place_id"


#define	CONST_REQ_CONTENT_LENGTH                @"Content-Length"

#define CONST_SERVER_GET_CHARGING_STATUS        @"get_charging_status"
#define CONST_SERVER_IS_DRIVER_CHARGING         @"is_driver_charging"
#define CONST_SERVER_GET_VEHICLE_DEFAULT_FILTER @"get_vehicle_default_filter"

#define CONST_SERVER_GET_EVATAR                 @"get_evatar"
#define CONST_SERVER_IS_USER_ONLY               @"is_user_only"

#define CONST_SERVER_ADD_SIGNUP_INFO            @"add_signup_info"
#define CONST_SERVER_USER_NAME                  @"user_name"
#define	CONST_SERVER_EMAIL                      @"email"
#define CONST_SERVER_PASSWORD                   @"password"
#define CONST_SERVER_USER_EVATAR_NAME           @"user_evatar_name"
#define CONST_SERVER_EVATAR_ID                  @"evatar_id"
#define CONST_SERVER_EVATAR_NAME                @"evatar_name"
#define CONST_SERVER_EVATAR_URL                 @"evatar_url"
#define CONST_SERVER_EVATAR_DETAILS             @"evatar_details"
#define CONST_SERVER_VALUE                      @"value"
#define CONST_SERVER_FIRST_NAME                 @"first_name"
#define CONST_SERVER_LAST_NAME                  @"last_name"
#define CONST_SERVER_GENDER                     @"gender"
#define CONST_SERVER_STATE_ID                      @"state_id"
//#define CONST_SERVER_COUNTRY                    @"country_id"
#define CONST_SERVER_POSTAL_CODE                @"postal_code"
#define CONST_SERVER_PREDICTIONS                @"predictions"
#define CONST_SERVER_ERROR                      @"error"
#define CONST_SERVER_MESSAGE                    @"message"
#define CONST_SERVER_ACCOUNT_TYPE               @"account_type"
#define CONST_SERVER_COULOMB_SESSION_TOKEN      @"coulomb_sess"
#define CONST_SERVER_COOKIE                     @"Cookie"
#define CONST_SERVER_AUTH_TOKEN                 @"auth_token"
#define CONST_SERVER_CAN_SHOWCC_ALERT           @"can_show_cc_alert"
#define CONST_SERVER_CC_ON_FILE_DAYS            @"cc_on_file_days"
#define CONST_SERVER_TIMESTAMP                  @"timestamp"
#define CONST_SERVER_PLACE                      @"place"
#define CONST_SERVER_PLACE_INDEX                @"place_index"
#define CONST_SERVER_PLACE_MAP                  @"place_map"
#define CONST_SERVER_NAME                       @"name"
#define CONST_SERVER_DESCRIPTION                @"description"
#define CONST_SERVER_TERMS                      @"terms"
#define CONST_SERVER_IS_POWER_SHARING           @"is_power_sharing"
#define CONST_SERVER_LIST_PLACE                 @"list_place"
#define CONST_SERVER_START_TIME                 @"start_time"
#define CONST_SERVER_END_TIME                   @"end_time"
#define CONST_SERVER_INITIAL_DURATION           @"initial_duration"
#define CONST_SERVER_UNIT_CHARGE                @"unit_charge"
#define CONST_SERVER_UNIT_CHARGE_SECOND         @"unit_charge_second"
#define CONST_SERVER_SESSION_RATE               @"session_rate"
#define CONST_SERVER_SESSION_TIME               @"session_time"
#define CONST_SERVER_ENERGY_RATE                @"energy_rate"
#define CONST_SERVER_MIN_CHARGE                 @"min_charge"
#define CONST_SERVER_MAX_CHARGE                 @"max_charge"
#define CONST_SERVER_CURRENCY_ISO_CODE          @"currency_iso_code"
#define CONST_SERVER_CARD_PAIR_COST             @"pair_cost"
#define CONST_SERVER_ALLOWED_PAIR_OF_CARDS      @"allowed_pair_of_cards"
#define CONST_SERVER_TOTAL_ACTUAL_CARDS         @"total_actual_cards"

#define CONST_SERVER_PRICE_VARY_BY              @"price_vary_by"
#define CONST_SERVER_PRICE_VARY_BY_TOD          @"tod"
#define CONST_SERVER_PRICE_VARY_BY_DURATION     @"duration"
#define CONST_SERVER_PRICE_VARY_BY_SESSION      @"session"
#define CONST_SERVER_DRIVER_PAYS_PER_HOUR       @"driver_pays_per_hour"
#define CONST_SERVER_DRIVER_ACTIVELY_CHARGING   @"actively_charging"
#define CONST_SERVER_DRIVER_PAYS_ENTIRE_TIME    @"entire_time"
#define CONST_SERVER_START_SESSION              @"start_session"
#define CONST_SERVER_STOP_SESSION               @"stop_session"
#define CONST_SERVER_ACK_ID                     @"ack_id"
#define CONST_SERVER_SESSION_ACK                @"session_ack"
#define CONST_SERVER_NONE                       @"none"
#define CONST_SERVER_START                      @"start"
#define CONST_SERVER_RESERVE                    @"reserve"
#define CONST_SERVER_STOP                       @"stop"
#define CONST_SERVER_OUTLET_1                   @"outlet_1"
#define CONST_SERVER_OUTLET_2                   @"outlet_2"
#define CONST_SERVER_STATION_PORT_ACTION        @"port_action"
#define CONST_SERVER_RECENTLY_VISITED           @"recently_visited"
#define CONST_SERVER_MAP_BOUND                  @"map_bound"

#define CONST_SERVER_CARDS                      @"cards"
#define CONST_SERVER_NICK_NAME                  @"nick_name"
#define CONST_SERVER_LANG_TXT_HOMECHARGER_NICK_NAME @"LANG_txt_homecharger_nick_name"
#define CONST_SERVER_RFID_TAG                   @"rfid"
#define CONST_SERVER_SERIAL_NUMBER              @"serial_number"
#define CONST_SERVER_DEFAULT_CARD               @"is_default"
#define CONST_SERVER_USED_CARD                  @"used"
#define CONST_SERVER_GET_USER_CARDS             @"get_user_cp_cards"//@"get_user_cards" 
#define CONST_SERVER_DRIVER_GROUPS              @"driver_groups"
#define CONST_SERVER_GROUP_ID                   @"group_id"
#define CONST_SERVER_CONNECTOR                  @"connector"
#define CONST_SERVER_ENERGY                     @"energy"
#define CONST_SERVER_LEVEL                      @"level"

#define CONST_SERVER_UNIT                       @"unit"
#define CONST_SERVER_PORT_TYPE_INFO             @"port_type_info"
#define CONST_SERVER_USER_ID                    @"user_id"
#define CONST_SERVER_CLIENT                     @"client"
#define CONST_SERVER_CLIENT_APP_VERSION         @"version"


#define CONST_SERVER_LOGOUT                     @"logout"

#define CONST_SERVER_INPUT                      @"input"
#define CONST_SERVER_SENSOR                     @"sensor"
#define CONST_SERVER_KEY                        @"key"
#define CONST_SERVER_LOCATION                        @"location"

#define CONST_SERVER_DETECT_AVAILABLE_STATION_LIST         @"detect_available_station_list"
#define CONST_SERVER_DETECT_AVAILABLE_STATION              @"detect_available_station"

#pragma mark - Connection
#define CONST_SERVER_IS_CONNECTED                   @"is_connected"
#define CONST_SERVER_DRIVER_GROUP_ID                @"driver_group_id"
#define CONST_SERVER_COMPANY_NAME                   @"company_name"
#define CONST_SERVER_EXCLUDE_DRIVER_GROUP_IDS       @"exclude_driver_group_ids"
#define CONST_SERVER_CONNECTED_STATION_ONLY         @"connected_station_only"
#define CONST_SERVER_CONNECTION                     @"connection"

#define CONST_SERVER_CHARGING_END_TIME              @"charging_end_time"    //"00:00:00 00:00:00";
#define CONST_SERVER_CHARGING_START_TIME            @"charging_start_time"  //"2014-01-23 05:46:07";
#define CONST_SERVER_CURRENCY                       @"currency" //USD
#define CONST_SERVER_CURRENCY_SYMBOL                @"currency_symbol"  //"$"
#define CONST_SERVER_DURATION                       @"duration" //"00:45:18"
#define CONST_SERVER_ENERGY                         @"energy"   //"0.000";
#define CONST_SERVER_ENERGY_UNIT                    @"energy_unit"  //"LANG_txt_energy_unit_kwh"
#define CONST_SERVER_PORT                           @"port" //2
#define CONST_SERVER_POWER                          @"power"    //"0.000"
#define CONST_SERVER_POWER_UNIT                     @"power_unit" //"LANG_txt_power_unit_kw";
#define CONST_SERVER_STATION_ADDRESS                @"station_address"  //"15 Aricent Lane, Gurgaon, Haryana, 122008, India, ";
#define CONST_SERVER_STATION_LAT                    @"station_lat"  //"28.499301910400390";
#define CONST_SERVER_STATION_LON                    @"station_lon" // "77.069686889648440";
#define CONST_SERVER_STATION_NAME                   @"station_name" // "MOBILE 50 QA LT / TEST 002A";
#define CONST_SERVER_TOTAL_FEE_SO_FAR               @"total_fee_so_far"     //"0.00"
#define CONST_SERVER_VEHICLE_CHARGE_ACTIVE_ID       @"vehicle_charge_active_id"     //14402167;
#define CONST_SERVER_GHG                            @"ghg"
#define CONST_SERVER_GHG_UNIT                       @"ghg_unit"

#define CONST_SERVER_GET_COUNTRIES                  @"get_countries"
#define CONST_SERVER_GET_STATES                     @"get_states"
#define CONST_SERVER_CODE                           @"code"
#define CONST_SERVER_DIAL_CODE                      @"dialing_code"


#pragma mark - CARD
#define CONST_SERVER_IS_VIRTUAL_CARD                @"is_virtual_card"
#define CONST_SERVER_OPERATION                      @"operation"
#define CONST_SERVER_OPERATION_ADD                  @"ADD"
#define CONST_SERVER_OPERATION_EDIT                 @"EDIT"
#define CONST_SERVER_OPERATION_DELETE               @"DELETE"
#define CONST_SERVER_SET_CP_CARD                    @"set_cp_card"
#define CONST_SERVER_CHECK_FOR_INAPPP_ROMPTS                    @"get_profile_reminder_info"
#define CONST_SERVER_CC_DETAIL                      @"cc_detail"
#define CONST_SERVER_EVATAR_DETAIL                      @"evatar"
#define CONST_SERVER_PROFILE_INFO                      @"profile_info"
#define CONST_SERVER_USER_TYPE                      @"user_type"
#define CONST_SERVER_INITAIL_DEPOSIT                      @"initial_deposit"
#define CONST_SERVER_ON_FILE                      @"on_file"
#define CONST_SERVER_IS_PROMPT_DISABLED                      @"is_disabled"
#define CONST_SERVER_IS_COMPLETE                      @"is_complete"
#define CONST_SERVER_IS_AVAIALBLE                      @"is_vailable"

#define CONST_SERVER_GET_CHARGEPOINT_CARDS          @"get_chargepoint_cards"
#define CONST_SERVER_SEND_FREE_CHARGEPOINT_CARDS          @"send_free_cp_cards"
#define CONST_SERVER_INFO_ENABLE_CHARGING_INFO          @"enable_charging_info"
#define CONST_SERVER_SEND_FREE_CARDS                @"send_free_cards"
#define CONST_SERVER_IS_PAAYMENT_REQUIRED                @"redirect_to_payment"
#define CONST_SERVER_GET_CARDS_USING_EXISTING_CC    @"get_cards_using_existing_cc"
#define CONST_SERVER_ALLOWED_CARDS                  @"allowed_cards"
#define CONST_SERVER_CARDS_EXCEED_BY                @"exceed_by"
#define CONST_SERVER_ALLOWED_CARDS                  @"allowed_cards"
#define CONST_SERVER_EDIT_CP_CARDS                  @"edit_cp_cards"
#define CONST_SERVER_NUMBER_OF_PAIR_OF_CP_CARDS     @"pair_of_cards"
#define LANG_TXT_SERIAL_NUMBER_REQUIRED             @"LANG_txt_serial_number_required"
#define LANG_TXT_NICK_NAME_REQUIRED                 @"LANG_txt_nick_name_required"
#define LANG_TXT_CARD_LIMIT_EXCEEDED                @"LANG_txt_card_limit_exceeded"
#define LANG_TXT_INVALID_USER_SERIAL_NUMBER         @"LANG_txt_invalid_user_serial_number"

#pragma mark - Charging Status response constants
#define CONST_SERVER_VEHICLE_NOT_CHARGING           @"LANG_txt_cs_not_charging"
#define CONST_SERVER_VEHICLE_CHARGING               @"LANG_txt_cs_charging"
#define CONST_SERVER_VEHICLE_FAULT                  @"LANG_txt_cs_fault"

#pragma mark - Error message constants
#pragma mark - Signup
#define LANG_TXT_EMAIL_USERNAME_REQUIRED                    @"LANG_txt_email_username_required"
#define LANG_TXT_EMAIL_UNAME_EXISTS                         @"LANG_txt_email_uname_exists"
#define LANG_TXT_EMAIL_USERNAME_NO_SPACES_ALLOWED           @"LANG_txt_email_username_no_spaces_allowed"
#define LANG_TXT_EMAIL_USERNAME_INVALID_CHARACTERS          @"LANG_txt_email_username_invalid_characters"
#define LANG_TXT_EMAIL_USERNAME_LEN_BETWEEN_6_AND_32        @"LANG_txt_invalid_email_username"
#define LANG_TXT_INVALID_EMAIL                              @"LANG_txt_invalid_email"
#define LANG_TXT_EMAIL_REQUIRED                             @"LANG_txt_email_required"
#define LANG_TXT_EVATARNAME_NO_SPACES_ALLOWED               @"LANG_txt_evatarname_no_spaces_allowed"
#define LANG_TXT_EVATARNAME_LEN_BETWEEN_6_AND_32            @"LANG_txt_evatarname_len_between_6_and_32"
#define LANG_TXT_EVATARNAME_INVALID_CHARACTERS              @"LANG_txt_evatarname_invalid_characters"
#define LANG_TXT_EVATARNAME_ALREADY_EXISTS                  @"LANG_txt_evatarname_already_exists"
#define LANG_TXT_INVALID_EVATAR                             @"LANG_txt_invalid_evtar"
#define LANG_TXT_EVATARNAME_REQUIRED                        @"LANG_txt_evatarname_required"
#define LANG_TXT_EVATAR_IMAGE_REQUIRED                      @"LANG_txt_evatarImage_required"

#define LANG_TXT_USERNAME_NO_SPACES_ALLOWED                 @"LANG_txt_username_no_spaces_allowed"
#define LANG_TXT_USERNAME_LEN_BETWEEN_6_AND_32              @"LANG_txt_username_len_between_6_and_32"
#define LANG_TXT_USERNAME_INVALID_CHARACTERS                @"LANG_txt_username_invalid_characters"
#define LANG_TXT_USERNAME_EXISTS                            @"LANG_txt_uname_exists"
#define LANG_TXT_USERNAME_REQUIRED                          @"LANG_txt_username_required"
#define LANG_TXT_USERNAME_INVALID                           @"LANG_txt_invalid_username"
#define LANG_TXT_PASSWORD_NO_SPACES_ALLOWED                 @"LANG_txt_password_no_spaces_allowed"
#define LANG_TXT_PASSWORD_LEN_BETWEEN_6_AND_32              @"LANG_txt_password_len_between_6_and_32"
#define LANG_TXT_PASSWORD_INVALID_CHARACTERS                @"LANG_txt_password_invalid_characters"
#define LANG_TXT_PASSWORD_CHOOSE_AT_LEAST_2_NUMBERS         @"LANG_txt_password_choose_at_least_2_numbers"
#define LANG_TXT_PASSWORD_CHOOSE_ATLEAST_1_LETTER           @"LANG_txt_password_choose_atleast_1_letter"
#define LANG_TXT_PASSWORD_REQUIRED                          @"LANG_txt_password_required"
#define LANG_TXT_PASSWORD_DO_NOT_MATCH                      @"LANG_txt_password_do_not_match"


#pragma mark - Payment
#define LANG_TXT_CC_GENERIC_FAIL                            @"LANG_txt_CC_generic_fail"
#define LANG_txt_CC_PAYMENT_CANCELLED                       @"LANG_txt_CC_payment_cancelled"

#define HTML_DOC_INNERHTML                                  @"document.body.innerHTML"

#pragma mark - Browser methods
#define CONST_SERVER_CHANGE_ACCOUNT_CC                      @"change_account_cc"
#define CONST_SERVER_GET_CARDS_USING_NEW_CC                 @"get_cards_using_new_cc"
#define CONST_SERVER_GET_INFO_MESSAGE                       @"get_info_message"

#define CONST_SERVER_CHANGE_PASSWORD                        @"change_password"
#define CONST_SERVER_NEW_PASSWORD                           @"new_password"
#define CONST_SERVER_ISSUE_FREE_CARDS                       @"issue_free_cards"
#define CONST_SERVER_CARD_COUNT                             @"card_count"


#pragma mark - Connection Offer
#define CONST_SERVER_CONNECTION_CATEGORIES                  @"list_connection_categories"

#pragma mark - Error constants for mailing address
#define LANG_TXT_INVALID_CONTACT_ADDRESS                    @"LANG_txt_invalid_contact_address"
#define LANG_TXT_UNKNOWN_ERROR                              @"LANG_txt_unknown_error"
#define LANG_TXT_INVALID_POSTAL_CODE                        @"LANG_txt_invalid_postal_code"
#define LANG_TXT_POSTAL_CODE_REQUIRED                       @"LANG_txt_postal_code_required"
#define LANG_TXT_USER_INVALID_ADDRESS                       @"LANG_txt_user_invalid_address"
#define LANG_TXT_FIRST_NAME_REQUIRED                        @"LANG_txt_first_name_required"
#define LANG_TXT_LAST_NAME_REQUIRED                         @"LANG_txt_last_name_required"
#define LANG_TXT_ADDRESS1_REQUIRED                          @"LANG_txt_address1_required"
#define LANG_TXT_CITY_REQUIRED                              @"LANG_txt_city_required"
#define LANG_TXT_STATE_ID_REQUIRED                          @"LANG_txt_state_id_required"
#define LANG_TXT_COUNTRY_ID_REQUIRED                        @"LANG_txt_country_id_required"
#define LANG_TXT_POSTAL_CODE_REQUIRED                       @"LANG_txt_postal_code_required"

#pragma mark - Shipping address
#define LANG_TXT_INVALID_SHIPPING_ADDRESS                    @"LANG_txt_user_invalid_shipping_address"
#define LANG_TXT_INVALID_SHIPPING_POSTAL_CODE                @"LANG_txt_invalid_shipping_postal_code"
#define LANG_TXT_SHIPPING_POSTAL_CODE_REQUIRED               @"LANG_txt_shipping_postal_code_required"
#define LANG_TXT_SHIPPING_ADDRESS1_REQUIRED                  @"LANG_txt_shipping_address1_required"
#define LANG_TXT_SHIPPING_CITY_REQUIRED                      @"LANG_txt_shipping_city_required"
#define LANG_TXT_SHIPPING_STATE_ID_REQUIRED                  @"LANG_txt_shipping_state_id_required"
#define LANG_TXT_SHIPPING_COUNTRY_ID_REQUIRED                @"LANG_txt_shipping_country_id_required"


#define CONST_SERVER_ADD_DRIVER_INFO_AND_FREE_CARDS         @"add_driver_info_and_free_cards"
#define CONST_SERVER_SET_USER_MAILING_ADDRESS               @"set_user_mailing_address"
#define CONST_SERVER_GET_USER_MAILING_ADDRESS               @"get_user_mailing_address"
#define CONST_SERVER_GET_USER_FINANCIAL_INFO                @"get_user_financial_info"

#define CONST_SERVER_FORGOT_PASSWORD                        @"forgot_password"

#define CONST_SERVER_ACTIVATE_CP_CARDS                      @"activate_cp_cards"
#define LANG_TXT_CARDS_DATA_EMPTY                           @"LANG_txt_cards_data_empty"
#define LANG_TXT_EMPTY_NICK_NAME                            @"LANG_txt_empty_nick_name"
#define LANG_TXT_EMPTY_SERIAL_NUMBER                        @"LANG_txt_empty_serial_number"
#define LANG_TXT_DUPLICATE_SERIAL_NUMBER                    @"LANG_txt_duplicate_serial_number"
#define LANG_TXT_INVALID_SERIAL_NUMBER                      @"LANG_txt_invalid_serialnumber"
#define LANG_TXT_CREDIT_CARD_DETAILS_NOT_AVAILABLE          @"LANG_txt_credit_card_details_not_available"
#define LANG_TXT_INVALID_POST_DATA                          @"LANG_txt_invalid_post_data"
#define LANG_TXT_AUTH_FAILED                                @"LANG_txt_auth_failed"
#define LANG_TXT_DATA_NOT_FOUND                             @"LANG_txt_data_not_found"
#define LANG_TXT_CARD_LIMIT_EXCEEDED                        @"LANG_txt_card_limit_exceeded"
#define CONST_SERVER_ALLOWED_CARDS                          @"allowed_cards"
#define CONST_SERVER_EXCEED_BY                              @"exceed_by"
#define CONST_SERVER_ERROR_MESSAGES                         @"error_messages"

#pragma mark - Start Session
#define LANG_TXT_STATION_PORT_ALREADY_CHARGING              @"LANG_txt_station_port_already_charging"
#define LANG_TXT_CONTACT_ERROR_TRY_AGAIN                    @"LANG_txt_contact_error_try_again"
#define LANG_TXT_SESSION_COULD_NOT_BE_STARTED               @"LANG_txt_session_could_not_be_started"
#define LANG_TXT_FREE_USER_CANNOT_START_CHARGING            @"LANG_txt_free_user_can_not_start_charging"
#define LANG_TXT_STATION_RESERVED_BY_OTHER_CARD             @"LANG_txt_station_reseved_by_other_card"
#define LANG_TXT_RESERVATION_REQUIRED                       @"LANG_txt_resevation_required"
#define LANG_TXT_STATION_SERIAL_SESSION_ACTIVE              @"LANG_txt_station_serial_session_active"
#define LANG_TXT_VIRTUAL_CARD_DOES_NOT_EXISTS               @"LANG_txt_virtual_card_does_not_exists"
#define LANG_TXT_VIRTUAL_CARD_SESSION_IN_PROGRESS           @"LANG_txt_virtual_card_session_in_progress"
#define LANG_TXT_STATION_ERROR_SESSION_START                @"LANG_txt_station_error_session_start"

#pragma mark -     Stop Session
#define LANG_TXT_STATION_PORT_NOT_CHARGING                  @"LANG_txt_station_port_not_charging"
#define LANG_TXT_SESSION_COULD_NOT_BE_STOPPED               @"LANG_txt_session_could_not_be_stopped"

#pragma mark    -   My Account
#define CONST_GET_SUBSCRIBER_DETAILS                        @"get_subscriber_details"
#define CONST_SET_SUBSCRIBER_DETAILS                        @"set_subscriber_details"
#define CONST_HAS_SHIPPING_ADDRESS                          @"has_shipping_address"
#define CONST_MOBILE_NUMBER                                 @"mobile_num"
#define CONST_CP_CARD_COST                                  @"cp_card_cost"
#define CONST_SERVER_COUNTRY                                @"country"
#define CONST_SERVER_STATE                                  @"state"

#define CONST_SERVER_CONTACT_ADDRESS                               @"contact"
#define CONST_SERVER_IS_SHIPPING_ADDRESS_SAME_AS_CONTACT_ADDRESS   @"is_shipping_address_same"
#define CONST_CC_LAST_FOUR_DIGITS                           @"cc_last_four"
#define CONST_SERVER_ACCOUNT_NUMBER                         @"account_num"
#define CONST_SERVER_USER_INFO                              @"user_info"
#define CONST_SERVER_MOBILE                                 @"mobile"
#define CONST_SERVER_MOBILE_FULL                            @"mobile_full"

#define CONST_GETUSER_NOTIFICATIONS                         @"get_user_notifications"
#define CONST_SETUSER_NOTIFICATIONS                         @"set_user_notifications"

#pragma mark - Shipping Address
#define CONST_SERVER_SHIPPING_ADDRESS                       @"shipping"
#define CONST_SERVER_SHIPPING_ADDRESS_LINE_ONE              @"s_address1"
#define CONST_SERVER_SHIPPING_ADDRESS_LINE_TWO              @"s_address2"
#define CONST_SERVER_SHIPPING_ADDRESS_CITY                  @"s_city"
#define CONST_SERVER_SHIPPING_ADDRESS_COUNTRY               @"s_country"
#define CONST_SERVER_SHIPPING_ADDRESS_COUNTRY_ID            @"s_country_id"
#define CONST_SERVER_SHIPPING_ADDRESS_STATE                 @"s_state"
#define CONST_SERVER_SHIPPING_ADDRESS_STATE_ID              @"s_state_id"
#define CONST_SERVER_SHIPPING_ADDRESS_ZIPCODE               @"s_zipcode"

#pragma mark - Security Question
#define CONST_SERVER_SECURITY_QUESTION_TEXT                 @"question_text"
#define CONST_SERVER_SECURITY_QUESTION_ID                   @"security_question_id"
#define CONST_SERVER_SECURITY_ANSWER                        @"security_answer"

#pragma mark - User Profile Progress
#define CONST_SERVER_USER_PROFILE_PROGRESS                  @"user_profile_progress"
#define CONST_SERVER_USER_PROFILE_PROGRESS_TOTAL            @"total"
#define CONST_SERVER_USER_PROFILE_PROGRESS_COMPLETED        @"completed"

#pragma mark - over_all_stats
#define CONST_SERVER_OVER_ALL_STATS                         @"over_all_stats"
#define CONST_SERVER_TOTAL_CHARGE_UP                        @"total_charge_up"

#pragma mark - EV Details
#define CONST_SERVER_USER_VEHICLES                          @"user_vehicles"
#define CONST_SERVER_USER_VEHICLE                           @"user_vehicle"
#define CONST_SERVER_EV_BATTERY_CAPACITY                    @"battery_capacity"
#define CONST_SERVER_EV_CHARGING_SPEED                      @"charging_speed"
#define CONST_SERVER_EV_TYPE                                @"ev_type"
#define CONST_SERVER_EV_MAKE_ID                             @"make_id"
#define CONST_SERVER_EV_MAKE_NAME                           @"make_name"
#define CONST_SERVER_EV_MODEL_ID                            @"model_id"
#define CONST_SERVER_EV_MODEL_NAME                          @"model_name"
#define CONST_SERVER_YEAR                                   @"year"
#define CONST_SERVER_IS_PRIMARY_VEHICLE                     @"is_primary_vechicle"
#define CONST_SERVER_INCLUDE_MAP_BOUND                      @"include_map_bound"

#define CONST_SERVER_USER_CARDS                             @"user_cards"

#pragma mark - Security Question
#define CONST_SERVER_SECURITY_INFO                          @"security_info"
#define CONST_SERVER_QUESTION_ID                            @"question_id"
#define CONST_SERVER_QUESTION_TEXT                          @"question_text"
#define CONST_SERVER_SECURITY_ANSWER                        @"security_answer"

#pragma mark - Financial info
#define CONST_SERVER_FINANCIAL_INFO                          @"financial_info"
#define CONST_SERVER_ACCOUNT_BALANCE                         @"acc_balance"
#define CONST_SERVER_CC_LAST_FOUR_DIGITS                     @"cc_last_four"
#define CONST_SERVER_GET_SECURITY_QUESTION_LIST              @"get_security_que_list"
#define CONST_SERVER_QUESTION_LIST                           @"question_list"
#define CONST_SERVER_ACCOUNT_TYPE                            @"account_type"
#define CONST_SERVER_CAN_ACTIVATE                            @"can_activate"

#define CONST_SERVER_GENDER_FEMALE                          @"F"
#define CONST_SERVER_GENDER_MALE                            @"M"
#define CONST_SERVER_GENDER_OTHERS                          @"O"

#pragma mark - Dial code
#define LANG_TXT_DIALING_CODE_REQUIRED                      @"LANG_txt_dialing_code_required"
#define LANG_TXT_INVALID_DIALING_CODE                       @"LANG_txt_invalid_dialing_code"


#pragma mark - Mobile number
#define LANG_TXT_MOBILE_REQUIRED                                @"LANG_txt_mobile_required"
#define LANG_TXT_MOBILE_LEN_FALL_SHORT_OR_INVALID               @"LANG_txt_mobile_len_fall_short_or_invalid_ext"
#define LANG_TXT_MOBILE_LEN_SHORT_OR_INVALID                    @"LANG_txt_mobile_len_exceeded_or_invalid_ext"
#define LANG_TXT_INVALID_MOBILE                                 @"LANG_txt_invalid_mobile"

#pragma MARK - Security Q & A
#define LANG_TXT_SECURITY_QUES_ID_REQUIRED                      @"LANG_txt_question_id_required"
#define LANG_TXT_SECURITY_ANSWER_REQUIRED                       @"LANG_txt_security_answer_required"

#pragma mark - free cards
#define LANG_TXT_USER_ALREADY_HAS_FREE_CARDS                @"LANG_txt_user_already_have_free_cards"

#pragma mark - purchase card using existing cc
#define LANG_TXT_CC_TIME_OUT                                    @"LANG_txt_CC_time_out"
#define LANG_TXT_CC_MISSING_FIELDS                              @"LANG_txt_CC_missing_fields"
#define LANG_TXT_CC_INCORRECT_INFORMAITON                       @"LANG_txt_CC_incorrect_information"
#define LANG_TXT_CC_UNABLE_TO_VERIFY                            @"LANG_txt_CC_unable_to_verify"
#define LANG_TXT_CC_ADDRESS_DOES_NOT_MATCH                      @"LANG_txt_CC_address_does_not_match"
#define LANG_TXT_CC_CALL_ISSUING_BANK                           @"LANG_txt_CC_call_issuing_bank"
#define LANG_TXT_CC_CARD_EXPIRED                                @"LANG_txt_CC_card_expired"
#define LANG_TXT_CC_REQUEST_DECLINED                            @"LANG_txt_CC_request_declined"
#define LANG_TXT_CC_INSUFFICIENT_FUNDS                          @"LANG_txt_CC_insufficent_funds"
#define LANG_TXT_CC_ENTER_VALID_FOUR_DIGIT_CODE                 @"LANG_txt_CC_enter_valid_four_digit_code"
#define LANG_TXT_CC_ENTER_VALID_THREE_DIGIT_CODE                @"LANG_txt_CC_enter_valid_three_digit_code"
#define LANG_TXT_CC_REQUEST_DECLINED_CALL_BANK                  @"LANG_txt_CC_request_declined_call_bank"
#define LANG_TXT_CC_ENTER_VALID_NUMBER                          @"LANG_txt_CC_enter_valid_number"
#define LANG_TXT_CC_ENTER_VALID_TYPE                            @"LANG_txt_CC_enter_valid_type"
#define LANG_TXT_CC_PROCESSING_ERROR                            @"LANG_txt_CC_processing_error"
#define LANG_TXT_CC_TYPE_INVALID                                @"LANG_txt_CC_type_invalid"
#define LANG_TXT_CC_REQUEST_ALREADY_RECEIVED                    @"LANG_txt_CC_request_already_received"
#define LANG_TXT_USER_AUTHENTICATION_FAILED                     @"LANG_txt_user_authentication_failed"
#define LANG_TXT_REFERENCEID_NOT_FOUND                          @"LANG_txt_referenceid_not_found"

#define LANG_TXT_NOTIFICATION_EMAIL_REQUIRED                          @"LANG_txt_notification_email_required"
#define LANG_TXT_NOTIFICATION_COUNTRY_CODE_REQUIRED                          @"LANG_txt_country_code_required"
#define LANG_TXT_NOTIFICATION_INVALID_COUNTRY_CODE                          @"LANG_txt_invalid_country_code"
#define LANG_TXT_NOTIFICATION_INVALID_EMAIL                          @"LANG_txt_invalid_notification_email"
#define LANG_TXT_NOTIFICATION_MOBILE_REQUIRED                          @"LANG_txt_notification_mobile_required"
#define LANG_TXT_NOTIFICATION_INVALID_NOTIFICATION_MOBILE                          @"LANG_txt_invalid_notification_mobile"
#define LANG_TXT_NOTIFICATION_MOBILE_LEN_FALL_SHORT_INVALID_EXT                          @"LANG_txt_notification_mobile_len_fall_short_or_invalid_ext"
#define LANG_TXT_NOTIFICATION_MOBILE_LEN_EXCEEDED_INVALID_EXT                          @"LANG_txt_notification_mobile_len_exceeded_or_invalid_ext"
#define LANG_TXT_INTERNAL_SERVER_ERROR                                @"LANG_txt_internal_server_error"
#define LANG_TXT_MAKE_REQUIRED                          @"LANG_txt_make_required"
#define LANG_TXT_INVALID_MAKE                          @"LANG_txt_invalid_make"
#define LANG_TXT_MODEL_REQUIRED                          @"LANG_txt_model_required"
#define LANG_TXT_INVALID_MODEL                          @"LANG_txt_invalid_model"
#define LANG_TXT_INVALID_YEAR                                @"LANG_txt_invalid_year"
#define LANG_TXT_YEAR_REQUIRED                           @"LANG_txt_year_required"
#define LANG_TXT_INVALID_GENDER                           @"LANG_txt_invalid_gender"