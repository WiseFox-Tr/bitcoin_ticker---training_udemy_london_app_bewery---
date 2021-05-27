class ErrorManager {
  static const String baseErrorMessage = "Oups, nous n'avons pas réussi à récupérer les données";

  static String getErrorForUser(String exceptionMessage) {
    if(exceptionMessage.contains("Failed host lookup"))
      return "$baseErrorMessage, pensez à vérifier votre connexion internet ou réessayez plus tard.";
    else
      return '$baseErrorMessage, réessayez plus tard !';
  }
}
