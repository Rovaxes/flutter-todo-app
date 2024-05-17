import 'package:flutter/material.dart';

enum MissionType { daily, weekly, monthly, regular, none }

enum MissionCategory { fitness, other }

class MissionModel extends ChangeNotifier {
  String _missionName = "Mission To Compelete";
  String _missionDescription =
      "Complete this mission and gain some expierence!";
  MissionType _missionType = MissionType.regular;
  MissionCategory _missionCategory = MissionCategory.other;
  double _expierence = 0;

  String get missionName => _missionName;
  String get missionDescription => _missionDescription;
  MissionType get missionType => _missionType;
  MissionCategory get missionCategory => _missionCategory;
  double get expierence => _expierence;

  MissionModel(
      {String missionName = "Sample",
      String missionDescription = "Sample",
      MissionType missionType = MissionType.regular,
      MissionCategory missionCategory = MissionCategory.other,
      double expierence = 0}) {
    _missionName = missionName;
    _missionDescription = missionDescription;
    _missionType = missionType;
    _missionCategory = missionCategory;
    _expierence = expierence;
  }

  void setMission(MissionModel mission) {
    _missionName = mission.missionName;
    _missionDescription = mission.missionDescription;
    _missionType = mission.missionType;
    _missionCategory = mission.missionCategory;
    _expierence = mission.expierence;
  }

  void updateMissionType(MissionType type) {
    _missionType = type;
    notifyListeners();
  }

  void updateMissionName(String value) {
    _missionName = value;
    notifyListeners();
  }

  void updateMissionDescription(String value) {
    _missionDescription = value;
    notifyListeners();
  }

  void updateExpierence(double value) {
    _expierence = value;
    notifyListeners();
  }
}
