import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mortgage {
  final String title;
  final String amount;
  final String rate;
  final String term;
  final DateTime date;
  double alreadyPaid;

  Mortgage({
    required this.title,
    required this.amount,
    required this.rate,
    required this.term,
    required this.date,
    required this.alreadyPaid,
  });
}

class MortgageProvider extends ChangeNotifier {
  final List<Mortgage> _mortgages = [];

  List<Mortgage> get mortgages => _mortgages;

  Future<void> updateAlreadyPaid(int index, double newAlreadyPaid) async {
    if (index >= 0 && index < _mortgages.length) {
      _mortgages[index].alreadyPaid = newAlreadyPaid;
      notifyListeners();
      await saveMortgagesToPrefs();
    }
  }

  Future<void> addMortgage(Mortgage mortgage) async {
    _mortgages.add(mortgage);
    notifyListeners();
    await saveMortgagesToPrefs();
  }

  Future<void> saveMortgagesToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mortgageStrings =
        _mortgages.map((mortgage) => _serializeMortgage(mortgage)).toList();
    await prefs.setStringList('mortgages', mortgageStrings);
  }

  Future<void> loadMortgagesFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? mortgageStrings = prefs.getStringList('mortgages');
    if (mortgageStrings != null) {
      _mortgages.clear();
      for (String mortgageString in mortgageStrings) {
        _mortgages.add(_deserializeMortgage(mortgageString));
      }
      notifyListeners();
    }
  }

  String _serializeMortgage(Mortgage mortgage) {
    return "${mortgage.title},${mortgage.amount},${mortgage.rate},${mortgage.term},${mortgage.date.millisecondsSinceEpoch},${mortgage.alreadyPaid}";
  }

  Mortgage _deserializeMortgage(String mortgageString) {
    List<String> parts = mortgageString.split(',');
    String title = parts[0];
    String amount = parts[1];
    String rate = parts[2];
    String term = parts[3];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(parts[4]));
    double alreadyPaid = double.parse(parts[5]);

    // Проверяем, есть ли уже ипотека с таким же названием
    Mortgage existingMortgage = _mortgages.firstWhere(
      (mortgage) => mortgage.title == title,
      orElse: () => Mortgage(
        title: title,
        amount: amount,
        rate: rate,
        term: term,
        date: date,
        alreadyPaid: alreadyPaid,
      ),
    );

    // Если уже есть ипотека с таким же названием, обновляем alreadyPaid
    if (_mortgages.contains(existingMortgage)) {
      existingMortgage.alreadyPaid = alreadyPaid;
      return existingMortgage;
    } else {
      // Если ипотеки с таким названием еще нет, создаем новую
      return Mortgage(
        title: title,
        amount: amount,
        rate: rate,
        term: term,
        date: date,
        alreadyPaid: alreadyPaid,
      );
    }
  }

  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> removeMortage(int index) async {
    _mortgages.removeAt(index);
    notifyListeners();
    await saveMortgagesToPrefs();
  }

  void addPayment(int mortgageIndex, double paymentAmount) {
    mortgages[mortgageIndex].alreadyPaid += paymentAmount;
  }
}
