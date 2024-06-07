// ignore_for_file: unnecessary_getters_setters

class WalletModel {
  String? _earnings;
  String? _withdral;
  String? _balance;
  String? _currentEarning;

  WalletModel(
      {String? earnings,
      String? withdral,
      String? balance,
      String? currentEarning}) {
    if (earnings != null) {
      _earnings = earnings;
    }
    if (withdral != null) {
      _withdral = withdral;
    }
    if (balance != null) {
      _balance = balance;
    }
    if (currentEarning != null) {
      _currentEarning = currentEarning;
    }
  }

  String? get earnings => _earnings;
  set earnings(String? earnings) => _earnings = earnings;
  String? get withdral => _withdral;
  set withdral(String? withdral) => _withdral = withdral;
  String? get balance => _balance;
  set balance(String? balance) => _balance = balance;
  String? get currentEarning => _currentEarning;
  set currentEarning(String? currentEarning) =>
      _currentEarning = currentEarning;

  WalletModel.fromJson(Map<String, dynamic> json) {
    _earnings = json['earnings'];
    _withdral = json['withdral'];
    _balance = json['balance'];
    _currentEarning = json['current_earning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['earnings'] = _earnings;
    data['withdral'] = _withdral;
    data['balance'] = _balance;
    data['current_earning'] = _currentEarning;
    return data;
  }
}
