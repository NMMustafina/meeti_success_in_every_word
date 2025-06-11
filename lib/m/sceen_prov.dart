import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scenrio {
  final int idd;
  final String nme;
  final String descrption;
  final String evntGoal;
  final String mnetaryGoal;
  final String businesStyle;
  final DateTime slectedDate;
  final DateTime slectedTime;
  final bool? isRated;
  final String? assessmentText;
  final String? assessmentProfit;

  Scenrio({
    required this.idd,
    required this.nme,
    required this.descrption,
    required this.evntGoal,
    required this.mnetaryGoal,
    required this.businesStyle,
    required this.slectedDate,
    required this.slectedTime,
    this.isRated,
    this.assessmentText,
    this.assessmentProfit,
  });

  Map<String, dynamic> toJsn() {
    return {
      'idd': idd,
      'nme': nme,
      'descrption': descrption,
      'evntGoal': evntGoal,
      'mnetaryGoal': mnetaryGoal,
      'businesStyle': businesStyle,
      'slectedDate': slectedDate.toIso8601String(),
      'slectedTime': slectedTime.toIso8601String(),
      'isRated': isRated,
      'assessmentText': assessmentText,
      'assessmentProfit': assessmentProfit,
    };
  }

  factory Scenrio.fromJsn(Map<String, dynamic> jsn) {
    return Scenrio(
      idd: jsn['idd'],
      nme: jsn['nme'],
      descrption: jsn['descrption'],
      evntGoal: jsn['evntGoal'],
      mnetaryGoal: jsn['mnetaryGoal'],
      businesStyle: jsn['businesStyle'],
      slectedDate: DateTime.parse(jsn['slectedDate']),
      slectedTime: DateTime.parse(jsn['slectedTime']),
      isRated: jsn['isRated'],
      assessmentText: jsn['assessmentText'],
      assessmentProfit: jsn['assessmentProfit'],
    );
  }

  Scenrio cpyWith({
    int? idd,
    String? nme,
    String? descrption,
    String? evntGoal,
    String? mnetaryGoal,
    String? businesStyle,
    DateTime? slectedDate,
    DateTime? slectedTime,
    bool? isRated,
    String? assessmentText,
    String? assessmentProfit,
  }) {
    return Scenrio(
      idd: idd ?? this.idd,
      nme: nme ?? this.nme,
      descrption: descrption ?? this.descrption,
      evntGoal: evntGoal ?? this.evntGoal,
      mnetaryGoal: mnetaryGoal ?? this.mnetaryGoal,
      businesStyle: businesStyle ?? this.businesStyle,
      slectedDate: slectedDate ?? this.slectedDate,
      slectedTime: slectedTime ?? this.slectedTime,
      isRated: isRated,
      assessmentText: assessmentText,
      assessmentProfit: assessmentProfit,
    );
  }
}

class ScenrioProvaider extends ChangeNotifier {
  List<Scenrio> _scenrios = [];
  final String _strageKey = 'scenrios';

  List<Scenrio> get scenrios => _scenrios;

  ScenrioProvaider() {
    _lodScenrios();
  }

  Future<void> _lodScenrios() async {
    final prefs = await SharedPreferences.getInstance();
    final String? scenriosJsn = prefs.getString(_strageKey);

    if (scenriosJsn != null) {
      final List<dynamic> decodedLst = jsonDecode(scenriosJsn);
      _scenrios = decodedLst.map((itm) => Scenrio.fromJsn(itm)).toList();
      notifyListeners();
    }
  }

  Future<void> _savScenrios() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> scenriosMap =
        _scenrios.map((scenrio) => scenrio.toJsn()).toList();
    await prefs.setString(_strageKey, jsonEncode(scenriosMap));
  }

  Future<void> adScenrio(Scenrio scenrio) async {
    _scenrios.add(scenrio);
    await _savScenrios();
    notifyListeners();
  }

  Future<void> updteScenrio(Scenrio updtedScenrio) async {
    final indx =
        _scenrios.indexWhere((scenrio) => scenrio.idd == updtedScenrio.idd);

    if (indx != -1) {
      _scenrios[indx] = updtedScenrio;
      await _savScenrios();
      notifyListeners();
    }
  }

  Future<void> dletScenrio(int idd) async {
    _scenrios.removeWhere((scenrio) => scenrio.idd == idd);
    await _savScenrios();
    notifyListeners();
  }
}
