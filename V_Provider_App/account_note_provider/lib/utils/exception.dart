//Todo: AuthenException
class AuthException implements Exception {
  final String code;
  final String message;

  AuthException(this.message, this.code);
}

//Todo: ApiException
class ApiException implements Exception {
  final String code;
  final String message;

  ApiException(
    this.code,
    this.message,
  );
}
