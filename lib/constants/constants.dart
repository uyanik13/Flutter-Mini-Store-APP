class Constants {
  //static const String RestApiUrl = 'http://10.0.2.2:8000'; //LOCALHOST
  //static const String RestApiUrl = '192.168.56.1:8000'; //LOCALHOST
  static const String RestApiUrl = 'https://dromarketer.com'; //SERVER

}

class APIEndpoints {
  //================ AUTH =======================================
  static const String LOGIN = "/api/login";
  static const String REGISTER = "/api/register";

  //================ USER =======================================
  static const String FORGOT_PASSWORD = "/api/password/email";
  static const String CURRENT_USER = "/api/user";
  static const String MAX_DEBTS_USERS = "/api/maxDebtUsers";
  static const String USERS = "/api/users";
  static const String USER_IMAGE_UPDATE = "/api/userImageUpload";
  static const String FETCH_USERS_BY_KEY_FOR_STORES = "/api/fetchUsersByKey";

  //================ SETTING =======================================
  static const String ADD_SETTINGS = "/api/updateSetting";
  static const String DELETE_SETTINGS = "/api/deleteSetting";
  static const String FETCH_SETTINGS = "/api/fetchSettings";
  static const String CURRENT_USER_SETTINGS = "/api/currentUserSettings";
  static const String CURRENT_USER_SETTINGS_UPDATE = "/api/currentUserSettingsUpdate";
  static const String FETCH_CITIES = "/api/cities";

  //================ INVOICE =======================================
   static const String INVOICE = "/api/invoice";
   static const String INVOICE_STATUS = "/api/invoice?status=";
   static const String UPDATE_DEVICE_TOKEN = "/api/updateDeviceToken";
   static const String FETCH_INVOICES_BY_OPTIONS = "/api/fetchInvoicesByOptions";
   static const String FETCH_INVOICES_BY_ID = "/api/fetchInvoicesById";
   static const String FETCH_INVOICES_BY_ID_FOR_STORES = "/api/storeInvoiceFetchById";

}


class APIUrls {
  static const String LOGIN_URL = Constants.RestApiUrl+APIEndpoints.LOGIN;
  static const String REGISTER_URL  = Constants.RestApiUrl+APIEndpoints.REGISTER;
  static const String FORGOT_PASSWORD_URL  = Constants.RestApiUrl+APIEndpoints.FORGOT_PASSWORD;
  static const String CURRENT_USER_URL  = Constants.RestApiUrl+APIEndpoints.CURRENT_USER;
  static const String USERS_URL  = Constants.RestApiUrl+APIEndpoints.USERS;
  static const String MAX_DEBTS_USERS_URL  = Constants.RestApiUrl+APIEndpoints.MAX_DEBTS_USERS;
  static const String USER_IMAGE_UPDATE_URL  = Constants.RestApiUrl+APIEndpoints.USER_IMAGE_UPDATE;
  static const String UPDATE_DEVICE_TOKEN_URL  = Constants.RestApiUrl+APIEndpoints.UPDATE_DEVICE_TOKEN;
  static const String FETCH_INVOICES_BY_OPTIONS_URL  = Constants.RestApiUrl+APIEndpoints.FETCH_INVOICES_BY_OPTIONS;
  static const String FETCH_INVOICES_BY_ID_FOR_STORES_URL  = Constants.RestApiUrl+APIEndpoints.FETCH_INVOICES_BY_ID_FOR_STORES;
  static const String FETCH_USERS_BY_KEY_FOR_STORES_URL  = Constants.RestApiUrl+APIEndpoints.FETCH_USERS_BY_KEY_FOR_STORES;
  static const String FETCH_INVOICES_BY_ID_URL  = Constants.RestApiUrl+APIEndpoints.FETCH_INVOICES_BY_ID;
  static const String ADD_SETTINGS_URL  = Constants.RestApiUrl+APIEndpoints.ADD_SETTINGS;
  static const String DELETE_SETTING_URL  = Constants.RestApiUrl+APIEndpoints.DELETE_SETTINGS;
  static const String FETCH_SETTINGS_URL  = Constants.RestApiUrl+APIEndpoints.FETCH_SETTINGS;
  static const String CURRENT_USER_SETTINGS_URL  = Constants.RestApiUrl+APIEndpoints.CURRENT_USER_SETTINGS;
  static const String CURRENT_USER_SETTINGS_UPDATE_URL  = Constants.RestApiUrl+APIEndpoints.CURRENT_USER_SETTINGS_UPDATE;
  static const String FETCH_CITIES_URL  = Constants.RestApiUrl+APIEndpoints.FETCH_CITIES;
  static const String INVOICE_URL  = Constants.RestApiUrl+APIEndpoints.INVOICE;
  static const String INVOICE_STATUS_URL  = Constants.RestApiUrl+APIEndpoints.INVOICE_STATUS;

}

