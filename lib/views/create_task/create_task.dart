import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/app_text.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/providers/mission_model.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  CreateTaskState createState() => CreateTaskState();
}

class CreateTaskState extends State<CreateTask> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MissionModel>(context, listen: false)
          .updateMissionType(MissionType.none);
    });
  }

  Color getCardColor(MissionType missionType) {
    switch (missionType) {
      case MissionType.daily:
        return AppColors.daily;
      case MissionType.weekly:
        return AppColors.weekly;
      case MissionType.monthly:
        return AppColors.monthly;
      case MissionType.regular:
        return AppColors.regular;
      default:
        return AppColors.daily;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget header = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
              text: "Mission Creation",
              textStyle: textTheme.displaySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary)),
          AppText(
              text: "What kind of mission is this?",
              textStyle: textTheme.bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary))
        ]);

    Widget missionTypeSelection = Consumer<MissionModel>(
        builder: (context, mission, child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                runSpacing: 4,
                children: [
                  FilterChip(
                    label: AppText(
                        text: "Daily",
                        textStyle: textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onTertiary)),
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
                            color: Theme.of(context).colorScheme.onTertiary)),
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
                              color: Theme.of(context).colorScheme.onTertiary)),
                      selected: mission.missionType == MissionType.monthly,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                              color: mission.missionType == MissionType.regular
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer
                                  : Theme.of(context).colorScheme.onTertiary)),
                      selected: mission.missionType == MissionType.regular,
                      selectedColor: AppColors.regular,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      onSelected: (value) {
                        if (value) {
                          mission.updateMissionType(MissionType.regular);
                        }
                      },
                      showCheckmark: false)
                ],
              ),
            ));

    Widget action = Consumer<MissionModel>(
        builder: (context, mission, child) => FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (mission.missionType == MissionType.none) {
                      return Colors.grey.withOpacity(0.8);
                    }
                    return Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(1); // Use the component's default.
                  },
                ),
              ),
              onPressed: mission.missionType == MissionType.none
                  ? null
                  : () {
                      GoRouter.of(context).goNamed('create-task-details');
                    },
              child: AppText(
                  text: "Continue",
                  textStyle: textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary)),
            ));

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: Center(
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
            const SizedBox(height: 8),
            missionTypeSelection,
            const SizedBox(height: 12),
            action
          ],
        )));
  }
}
