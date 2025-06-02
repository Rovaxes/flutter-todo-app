import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/app_text.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/providers/mission_model.dart';
import 'package:todo_app/providers/missions_model.dart';

class TaskDetails extends StatefulWidget {
  final int index;

  const TaskDetails({super.key, required this.index});

  @override
  TaskDetailsState createState() => TaskDetailsState();
}

class TaskDetailsState extends State<TaskDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text =
        Provider.of<MissionModel>(context, listen: false).missionName;
    _descriptionController.text =
        Provider.of<MissionModel>(context, listen: false).missionDescription;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget header = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
              text: "Mission Details",
              textStyle: textTheme.displaySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary)),
        ]);

    Widget missionTitleForm = Consumer<MissionModel>(
        builder: (context, mission, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Column(children: [
              AppText(
                  text: "Mission Name",
                  textStyle: textTheme.bodyMedium!.copyWith()),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: textTheme.bodyMedium!.copyWith(),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: textTheme.bodyMedium!
                        .copyWith(color: Colors.grey.withOpacity(0.8)),
                    hintText: "Mission Title"),
                onChanged: (value) => mission.updateMissionName(value),
              ),
            ])));

    Widget missionDescriptionForm = Consumer<MissionModel>(
        builder: (context, mission, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Column(children: [
              AppText(
                  text: "Mission description",
                  textStyle: textTheme.bodyMedium!.copyWith()),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                style: textTheme.bodyMedium!.copyWith(),
                maxLines: 6,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText:
                      "Ex: complete 100 pushups before the end of the day",
                  hintStyle: textTheme.bodyMedium!
                      .copyWith(color: Colors.grey.withOpacity(0.8)),
                ),
                onChanged: (value) => mission.updateMissionDescription(value),
              )
            ])));

    Widget missionRewardsSelection = Consumer<MissionModel>(
        builder: (context, mission, child) => Column(children: [
              AppText(
                  text: "Mission expierence", textStyle: textTheme.bodyMedium!),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      FilterChip(
                        label: AppText(
                            text: "+10",
                            textStyle: textTheme.bodyMedium!.copyWith(
                                color: mission.expierence == 10
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                    : Theme.of(context)
                                        .colorScheme
                                        .onTertiary)),
                        selected: mission.expierence == 10,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        onSelected: (value) {
                          if (value) {
                            mission.updateExpierence(10);
                          }
                        },
                        iconTheme: null,
                      ),
                      FilterChip(
                        label: AppText(
                            text: "+25",
                            textStyle: textTheme.bodyMedium!.copyWith(
                                color: mission.expierence == 25
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                    : Theme.of(context)
                                        .colorScheme
                                        .onTertiary)),
                        selected: mission.expierence == 25,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        onSelected: (value) {
                          if (value) {
                            mission.updateExpierence(25);
                          }
                        },
                        iconTheme: null,
                      ),
                      FilterChip(
                          label: AppText(
                              text: "+50",
                              textStyle: textTheme.bodyMedium!.copyWith(
                                  color: mission.expierence == 50
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .onTertiary)),
                          selected: mission.expierence == 50,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          onSelected: (value) {
                            if (value) {
                              mission.updateExpierence(50);
                            }
                          }),
                      FilterChip(
                          label: AppText(
                              text: "+100",
                              textStyle: textTheme.bodyMedium!.copyWith(
                                  color: mission.expierence == 100
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .onTertiary)),
                          selected: mission.expierence == 100,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          onSelected: (value) {
                            if (value) {
                              mission.updateExpierence(100);
                            }
                          })
                    ],
                  ),
                )
              ])
            ]));

    Widget missionTypeSelection = Consumer<MissionModel>(
        builder: (context, mission, child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Column(children: [
                AppText(text: "Mission type", textStyle: textTheme.bodyMedium!),
                const SizedBox(
                  height: 8,
                ),
                Row(children: [
                  Expanded(
                      child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      FilterChip(
                        label: AppText(
                            text: "Daily",
                            textStyle: textTheme.bodyMedium!.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onTertiary)),
                        selected: mission.missionType == MissionType.daily,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        selectedColor: AppColors.daily,
                        onSelected: (value) {
                          if (value) {
                            mission.updateMissionType(MissionType.daily);
                          }
                        },
                        iconTheme: null,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: AppText(
                            text: "Weekly",
                            textStyle: textTheme.bodyMedium!.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onTertiary)),
                        selectedColor: AppColors.weekly,
                        selected: mission.missionType == MissionType.weekly,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        onSelected: (value) {
                          if (value) {
                            mission.updateMissionType(MissionType.weekly);
                          }
                        },
                        iconTheme: null,
                        showCheckmark: false,
                      ),
                      FilterChip(
                          label: AppText(
                              text: "Monthly",
                              textStyle: textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiary)),
                          selected: mission.missionType == MissionType.monthly,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          selectedColor: AppColors.monthly,
                          onSelected: (value) {
                            if (value) {
                              mission.updateMissionType(MissionType.monthly);
                            }
                          },
                          showCheckmark: false),
                      FilterChip(
                          label: AppText(
                              text: "Regular",
                              textStyle: textTheme.bodyMedium!.copyWith(
                                  color:
                                      mission.missionType == MissionType.regular
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer
                                          : Theme.of(context)
                                              .colorScheme
                                              .onTertiary)),
                          selected: mission.missionType == MissionType.regular,
                          selectedColor: AppColors.regular,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          onSelected: (value) {
                            if (value) {
                              mission.updateMissionType(MissionType.regular);
                            }
                          },
                          showCheckmark: false)
                    ],
                  ))
                ])
              ]),
            ));

    Widget action = Consumer2<MissionsModel, MissionModel>(
        builder: (context, missions, mission, child) => FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (mission.missionType == MissionType.none ||
                          mission.missionName.isEmpty ||
                          mission.expierence <= 0) {
                        return Colors.grey.withOpacity(0.8);
                      }
                      return Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(1); // Use the component's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: mission.missionType == MissionType.none ||
                      mission.missionName.isEmpty ||
                      mission.expierence <= 0
                  ? null
                  : () {
                      missions.removeMissionAtIndex(widget.index);
                      missions.addMission(MissionModel(
                          missionName: mission.missionName,
                          missionCategory: MissionCategory.other,
                          missionDescription: mission.missionDescription,
                          missionType: mission.missionType,
                          expierence: mission.expierence));
                      Navigator.of(context).pop();
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Fluttertoast.showToast(
                            msg: "Mission Updated",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontAsset: "Segoe UI",
                            fontSize: 16.0);
                      });
                    },
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: AppText(
                      text: "Update Mission",
                      textStyle: textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary))),
            ));

    Widget delete = Consumer2<MissionsModel, MissionModel>(
        builder: (context, missions, mission, child) => FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return Theme.of(context)
                          .colorScheme
                          .error
                          .withOpacity(1); // Use the component's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: mission.missionType == MissionType.none ||
                      mission.missionName.isEmpty ||
                      mission.expierence <= 0
                  ? null
                  : () {
                      missions.removeMissionAtIndex(widget.index);
                      Navigator.of(context).pop();
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Fluttertoast.showToast(
                            msg: "Mission Deleted",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    },
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: AppText(
                      text: "Delete",
                      textStyle: textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary))),
            ));

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: Center(
            child: SizedBox(
                width: 380,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        GoRouter.of(context).pushReplacementNamed('home');
                      },
                      tooltip: 'Go Back',
                      child: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    const SizedBox(height: 24),
                    header,
                    const SizedBox(height: 12),
                    Card.outlined(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: Column(children: [
                              missionTitleForm,
                              const SizedBox(height: 12),
                              missionDescriptionForm,
                              const SizedBox(height: 12),
                              Row(children: [
                                Expanded(child: missionRewardsSelection)
                              ]),
                              const SizedBox(height: 12),
                            ]))),
                    Card.outlined(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 2),
                            child: missionTypeSelection)),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(children: [
                        Expanded(child: delete),
                        const SizedBox(width: 8),
                        Expanded(child: action)
                      ]),
                    )
                  ],
                ))));
  }
}
