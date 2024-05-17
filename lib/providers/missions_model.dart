import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/providers/mission_model.dart';

class MissionsModel extends ChangeNotifier {
  final List<MissionModel> _missions = [
    MissionModel(
        missionName: "Do 100 pushups",
        missionDescription: "Perform 100 pushups before the end of the day",
        missionType: MissionType.daily,
        expierence: 10),
    MissionModel(
        missionName: "Practice guitar for 3 hours this week",
        missionDescription:
            "The sessions should involve scales, solos, and jam sessions.",
        missionType: MissionType.weekly,
        expierence: 25),
    MissionModel(
        missionName: "Read a book",
        missionDescription: "The book should be atleast 200 pages long.",
        missionType: MissionType.monthly,
        expierence: 50),
    MissionModel(
        missionName: "Launch your first game",
        missionDescription:
            "This is a long process involving learning game development in Unreal Engine.",
        missionType: MissionType.regular,
        expierence: 100)
  ];
  List<MissionModel> get missions => _missions;

  final Set<MissionType> _filters = {};
  Set<MissionType> get filters => _filters;

  void addMission(MissionModel mission) {
    _missions.add(mission);
    inspect(_missions);
    notifyListeners();
  }

  void removeMissionAtIndex(int index) {
    _missions.removeAt(index);
    notifyListeners();
  }

  void addFilter(MissionType missionType) {
    _filters.add(missionType);
    notifyListeners();
  }

  void removeFilter(MissionType missionType) {
    _filters.remove(missionType);
    notifyListeners();
  }
}
