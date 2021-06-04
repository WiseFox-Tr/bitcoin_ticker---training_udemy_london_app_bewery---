import 'package:bitcoin_ticker/dataResources/AppConst.dart';

class ErrorManager {
  static String getErrorForUser(String exceptionMessage) {
    return exceptionMessage.contains("Failed host lookup") ? AppConst.strCheckInternetConnectionError : AppConst.strDefaultError;
  }
}
