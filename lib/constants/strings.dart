class Strings {
  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Cancel';

  // Logout
  static const String logout = 'Logout';
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';
  static const String logoutFailed = 'Logout failed';

  // Sign In Page
  static const String signIn = 'Sign in';
  static const String signInWithEmailPassword =
      'Sign in with email and password';
  static const String signInWithEmailLink = 'Sign in with email link';
  static const String signInWithFacebook = 'Sign in with Facebook';
  static const String signInWithGoogle = 'Sign in with Google';
  static const String goAnonymous = 'Go anonymous';
  static const String or = 'or';

  // Register Page
  static const String register = 'Register';
  static const String forgotPassword = 'Forgot password';
  static const String forgotPasswordQuestion = 'Forgot password?';
  static const String createAnAccount = 'Create an account';
  static const String needAnAccount = 'Need an account? Register';
  static const String haveAnAccount = 'Have an account? Sign in';
  static const String signInFailed = 'Sign in failed';
  static const String invalidEmailPassword = 'Invalid email or password.';
  static const String registrationFailed = 'Registration failed';
  static const String passwordResetFailed = 'Password reset failed';
  static const String sendResetLink = 'Send Reset Link';
  static const String backToSignIn = 'Back to sign in';
  static const String resetLinkSentTitle = 'Reset link sent';
  static const String resetLinkSentMessage =
      'Check your email to reset your password';
  static const String emailLabel = 'Email';
  static const String emailHint = 'test@test.com';
  static const String password6CharactersLabel = 'Password (6+ characters)';
  static const String passwordLabel = 'Password';
  static const String invalidEmailErrorText = 'Email is invalid';
  static const String invalidEmailEmpty = 'Email can\'t be empty';
  static const String invalidPasswordTooShort = 'Password is too short';
  static const String invalidPasswordEmpty = 'Password can\'t be empty';

  // Email link page
  static const String submitEmailAddressLink =
      'Submit your email address to receive an activation link.';
  static const String checkYourEmail = 'Check your email';
  static String activationLinkSent(String email) =>
      'We have sent an activation link to $email';
  static const String errorSendingEmail = 'Error sending email';
  static const String sendActivationLink = 'Send activation link';
  static const String activationLinkError = 'Email activation error';
  static const String submitEmailAgain =
      'Please submit your email address again to receive a new activation link.';
  static const String userAlreadySignedIn =
      'Received an activation link but you are already signed in.';
  static const String isNotSignInWithEmailLinkMessage =
      'Invalid activation link';

  // Home page
  static const String homePage = 'Home Page';

  // Developer menu
  static const String developerMenu = 'Developer menu';
  static const String authenticationType = 'Authentication type';
  static const String firebase = 'Firebase';
  static const String mock = 'Mock';

  //APP TEXT
  static const String welcome = 'Welcome';
  static const String underWelcomeText = 'You can look your invoices.';
  static const String usageAmount = 'Usage Amount :';
  static const String usagePerPrice = 'Usage Per Price :';
  static const String usagePrice = 'Price :';
  static const String invoiceDate = 'Invoice Date :';
  static const String invoiceLastPaymentDate = 'Invoice Last Payment Date :';
  static const String invoiceId = 'Invoice Id :';
  static const String invoiceStatus = 'Invoice Status :';
  static const String description = 'Description :';
  static const String youHaveA = 'You have a';
  static const String invoice = 'Invoice';
  static const String invoices = 'Invoices';
  static const String profile = 'Profile';
  static const String reminder = 'Reminder';
  static const String invoiceAddWarning = 'Please Add an Invoice Name ';
  static const String invoiceTypeWarning = 'Please Select an Invoice Type ';
  static const String invoiceUserWarning = 'Please Select an User ';
  static const String invoiceAmountWarning = 'Please Type Usage Amount';
  static const String onlyCanSeeAdmins = 'Only Can See Admins';
  static const String onlyCanArchiveAdmins = 'Only Can Archive Admins';
  static const String onlyCanDeleteAdmins = 'Only Can Delete Admins';
  static const String warning = 'Warning';
  static const String success = 'Success';
  static const String successfullyUpdated = 'Successfully Updated';
  static const String successfullyDeleted = 'Successfully Deleted';
  static const String youHaveNotInternetConnection = 'You Have Not Internet Connection';
  static const String credentialsDoNotMatch = 'These credentials do not match our records.';
  static const String somethingWentWrong = 'Something Went Wrong';

}
