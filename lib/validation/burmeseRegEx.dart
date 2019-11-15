class burmeseRegEx
{
  bool validateMmInput(String value) {
    Pattern pattern = '[က-အ]+';
    RegExp regex = new RegExp(pattern,unicode: true);
    if (!regex.hasMatch(value)){
      return true;
    }
    else
      return false;
  }
  bool validateMmNumberInput(String value) {
    Pattern pattern = '[၀-၉]+';
    RegExp regex = new RegExp(pattern,unicode: true);
    if (!regex.hasMatch(value)){
      return true;
    }
    else
      return false;
  }
}