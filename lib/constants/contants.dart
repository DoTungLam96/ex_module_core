const String KEY_GENERATE_UUID = "KEY_GENERATE_UUID";

const String kTheme = "theme";
const String kLanguage = "language";
const List<String> IGNORE_AUTH_401 = [
  "/authentication/api/v1/refresh-token",
  "/users/auth/me"
];

// Default app channel to request SAS APIs
const String APP_CHANNEL = 'iBoard';

const String KEY_ACCESS_TOKEN = "KEY_ACCESS_TOKEN";

const List<String> SAS_API_PATHS = [
  "/authentication/api/v1/login",
  "/users/account-management/change-password",
  "/users/account-management/no-auth/reset-password"
];

class Constants {
  Constants._();
  static const loginScreen = '/login/loginScreen';
  static const homePage = '/home/homePage';
}
