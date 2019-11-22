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
  bool validateMmBoyName(String value) {
    Pattern pattern = 'မောင်[က-အ]+';
    RegExp regex = new RegExp(pattern,unicode: true);
    if (!regex.hasMatch(value)){
      return true;
    }
    else
      return false;
  }
  bool validateMmGirlName(String value) {
    Pattern pattern = 'မ[က-အ]+';
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
  bool validateUNO(String value) {
    Pattern pattern = 'သနတ- [0-9]{4}';
    RegExp regex = new RegExp(pattern,unicode: true);
    if (!regex.hasMatch(value)){
      return true;
    }
    else
      return false;
  }
}